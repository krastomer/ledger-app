import 'package:ledger_app/data/services/ocr_line.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_party.dart';

import 'parsed_slip.dart';
import 'slip_layout.dart';
import 'slip_page.dart';
import 'slip_text.dart';

/// SCB EASY transfer slips.
///
/// Layout: centered status, date and `รหัสอ้างอิง: <ref>`; then rows with
/// a label on the left (`จาก`, `ไปยัง`, `จำนวนเงิน`) and the value
/// right-aligned, parties spanning two lines (name, account).
class ScbSlipLayout implements SlipLayout {
  const ScbSlipLayout();

  static final _reference = RegExp(r'รหัสอ้างอิง\s*:?\s*(\S+)');
  static final _fileReference = RegExp(r'^TXN_(\w+)$');

  @override
  bool matches(SlipPage page) => page.find(_reference) != null;

  @override
  ParsedSlip parse(SlipPage page, {String? fileStem}) {
    final confidence = <SlipField, double>{};

    final dateLine = page.lines
        .where((l) => SlipText.timestamp(l.text) != null)
        .firstOrNull;
    if (dateLine != null) confidence[SlipField.timestamp] = dateLine.confidence;

    String? reference;
    final fileMatch = fileStem == null
        ? null
        : _fileReference.firstMatch(fileStem);
    if (fileMatch != null) {
      reference = fileMatch.group(1);
      confidence[SlipField.reference] = 1;
    } else {
      final line = page.find(_reference);
      if (line != null) {
        reference = _reference.firstMatch(line.text)!.group(1);
        confidence[SlipField.reference] = line.confidence;
      }
    }

    final fromLabel = page.label('จาก');
    final toLabel = page.label('ไปยัง');
    final amountLabel = page.label('จำนวนเงิน');

    final amountLine = amountLabel == null
        ? null
        : page.rightOf(
            amountLabel,
            where: (l) => SlipText.isMoney(l.text, plainCurrency: 'THB'),
          );
    if (amountLine != null) {
      confidence[SlipField.amount] = amountLine.confidence;
    }

    return ParsedSlip(
      Slip(
        source: SlipSource.scb,
        kind: SlipKind.transfer,
        timestamp: dateLine == null ? null : SlipText.timestamp(dateLine.text),
        reference: reference,
        amount: amountLine == null
            ? null
            : SlipText.money(amountLine.text, plainCurrency: 'THB'),
        from: _party(
          page,
          fromLabel,
          until: toLabel,
          SlipField.from,
          confidence,
        ),
        to: _party(page, toLabel, until: amountLabel, SlipField.to, confidence),
      ),
      confidence: confidence,
    );
  }

  /// Right-hand lines from [label]'s row down to the next label.
  static SlipParty? _party(
    SlipPage page,
    OcrLine? label,
    SlipField field,
    Map<SlipField, double> confidence, {
    required OcrLine? until,
  }) {
    if (label == null) return null;
    final block = page.within(
      top: label.y - 0.01,
      bottom: until?.y ?? label.y + 0.1,
      left: label.right + 0.05,
    );
    if (block.isEmpty) return null;
    final account = block
        .skip(1)
        .where((l) => SlipText.isAccount(l.text))
        .lastOrNull;
    confidence[field] = block.first.confidence;
    return SlipParty(
      name: SlipText.cleanName(block.first.text),
      account: account == null ? null : SlipText.account(account.text),
    );
  }
}
