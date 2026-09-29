import 'money.dart';
import 'slip_order.dart';
import 'slip_party.dart';

/// Which app produced the slip.
enum SlipSource { kbank, scb, kkp, dime }

/// What the slip records.
enum SlipKind { transfer, payment, buy, sell }

/// Transaction data read from one slip image. Fields are null when the
/// slip doesn't show them or they couldn't be read.
class Slip {
  const Slip({
    required this.source,
    required this.kind,
    this.timestamp,
    this.reference,
    this.amount,
    this.fee,
    this.from,
    this.to,
    this.order,
  });

  final SlipSource source;
  final SlipKind kind;

  /// When the transaction happened, in UTC.
  final DateTime? timestamp;

  /// Bank reference / order ID; used to detect duplicate imports.
  final String? reference;

  /// Total in THB (always positive; [kind] says which way it went).
  final Money? amount;

  final Money? fee;
  final SlipParty? from;
  final SlipParty? to;

  /// Set for broker order confirmations ([SlipKind.buy] / [SlipKind.sell]).
  final SlipOrder? order;

  @override
  bool operator ==(Object other) =>
      other is Slip &&
      other.source == source &&
      other.kind == kind &&
      other.timestamp == timestamp &&
      other.reference == reference &&
      other.amount == amount &&
      other.fee == fee &&
      other.from == from &&
      other.to == to &&
      other.order == order;

  @override
  int get hashCode => Object.hash(
    source,
    kind,
    timestamp,
    reference,
    amount,
    fee,
    from,
    to,
    order,
  );

  @override
  String toString() =>
      'Slip(${source.name} ${kind.name}, $timestamp, ref $reference, '
      '$amount, fee $fee, from $from, to $to, $order)';
}
