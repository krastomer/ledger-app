import 'package:ledger_app/data/services/ocr_line.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_party.dart';

import 'parsed_slip.dart';
import 'slip_layout.dart';
import 'slip_page.dart';
import 'slip_text.dart';

/// KKP (Dime! Save) transfer slips.
///
/// Layout: `Transfer`, amount and `Fee x THB` top-left; `From` / `To`
/// labels with name right of them and the masked account below the name;
/// `Date` and `Slip ID` labels with values right of them.
class KkpSlipLayout implements SlipLayout {
  const KkpSlipLayout();

  static final _fee = RegExp(r'^Fee\s+(.+)$');

  @override
  bool matches(SlipPage page) =>
      page.label('Slip ID') != null && page.label('From') != null;

  @override
  ParsedSlip parse(SlipPage page, {String? fileStem}) {
    final confidence = <SlipField, double>{};

    final dateLine = _valueRightOf(page, 'Date');
    final timestamp = dateLine == null
        ? null
        : SlipText.timestamp(dateLine.text);
    if (timestamp != null) {
      confidence[SlipField.timestamp] = dateLine!.confidence;
    }

    // The filename (`DM...`) is not the slip ID, so only OCR is used here.
    final referenceLine = _valueRightOf(page, 'Slip ID');
    if (referenceLine != null) {
      confidence[SlipField.reference] = referenceLine.confidence;
    }

    final amountLine = page.find(RegExp(r'^[\d,]+\.\d{2}\s*THB$'));
    if (amountLine != null) {
      confidence[SlipField.amount] = amountLine.confidence;
    }

    final feeLine = page.find(_fee);
    final fee = feeLine == null
        ? null
        : SlipText.money(_fee.firstMatch(feeLine.text.trim())!.group(1)!);
    if (fee != null) confidence[SlipField.fee] = feeLine!.confidence;

    return ParsedSlip(
      Slip(
        source: SlipSource.kkp,
        kind: SlipKind.transfer,
        timestamp: timestamp,
        reference: referenceLine?.text.trim(),
        amount: amountLine == null ? null : SlipText.money(amountLine.text),
        fee: fee,
        from: _party(page, 'From', SlipField.from, confidence),
        to: _party(page, 'To', SlipField.to, confidence),
      ),
      confidence: confidence,
    );
  }

  static OcrLine? _valueRightOf(SlipPage page, String label) {
    final labelLine = page.label(label);
    return labelLine == null ? null : page.rightOf(labelLine);
  }

  static SlipParty? _party(
    SlipPage page,
    String label,
    SlipField field,
    Map<SlipField, double> confidence,
  ) {
    final name = _valueRightOf(page, label);
    if (name == null) return null;
    final account = page.below(
      name,
      where: (l) => SlipText.isAccount(l.text),
      maxGap: 0.04,
    );
    confidence[field] = name.confidence;
    return SlipParty(
      name: SlipText.cleanName(name.text),
      account: account == null ? null : SlipText.account(account.text),
    );
  }
}
