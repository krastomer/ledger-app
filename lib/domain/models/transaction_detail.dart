import 'package:freezed_annotation/freezed_annotation.dart';

import 'ledger_transaction.dart';
import 'transaction_summary.dart';

part 'transaction_detail.freezed.dart';

@freezed
abstract class TransactionDetail with _$TransactionDetail {
  const factory TransactionDetail({
    required LedgerTransaction transaction,
    required TransactionSummary summary,
  }) = _TransactionDetail;
}
