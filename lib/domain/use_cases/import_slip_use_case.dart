import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/data/repositories/slip/slip_repository.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/money.dart' as slip_money;
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_draft.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/utils/result.dart';
import 'package:ledger_app/utils/uuid.dart';
import 'package:money2/money2.dart';

/// OCR → parse → dedupe → save, one slip image at a time.
class ImportSlipUseCase {
  ImportSlipUseCase({
    required this._slipRepository,
    required this._ledgerRepository,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  /// Slips print Thai time.
  static const _thaiOffset = Duration(hours: 7);
  static const uncategorized = 'Expenses:Uncategorized';
  static const fees = 'Expenses:Fees';

  final SlipRepository _slipRepository;
  final LedgerRepository _ledgerRepository;
  final DateTime Function() _now;

  Future<Result<List<String>>> pickImages() => _slipRepository.pickImages();

  Future<Result<SlipDraft>> read(String imagePath) async {
    final parsed = await _slipRepository.read(imagePath);
    final transactions = await _ledgerRepository.getTransactions();
    return switch ((parsed, transactions)) {
      (Ok(value: final parsed), Ok(value: final transactions)) => Result.ok(
        _draft(imagePath, parsed, transactions),
      ),
      (Error(:final error), _) ||
      (_, Error(:final error)) => Result.error(error),
    };
  }

  Future<Result<void>> save(LedgerTransaction transaction) =>
      _ledgerRepository.save(transaction);

  SlipDraft _draft(
    String imagePath,
    ParsedSlip parsed,
    List<LedgerTransaction> ledger,
  ) {
    final slip = parsed.slip;
    final reference = slip.reference;
    final description = _description(slip);
    final source = _sourceAccount(slip.source);
    final newestFirst = ledger.reversed.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    final samePayee = newestFirst
        .where((t) => t.description == description && t.postings.length >= 2)
        .firstOrNull;
    final counter = switch (slip.kind) {
      SlipKind.transfer || SlipKind.payment =>
        samePayee?.postings
            .where((p) => p.amount.isPositive)
            .firstOrNull
            ?.account,
      SlipKind.buy || SlipKind.sell => _pairedWith(source, newestFirst),
    };
    final amount = slip.amount;
    return SlipDraft(
      imagePath: imagePath,
      parsed: parsed,
      transaction: amount == null
          ? null
          : _transaction(
              slip,
              description: description,
              amount: _money(amount),
              fee: switch (slip.fee) {
                final fee? when fee.minorUnits > 0 => _money(fee),
                _ => null,
              },
              source: source,
              counter: counter ?? uncategorized,
            ),
      duplicate: reference == null
          ? null
          : ledger.where((t) => t.code == reference).firstOrNull,
      sourceAccount: source,
      categoryFromHistory: counter != null,
      accounts: ({
        for (final t in ledger)
          for (final p in t.postings) p.account,
        source,
      }.toList()..sort()),
    );
  }

  LedgerTransaction _transaction(
    Slip slip, {
    required String description,
    required Money amount,
    required Money? fee,
    required String source,
    required String counter,
  }) {
    final (debit, credit) = slip.kind == SlipKind.buy
        ? (source, counter)
        : (counter, source);
    final local = slip.timestamp?.toUtc().add(_thaiOffset);
    final today = _now();
    return LedgerTransaction(
      id: uuidV7(now: today),
      date: local == null
          ? DateTime(today.year, today.month, today.day)
          : DateTime(local.year, local.month, local.day),
      time: local == null
          ? null
          : Duration(hours: local.hour, minutes: local.minute),
      description: description,
      status: TransactionStatus.pending,
      code: slip.reference,
      postings: [
        Posting(account: debit, amount: amount),
        if (fee != null) Posting(account: fees, amount: fee),
        Posting(
          account: credit,
          amount: -(fee == null ? amount : amount + fee),
        ),
      ],
    );
  }

  static String _description(Slip slip) => switch (slip.kind) {
    SlipKind.transfer ||
    SlipKind.payment => slip.to?.name ?? slip.from?.name ?? slip.source.name,
    SlipKind.buy || SlipKind.sell => [
      slip.kind == SlipKind.buy ? 'Buy' : 'Sell',
      ?slip.order?.symbol,
      ?slip.order?.quantity,
      ?slip.order?.unit,
    ].join(' '),
  };

  /// The bank or broker account a slip from [source] moves money in.
  static String _sourceAccount(SlipSource source) => switch (source) {
    SlipSource.kbank => 'Assets:Bank:KBank',
    SlipSource.scb => 'Assets:Bank:SCB',
    SlipSource.kkp => 'Assets:Bank:KKP',
    SlipSource.dime => 'Assets:Investments:Dime',
  };

  /// The account most recently on the other side of [account].
  static String? _pairedWith(String account, List<LedgerTransaction> ledger) {
    for (final t in ledger) {
      if (t.postings.length != 2) continue;
      final accounts = [for (final p in t.postings) p.account];
      if (accounts.contains(account)) {
        return accounts.firstWhere((a) => a != account, orElse: () => account);
      }
    }
    return null;
  }

  static Money _money(slip_money.Money amount) =>
      Money.fromInt(amount.minorUnits, isoCode: amount.currency);
}
