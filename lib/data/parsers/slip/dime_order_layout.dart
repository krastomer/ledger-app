import 'package:ledger_app/data/services/ocr_line.dart';
import 'package:ledger_app/domain/models/money.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_order.dart';

import 'parsed_slip.dart';
import 'slip_layout.dart';
import 'slip_page.dart';
import 'slip_text.dart';

/// Dime order screens for US stocks and MTS gold.
///
/// Layout: `Buy NVDA` / `Buy MTS-GOLD` with the THB total below it; then a
/// two-column table (label left, value right-aligned). Price and quantity
/// sit in a small grid, value below its label. The order ID wraps onto a
/// second line.
class DimeOrderLayout implements SlipLayout {
  const DimeOrderLayout();

  static final _side = RegExp(r'^(Buy|Sell)\s+(\S+)$');
  static final _fileReference = RegExp(r'^(STK|GLD)[A-Z0-9]+$');
  static final _exchangeRate = RegExp(r'=\s*([\d,]+(?:\.\d+)?)\s*THB');
  static final _quantityWithUnit = RegExp(r'^(\d+(?:\.\d+)?)\s*oz$');

  @override
  bool matches(SlipPage page) =>
      page.label('Order ID') != null && page.find(_side) != null;

  @override
  ParsedSlip parse(SlipPage page, {String? fileStem}) {
    final confidence = <SlipField, double>{};
    final sideLine = page.find(_side)!;
    final side = _side.firstMatch(sideLine.text.trim())!;
    final symbol = side.group(2)!;
    final isGold = page.label('Gold Amount') != null;

    final amountLine = page.below(
      sideLine,
      where: (l) => SlipText.money(l.text)?.currency == 'THB',
    );
    if (amountLine != null) {
      confidence[SlipField.amount] = amountLine.confidence;
    }

    final dateLine = _valueRightOf(
      page,
      isGold ? 'Order Match Date' : 'Completion date',
    );
    final timestamp = dateLine == null
        ? null
        : SlipText.timestamp(dateLine.text);
    if (timestamp != null) {
      confidence[SlipField.timestamp] = dateLine!.confidence;
    }

    final reference = _reference(page, fileStem, confidence);
    final order = _order(page, symbol, isGold: isGold, confidence: confidence);

    return ParsedSlip(
      Slip(
        source: SlipSource.dime,
        kind: side.group(1) == 'Buy' ? SlipKind.buy : SlipKind.sell,
        timestamp: timestamp,
        reference: reference,
        amount: amountLine == null ? null : SlipText.money(amountLine.text),
        fee: _fee(page, confidence),
        order: order,
      ),
      confidence: confidence,
    );
  }

  static SlipOrder _order(
    SlipPage page,
    String symbol, {
    required bool isGold,
    required Map<SlipField, double> confidence,
  }) {
    final priceLabel = page.label('Executed Price');
    final priceLine = priceLabel == null
        ? null
        : page.below(
            priceLabel,
            // Always USD; OCR sometimes garbles the unit.
            where: (l) =>
                SlipText.leadingMoney(l.text, currency: 'USD') != null,
          );
    if (priceLine != null) confidence[SlipField.price] = priceLine.confidence;

    // Same row as `Executed Price`; the order status text above also says
    // "shares".
    final quantityName = SlipText.skeleton(isGold ? 'Weight' : 'Shares');
    final quantityLabel = priceLabel == null
        ? null
        : page.rightOf(
            priceLabel,
            where: (l) => SlipText.skeleton(l.text) == quantityName,
          );
    final quantityLine = quantityLabel == null
        ? null
        : page.below(
            quantityLabel,
            where: (l) => isGold
                ? _quantityWithUnit.hasMatch(l.text.trim())
                : SlipText.isQuantity(l.text),
          );
    final quantity = quantityLine == null
        ? null
        : isGold
        ? _quantityWithUnit.firstMatch(quantityLine.text.trim())!.group(1)
        : quantityLine.text.trim();
    if (quantity != null) {
      confidence[SlipField.quantity] = quantityLine!.confidence;
    }

    final foreignLine = _valueRightOf(
      page,
      isGold ? 'Gold Amount' : 'USD Amount',
      where: (l) => SlipText.isMoney(l.text),
    );
    if (foreignLine != null) {
      confidence[SlipField.foreignAmount] = foreignLine.confidence;
    }

    final rateLine = _valueRightOf(page, 'Exchange Rate');
    final rate = rateLine == null
        ? null
        : _exchangeRate.firstMatch(rateLine.text)?.group(1);
    if (rate != null) confidence[SlipField.exchangeRate] = rateLine!.confidence;

    return SlipOrder(
      symbol: symbol,
      quantity: quantity,
      unit: isGold ? 'oz' : 'shares',
      price: priceLine == null
          ? null
          : SlipText.leadingMoney(priceLine.text, currency: 'USD'),
      foreignAmount: foreignLine == null
          ? null
          : SlipText.money(foreignLine.text),
      exchangeRate: rate,
    );
  }

  /// Order ID from the filename when it has one, else the OCR value plus
  /// its wrapped second line.
  static String? _reference(
    SlipPage page,
    String? fileStem,
    Map<SlipField, double> confidence,
  ) {
    if (fileStem != null && _fileReference.hasMatch(fileStem)) {
      confidence[SlipField.reference] = 1;
      return fileStem;
    }
    final first = _valueRightOf(page, 'Order ID');
    if (first == null) return null;
    final rest = page.below(
      first,
      where: (l) => RegExp(r'^[A-Z0-9]+$').hasMatch(l.text.trim()),
      maxGap: 0.01,
    );
    confidence[SlipField.reference] = first.confidence;
    return first.text.trim() + (rest?.text.trim() ?? '');
  }

  /// Commission, coupon discount and VAT, summed; the rows between
  /// `Commission Fee` and `VAT 7%` hold THB values in the right column.
  static Money? _fee(SlipPage page, Map<SlipField, double> confidence) {
    final first = page.label('Commission Fee');
    final last = page.label('VAT 7%');
    if (first == null || last == null) return null;
    final values = [
      for (final line in page.within(
        top: first.y - 0.005,
        bottom: last.bottom + 0.005,
        left: 0.5,
      ))
        ?SlipText.money(line.text),
    ].where((m) => m.currency == 'THB');
    if (values.isEmpty) return null;
    confidence[SlipField.fee] = 1;
    return values.reduce((a, b) => a + b);
  }

  static OcrLine? _valueRightOf(
    SlipPage page,
    String label, {
    bool Function(OcrLine)? where,
  }) {
    final labelLine = page.label(label);
    return labelLine == null ? null : page.rightOf(labelLine, where: where);
  }
}
