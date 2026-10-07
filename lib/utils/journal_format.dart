import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/utils/date_format.dart';
import 'package:money2/money2.dart';

/// [transaction] as hledger journal text, for showing and copying. The
/// last posting's amount is left out, as hledger infers it.
String formatJournalEntry(LedgerTransaction transaction) {
  final status = switch (transaction.status) {
    TransactionStatus.pending => ' !',
    TransactionStatus.cleared => ' *',
    TransactionStatus.unmarked => '',
  };
  final code = switch (transaction.code) {
    final code? => ' ($code)',
    null => '',
  };
  final time = switch (transaction.time) {
    final time? => '  ; time:${formatTime(time)}',
    null => '',
  };
  final date = formatIsoDate(transaction.date);
  final postings = transaction.postings;
  final width = postings.fold(
    0,
    (w, p) => p.account.length > w ? p.account.length : w,
  );
  return [
    '$date$status$code ${transaction.description}$time',
    for (final (index, p) in postings.indexed)
      index == postings.length - 1
          ? '    ${p.account}'
          : '    ${p.account.padRight(width)}  ${_amount(p.amount)}',
  ].join('\n');
}

String _amount(Money amount) {
  final sign = amount.isNegative ? '-' : '';
  final magnitude = (amount.isNegative ? -amount : amount).format('#,##0.00');
  return '${amount.currency.isoCode} $sign$magnitude';
}
