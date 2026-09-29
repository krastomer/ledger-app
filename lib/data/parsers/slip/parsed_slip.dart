import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_order.dart';

/// Fields a slip parser tries to fill.
enum SlipField {
  timestamp,
  reference,
  amount,
  fee,
  from,
  to,
  quantity,
  price,
  foreignAmount,
  exchangeRate,
}

/// A [Slip] plus how sure the parser is about it, so the UI can ask the
/// user to confirm or fill in fields before saving.
class ParsedSlip {
  ParsedSlip(this.slip, {Map<SlipField, double> confidence = const {}})
    : confidence = Map.unmodifiable(confidence),
      missing = Set.unmodifiable(_missing(slip));

  final Slip slip;

  /// OCR confidence (0..1) of the line each field was read from. Fields
  /// taken from the image filename count as 1.
  final Map<SlipField, double> confidence;

  /// Required fields for this kind of slip that couldn't be read.
  final Set<SlipField> missing;

  bool get isComplete => missing.isEmpty;

  static Set<SlipField> _missing(Slip slip) {
    final order = slip.order;
    return {
      if (slip.timestamp == null) SlipField.timestamp,
      if (slip.reference == null) SlipField.reference,
      if (slip.amount == null) SlipField.amount,
      ...switch (slip.kind) {
        SlipKind.transfer || SlipKind.payment => {
          if (slip.from == null) SlipField.from,
          if (slip.to == null) SlipField.to,
        },
        SlipKind.buy || SlipKind.sell => _missingOrder(order),
      },
    };
  }

  static Set<SlipField> _missingOrder(SlipOrder? order) => {
    if (order?.quantity == null) SlipField.quantity,
    if (order?.price == null) SlipField.price,
  };

  @override
  String toString() => 'ParsedSlip($slip, missing: $missing)';
}
