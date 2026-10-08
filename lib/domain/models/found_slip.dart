import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

import 'ledger_transaction.dart';
import 'slip.dart';
import 'slip_draft.dart';

part 'found_slip.freezed.dart';

enum FoundSlipGroup { transfer, payment, order, unsure }

/// A slip the photo scan read, ready to be imported into the inbox.
@freezed
abstract class FoundSlip with _$FoundSlip {
  const factory FoundSlip({required SlipDraft draft}) = _FoundSlip;

  const FoundSlip._();

  String get id => draft.imagePath;

  LedgerTransaction? get transaction => draft.transaction;

  /// False when the slip shows no amount, so there is nothing to book.
  bool get importable => transaction != null;

  FoundSlipGroup get group => transaction == null
      ? FoundSlipGroup.unsure
      : switch (draft.parsed.slip.kind) {
          SlipKind.transfer => FoundSlipGroup.transfer,
          SlipKind.payment => FoundSlipGroup.payment,
          SlipKind.buy || SlipKind.sell => FoundSlipGroup.order,
        };

  Money? get amount => switch (draft.parsed.slip.amount) {
    final amount? => Money.fromInt(amount.minorUnits, isoCode: amount.currency),
    null => null,
  };
}
