import 'dart:convert';

import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:money2/money2.dart';

import 'parsed_ledger.dart';

/// Reads the output of `hledger print -O json` (see sync.md, Pull).
///
/// hledger has already checked and balanced every transaction, so this only
/// maps it onto the domain model. Entries it can't represent (costs,
/// unbalanced virtual postings, unknown commodities) become issues.
class HledgerJsonParser {
  const HledgerJsonParser();

  ParsedLedger parse(String source) {
    final Object? json;
    try {
      json = jsonDecode(source);
    } on FormatException {
      return _malformed;
    }
    return json is List<Object?> ? _Reader().read(json) : _malformed;
  }

  static const _malformed = ParsedLedger(
    accounts: [],
    transactions: [],
    issues: [LedgerIssue(kind: LedgerIssueKind.malformed)],
  );
}

class _Invalid implements Exception {
  const _Invalid(this.kind);

  final LedgerIssueKind kind;
}

class _Reader {
  static const _symbols = {'฿': 'THB', r'$': 'USD', '€': 'EUR', '£': 'GBP'};
  static final _time = RegExp(r'^(\d{1,2}):(\d{2})$');

  final _types = <String, AccountType>{};
  final _transactions = <LedgerTransaction>[];
  final _issues = <LedgerIssue>[];

  ParsedLedger read(List<Object?> entries) {
    for (final (entry, json) in entries.indexed) {
      try {
        _transactions.add(_transaction(json));
      } on _Invalid catch (invalid) {
        _issues.add(LedgerIssue(entry: entry, kind: invalid.kind));
      }
    }
    return ParsedLedger(
      accounts: [
        for (final MapEntry(key: name, value: type) in _types.entries)
          Account(name: name, type: type),
      ],
      transactions: List.unmodifiable(_transactions),
      issues: List.unmodifiable(_issues),
    );
  }

  LedgerTransaction _transaction(Object? json) {
    if (json case {
      'tindex': int index,
      'tdate': String dateText,
      'tstatus': String status,
      'tcode': String code,
      'tdescription': String description,
      'ttags': List<Object?> tagList,
      'tpostings': List<Object?> postings,
    }) {
      final date = DateTime.tryParse(dateText);
      if (date == null) throw const _Invalid(LedgerIssueKind.malformed);
      final tags = {
        for (final tag in tagList)
          if (tag case [String name, String value]) name: value,
      };
      return LedgerTransaction(
        // Entries without an `id:` tag get a display-only key (sync.md).
        id: tags['id'] ?? 'T$index',
        date: DateTime(date.year, date.month, date.day),
        time: _parseTime(tags['time']),
        description: description,
        status: switch (status) {
          'Pending' => TransactionStatus.pending,
          'Cleared' => TransactionStatus.cleared,
          _ => TransactionStatus.unmarked,
        },
        code: code.isEmpty ? null : code,
        postings: [for (final posting in postings) ..._postings(posting)],
      );
    }
    throw const _Invalid(LedgerIssueKind.malformed);
  }

  /// A posting holding several commodities becomes one posting per
  /// commodity, which hledger treats the same way.
  Iterable<Posting> _postings(Object? json) sync* {
    if (json case {
      'paccount': String account,
      'ptype': String type,
      'pamount': List<Object?> amounts,
    }) {
      if (type == 'VirtualPosting') {
        throw const _Invalid(LedgerIssueKind.unsupportedVirtualPosting);
      }
      _recordType(account);
      for (final amount in amounts) {
        yield Posting(account: account, amount: _money(amount));
      }
      return;
    }
    throw const _Invalid(LedgerIssueKind.malformed);
  }

  void _recordType(String account) {
    final root = account.split(accountSeparator).first;
    final type = _types[root] ?? _typeFromRootName(root);
    if (type == null) throw const _Invalid(LedgerIssueKind.unknownAccountType);
    _types[root] = type;
  }

  Money _money(Object? json) {
    if (json case {
      'acommodity': String commodity,
      'acost': final Object? cost,
      'aquantity': {
        'decimalMantissa': int mantissa,
        'decimalPlaces': int places,
      },
    }) {
      if (cost != null) throw const _Invalid(LedgerIssueKind.unsupportedCost);
      final currency = Currencies().find(
        _symbols[commodity] ?? commodity.toUpperCase(),
      );
      if (currency == null) {
        throw const _Invalid(LedgerIssueKind.unsupportedCommodity);
      }
      // mantissa × 10^-places, rescaled to the currency's minor units.
      final shift = currency.decimalDigits - places;
      final scale = _pow10(shift.abs());
      if (shift < 0 && mantissa % scale != 0) {
        throw const _Invalid(LedgerIssueKind.badAmount);
      }
      final minorUnits = shift >= 0 ? mantissa * scale : mantissa ~/ scale;
      return Money.fromIntWithCurrency(minorUnits, currency);
    }
    throw const _Invalid(LedgerIssueKind.malformed);
  }

  static Duration? _parseTime(String? text) {
    final match = text == null ? null : _time.firstMatch(text);
    if (match == null) return null;
    final hours = int.parse(match.group(1) ?? '0');
    final minutes = int.parse(match.group(2) ?? '0');
    if (hours > 23 || minutes > 59) return null;
    return Duration(hours: hours, minutes: minutes);
  }

  static AccountType? _typeFromRootName(String root) =>
      switch (root.toLowerCase()) {
        'assets' || 'asset' => AccountType.asset,
        'liabilities' || 'liability' || 'debts' => AccountType.liability,
        'equity' => AccountType.equity,
        'income' || 'revenue' || 'revenues' => AccountType.income,
        'expenses' || 'expense' => AccountType.expense,
        _ => null,
      };

  static int _pow10(int exponent) {
    var result = 1;
    for (var i = 0; i < exponent; i++) {
      result *= 10;
    }
    return result;
  }
}
