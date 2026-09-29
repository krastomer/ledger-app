import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/data/parsers/slip/slip_parser.dart';
import 'package:ledger_app/data/services/ocr_line.dart';
import 'package:ledger_app/data/services/slip_ocr_service.dart';
import 'package:ledger_app/utils/result.dart';

/// Throwaway screen for checking OCR + parsing on real slips.
// TODO(kasama): replace with the slip import feature (MVVM, see
// .claude/rules/architecture.md) once the flow is settled.
class OcrTestPage extends StatefulWidget {
  const OcrTestPage({super.key, required this.ocr, required this.parser});

  final SlipOcrService ocr;
  final SlipParser parser;

  @override
  State<OcrTestPage> createState() => _OcrTestPageState();
}

class _OcrTestPageState extends State<OcrTestPage> {
  bool _busy = false;
  List<OcrLine>? _lines;
  ParsedSlip? _parsed;
  String? _error;
  Duration? _elapsed;

  Future<void> _pickAndRead() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null || !mounted) return;

    setState(() {
      _busy = true;
      _lines = null;
      _parsed = null;
      _error = null;
    });
    final watch = Stopwatch()..start();
    final result = await widget.ocr.recognize(image.path);
    if (!mounted) return;
    setState(() {
      _busy = false;
      _elapsed = watch.elapsed;
      switch (result) {
        case Ok(:final value):
          _lines = value;
          // image_picker copies the photo under a new name, so the
          // original filename (often the reference) isn't available here.
          _parsed = widget.parser.parse(value);
        case Error(:final error):
          _error = '$error';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final parsed = _parsed;
    return Scaffold(
      appBar: AppBar(title: const Text('Slip OCR test')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _busy ? null : _pickAndRead,
        icon: const Icon(Icons.photo),
        label: const Text('Pick slip'),
      ),
      body: _busy
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              children: [
                if (_elapsed != null)
                  Text(
                    '${_lines?.length ?? 0} lines · '
                    '${_elapsed!.inMilliseconds} ms',
                    style: theme.textTheme.labelMedium,
                  ),
                if (_error != null)
                  Text(
                    _error!,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                if (_lines == null && _error == null)
                  const Text('Pick a slip image to read it.'),
                if (_lines != null && parsed == null)
                  Text(
                    'No known slip layout',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                if (parsed != null) _ParsedSlipCard(parsed: parsed),
                if (_lines != null)
                  ExpansionTile(
                    title: const Text('OCR lines'),
                    children: [
                      for (final line in _lines!)
                        ListTile(
                          dense: true,
                          title: SelectableText(line.text),
                          trailing: Text(
                            (line.confidence * 100).toStringAsFixed(0),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
    );
  }
}

class _ParsedSlipCard extends StatelessWidget {
  const _ParsedSlipCard({required this.parsed});

  final ParsedSlip parsed;

  @override
  Widget build(BuildContext context) {
    final slip = parsed.slip;
    final order = slip.order;
    final theme = Theme.of(context);
    final rows = <(String, Object?)>[
      ('Source', '${slip.source.name} ${slip.kind.name}'),
      ('Time', slip.timestamp?.toLocal()),
      ('Reference', slip.reference),
      ('Amount', slip.amount),
      ('Fee', slip.fee),
      ('From', slip.from?.name),
      ('', slip.from?.account),
      ('To', slip.to?.name),
      ('', slip.to?.account),
      if (order != null) ...[
        ('Symbol', order.symbol),
        ('Quantity', '${order.quantity} ${order.unit}'),
        ('Price', order.price),
        ('Foreign', order.foreignAmount),
        ('Rate', order.exchangeRate),
      ],
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (label, value) in rows)
              if (value != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 88,
                      child: Text(label, style: theme.textTheme.labelMedium),
                    ),
                    Expanded(child: SelectableText('$value')),
                  ],
                ),
            if (parsed.missing.isNotEmpty)
              Text(
                'Missing: ${parsed.missing.map((f) => f.name).join(', ')}',
                style: TextStyle(color: theme.colorScheme.error),
              ),
          ],
        ),
      ),
    );
  }
}
