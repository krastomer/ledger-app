import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';

import 'ledger_transaction.dart';

part 'slip_draft.freezed.dart';

/// How a field read off a slip should be shown: fine, worth a look, or
/// not on this slip.
enum SlipFieldCheck { ok, check, absent }

/// A slip read from one image and the entry saving it would write.
@freezed
abstract class SlipDraft with _$SlipDraft {
  const factory SlipDraft({
    required String imagePath,
    required ParsedSlip parsed,

    /// Null when the slip shows no amount, so there is nothing to book.
    LedgerTransaction? transaction,

    /// The saved entry that already has this slip's reference.
    LedgerTransaction? duplicate,

    /// The bank or broker account the slip moves money in.
    required String sourceAccount,

    /// Whether the category came from an earlier entry for the same payee.
    required bool categoryFromHistory,

    /// Accounts already in use, to pick from.
    required List<String> accounts,
  }) = _SlipDraft;

  const SlipDraft._();

  /// OCR confidence below this asks the user to check the field.
  static const _sureEnough = 0.75;

  SlipFieldCheck checkOf(SlipField field) {
    if (parsed.missing.contains(field)) return SlipFieldCheck.check;
    if (!_hasValue(field)) return SlipFieldCheck.absent;
    return (parsed.confidence[field] ?? 1) < _sureEnough
        ? SlipFieldCheck.check
        : SlipFieldCheck.ok;
  }

  bool _hasValue(SlipField field) {
    final slip = parsed.slip;
    final order = slip.order;
    return switch (field) {
      SlipField.timestamp => slip.timestamp != null,
      SlipField.reference => slip.reference != null,
      SlipField.amount => slip.amount != null,
      SlipField.fee => slip.fee != null,
      SlipField.from => slip.from != null,
      SlipField.to => slip.to != null,
      SlipField.quantity => order?.quantity != null,
      SlipField.price => order?.price != null,
      SlipField.foreignAmount => order?.foreignAmount != null,
      SlipField.exchangeRate => order?.exchangeRate != null,
    };
  }
}
