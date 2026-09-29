import 'package:ledger_app/data/services/ocr_line.dart';
import 'package:ledger_app/domain/models/money.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_party.dart';

import 'parsed_slip.dart';
import 'slip_layout.dart';
import 'slip_page.dart';
import 'slip_text.dart';

/// KBank K PLUS transfer and payment slips.
///
/// Layout: status and date top-left; sender block then receiver block
/// (name, bank or company, account) in a column right of the bank logos;
/// then `เลขที่รายการ:`, `จำนวน:` and `ค่าธรรมเนียม:`, each with its value
/// on the next line.
class KplusSlipLayout implements SlipLayout {
  const KplusSlipLayout();

  static final _fileReference = RegExp(r'^\d{12}[A-Z]{3}\d{5}$');

  @override
  bool matches(SlipPage page) =>
      page.label('เลขที่รายการ:') != null && page.label('จำนวน:') != null;

  @override
  ParsedSlip parse(SlipPage page, {String? fileStem}) {
    final confidence = <SlipField, double>{};

    final dateLine = page.lines
        .where((l) => SlipText.timestamp(l.text) != null)
        .firstOrNull;
    if (dateLine != null) confidence[SlipField.timestamp] = dateLine.confidence;

    final referenceLabel = page.label('เลขที่รายการ:');
    String? reference;
    if (fileStem != null && _fileReference.hasMatch(fileStem)) {
      reference = fileStem;
      confidence[SlipField.reference] = 1;
    } else if (referenceLabel != null) {
      final line = page.below(referenceLabel);
      if (line != null) {
        reference = line.text.trim();
        confidence[SlipField.reference] = line.confidence;
      }
    }

    final amountLine = _moneyBelow(page, 'จำนวน:');
    final feeLine = _moneyBelow(page, 'ค่าธรรมเนียม:');
    if (amountLine != null) {
      confidence[SlipField.amount] = amountLine.confidence;
    }
    if (feeLine != null) confidence[SlipField.fee] = feeLine.confidence;

    final (from, to) = _parties(
      page,
      top: dateLine?.bottom ?? 0,
      bottom: referenceLabel?.y ?? 1,
      confidence: confidence,
    );

    return ParsedSlip(
      Slip(
        source: SlipSource.kbank,
        kind: page.label('ชำระเงินสำเร็จ') != null
            ? SlipKind.payment
            : SlipKind.transfer,
        timestamp: dateLine == null ? null : SlipText.timestamp(dateLine.text),
        reference: reference,
        amount: amountLine == null ? null : _baht(amountLine.text),
        fee: feeLine == null ? null : _baht(feeLine.text),
        from: from,
        to: to,
      ),
      confidence: confidence,
    );
  }

  static OcrLine? _moneyBelow(SlipPage page, String label) {
    final labelLine = page.label(label);
    if (labelLine == null) return null;
    return page.below(labelLine, where: (l) => _baht(l.text) != null);
  }

  // K PLUS always shows baht; OCR sometimes garbles the unit.
  static Money? _baht(String text) =>
      SlipText.leadingMoney(text, currency: 'THB');

  /// The sender and receiver blocks, split at the biggest vertical gap
  /// (where the arrow between them sits).
  static (SlipParty?, SlipParty?) _parties(
    SlipPage page, {
    required double top,
    required double bottom,
    required Map<SlipField, double> confidence,
  }) {
    // Text column starts right of the ~0.2-wide logo column; K+ badge and
    // merchant logos read as text sit outside it.
    final column = page.within(
      top: top,
      bottom: bottom,
      left: 0.18,
      right: 0.5,
    );
    if (column.length < 2) return (null, null);

    var split = 1;
    for (var i = 1; i < column.length; i++) {
      final gap = column[i].y - column[i - 1].bottom;
      if (gap > column[split].y - column[split - 1].bottom) split = i;
    }
    return (
      _party(column.sublist(0, split), SlipField.from, confidence),
      _party(column.sublist(split), SlipField.to, confidence),
    );
  }

  static SlipParty? _party(
    List<OcrLine> block,
    SlipField field,
    Map<SlipField, double> confidence,
  ) {
    if (block.isEmpty) return null;
    final name = block.first;
    final account = block
        .skip(1)
        .where((l) => SlipText.isAccount(l.text))
        .lastOrNull;
    confidence[field] = name.confidence;
    return SlipParty(
      name: SlipText.cleanName(name.text),
      account: account == null ? null : SlipText.account(account.text),
    );
  }
}
