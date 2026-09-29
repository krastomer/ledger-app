package com.example.ledger_app

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Color
import android.graphics.Rect
import android.os.Handler
import android.os.Looper
import com.googlecode.tesseract.android.TessBaseAPI
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.concurrent.Executors
import kotlin.math.roundToInt

/**
 * On-device OCR for slip images using Tesseract (Thai + English).
 *
 * Same contract as the iOS Vision implementation (ios/Runner/AppDelegate.swift):
 * `recognize(path)` returns one map per text line with `text`, `confidence`
 * (0..1) and `x`, `y`, `width`, `height` normalized to 0..1, origin top-left.
 */
class SlipOcrPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private val executor = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())

    // Created on the executor thread only; TessBaseAPI isn't thread-safe.
    private var tess: TessBaseAPI? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "ledger_app/slip_ocr")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        executor.execute {
            tess?.recycle()
            tess = null
        }
        executor.shutdown()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method != "recognize") {
            result.notImplemented()
            return
        }
        val path = call.arguments as? String
        if (path == null) {
            result.error("bad_args", "expected an image path", null)
            return
        }
        executor.execute {
            val reply: () -> Unit = try {
                val lines = recognize(path)
                ({ result.success(lines) })
            } catch (e: Exception) {
                ({ result.error("ocr_failed", e.message, null) })
            }
            mainHandler.post(reply)
        }
    }

    private fun recognize(path: String): List<Map<String, Any>> {
        val original = BitmapFactory.decodeFile(path)
            ?: throw IllegalArgumentException("cannot decode image")
        // Slip text is small (~25 px tall); Tesseract reads it far better
        // at about twice that.
        val scale = if (original.width < MIN_WIDTH) MIN_WIDTH.toDouble() / original.width else 1.0
        val bitmap = Bitmap.createScaledBitmap(
            original,
            (original.width * scale).roundToInt(),
            (original.height * scale).roundToInt(),
            true,
        ).copy(Bitmap.Config.ARGB_8888, true)
        original.recycle()
        binarize(bitmap)
        val api = engine()
        try {
            api.setImage(bitmap)
            api.getUTF8Text() // runs recognition
            val words = readWords(api)
            return segments(words).map { it.toMap(bitmap.width, bitmap.height) }
        } finally {
            api.clear()
            bitmap.recycle()
        }
    }

    /**
     * Turns the image black-on-white. Slip text is dark gray or saturated
     * green; the watermarks and patterns behind it are light, and Tesseract's
     * own thresholding picks them up as ink.
     */
    private fun binarize(bitmap: Bitmap) {
        val width = bitmap.width
        val row = IntArray(width)
        for (y in 0 until bitmap.height) {
            bitmap.getPixels(row, 0, width, 0, y, width, 1)
            for (x in 0 until width) {
                val p = row[x]
                val luma = (299 * (p shr 16 and 0xFF) + 587 * (p shr 8 and 0xFF) + 114 * (p and 0xFF)) / 1000
                row[x] = if (luma < INK_THRESHOLD) Color.BLACK else Color.WHITE
            }
            bitmap.setPixels(row, 0, width, 0, y, width, 1)
        }
    }

    /**
     * One Tesseract word. For Thai these are often single characters, so
     * [spaceBefore] records whether Tesseract's own line text puts a space
     * before it.
     */
    private class Word(
        val text: String,
        val confidence: Float,
        val box: Rect,
        val line: Int,
        val spaceBefore: Boolean,
    )

    private class Segment(val words: List<Word>) {
        /**
         * Joins words with a space where Tesseract put one, or where the image
         * shows a word-sized gap: Tesseract misses some spaces between Thai
         * words (`สมชายใ` for `สมชาย ใ`). Measured on sample slips, gaps inside a
         * Thai word stay under ~0.29 of the line height, gaps between words
         * are 0.3 and up; a colon or dot may sit further off without a space.
         */
        fun joinWords(): String = buildString {
            val lineHeight = words.maxOf { it.box.height() }
            for ((i, word) in words.withIndex()) {
                if (i > 0 && hasSpace(words[i - 1], word, lineHeight)) append(' ')
                append(word.text)
            }
        }

        private fun hasSpace(before: Word, word: Word, lineHeight: Int): Boolean {
            if (word.spaceBefore) return true
            if (word.text.first() in PUNCTUATION || before.text.last() in PUNCTUATION) return false
            return word.box.left - before.box.right >= lineHeight * SPACE_GAP
        }

        fun toMap(width: Int, height: Int): Map<String, Any> {
            val left = words.minOf { it.box.left }
            val top = words.minOf { it.box.top }
            val right = words.maxOf { it.box.right }
            val bottom = words.maxOf { it.box.bottom }
            return mapOf(
                "text" to joinWords(),
                "confidence" to words.minOf { it.confidence } / 100.0,
                "x" to left.toDouble() / width,
                "y" to top.toDouble() / height,
                "width" to (right - left).toDouble() / width,
                "height" to (bottom - top).toDouble() / height,
            )
        }
    }

    private fun readWords(api: TessBaseAPI): List<Word> {
        val words = mutableListOf<Word>()
        val iterator = api.resultIterator ?: return words
        val level = TessBaseAPI.PageIteratorLevel.RIL_WORD
        var line = -1
        var lineText = ""
        var cursor = 0
        iterator.begin()
        do {
            if (iterator.isAtBeginningOf(TessBaseAPI.PageIteratorLevel.RIL_TEXTLINE)) {
                line++
                lineText = iterator.getUTF8Text(TessBaseAPI.PageIteratorLevel.RIL_TEXTLINE).orEmpty()
                cursor = 0
            }
            val text = iterator.getUTF8Text(level)?.trim().orEmpty()
            if (text.isEmpty()) continue
            // Find the word in the line text to see whether a space precedes it.
            val at = lineText.indexOf(text, cursor)
            val spaceBefore = at < 0 || lineText.substring(cursor, at).any { it.isWhitespace() }
            if (at >= 0) cursor = at + text.length
            words += Word(
                text,
                iterator.confidence(level),
                iterator.getBoundingRect(level),
                line,
                spaceBefore,
            )
        } while (iterator.next(level))
        iterator.delete()
        return words
    }

    /**
     * Splits Tesseract's text lines where words are far apart, so a label and
     * its right-aligned value come back as separate lines, like Vision does.
     */
    private fun segments(words: List<Word>): List<Segment> {
        val result = mutableListOf<Segment>()
        for ((_, lineWords) in words.groupBy { it.line }) {
            val lineHeight = lineWords.map { it.box.height() }.sorted()[lineWords.size / 2]
            var current = mutableListOf(lineWords.first())
            for (word in lineWords.drop(1)) {
                val gap = word.box.left - current.last().box.right
                if (gap > lineHeight * SEGMENT_GAP) {
                    result += Segment(current)
                    current = mutableListOf()
                }
                current += word
            }
            result += Segment(current)
        }
        return result
    }

    private fun engine(): TessBaseAPI {
        tess?.let { return it }
        val dataDir = File(context.filesDir, "tesseract")
        copyModels(File(dataDir, "tessdata"))
        val api = TessBaseAPI()
        if (!api.init(dataDir.absolutePath, "tha+eng")) {
            api.recycle()
            throw IllegalStateException("Tesseract init failed")
        }
        api.pageSegMode = TessBaseAPI.PageSegMode.PSM_SPARSE_TEXT
        api.setVariable("preserve_interword_spaces", "1")
        tess = api
        return api
    }

    /** Tesseract needs the models as plain files, so copy them out of the APK once. */
    private fun copyModels(dir: File) {
        dir.mkdirs()
        for (name in context.assets.list("tessdata").orEmpty()) {
            val target = File(dir, name)
            if (target.exists()) continue
            val partial = File(dir, "$name.partial")
            context.assets.open("tessdata/$name").use { input ->
                partial.outputStream().use { input.copyTo(it) }
            }
            partial.renameTo(target)
        }
    }

    private companion object {
        /** Images narrower than this are upscaled before OCR. */
        const val MIN_WIDTH = 2000

        /**
         * Luma below this counts as ink. Measured on sample slips: gray and
         * green text stays under ~160, K PLUS's embossed background over it.
         */
        const val INK_THRESHOLD = 160

        /** A gap of this many line heights between words is a space. */
        const val SPACE_GAP = 0.3

        const val PUNCTUATION = ":.,"

        /** A gap wider than this many line heights starts a new segment. */
        const val SEGMENT_GAP = 1.2
    }
}
