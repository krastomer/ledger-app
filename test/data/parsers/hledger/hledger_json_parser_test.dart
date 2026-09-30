import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/parsers/hledger/hledger_json_parser.dart';
import 'package:ledger_app/data/parsers/hledger/parsed_ledger.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:money2/money2.dart';

Map<String, Object?> _amount(
  int mantissa, {
  int places = 2,
  String commodity = 'THB',
  Object? cost,
}) => {
  'acommodity': commodity,
  'acost': cost,
  'aquantity': {'decimalMantissa': mantissa, 'decimalPlaces': places},
};

Map<String, Object?> _posting(
  String account,
  List<Object?> amounts, {
  String type = 'RegularPosting',
}) => {'paccount': account, 'ptype': type, 'pamount': amounts};

Map<String, Object?> _transaction({
  int index = 1,
  String date = '2026-09-29',
  String status = 'Unmarked',
  String code = '',
  String description = 'Lunch',
  List<List<String>> tags = const [],
  List<Object?>? postings,
}) => {
  'tindex': index,
  'tdate': date,
  'tstatus': status,
  'tcode': code,
  'tdescription': description,
  'ttags': tags,
  'tpostings':
      postings ??
      [
        _posting('Expenses:Food', [_amount(6000)]),
        _posting('Assets:Bank:KBank', [_amount(-6000)]),
      ],
};

void main() {
  const parser = HledgerJsonParser();
  Money thb(int satang) => Money.fromInt(satang, isoCode: 'THB');
  ParsedLedger parse(List<Object?> json) => parser.parse(jsonEncode(json));

  test('maps a transaction onto the domain model', () {
    final ledger = parse([
      _transaction(
        index: 7,
        status: 'Pending',
        code: 'REF-1',
        description: 'Rent transfer',
        tags: [
          ['time', '09:15'],
          ['note', 'sep'],
        ],
      ),
    ]);

    expect(ledger.issues, isEmpty);
    final tx = ledger.transactions.single;
    expect(tx.id, 'T7');
    expect(tx.date, DateTime(2026, 9, 29));
    expect(tx.time, const Duration(hours: 9, minutes: 15));
    expect(tx.status, TransactionStatus.pending);
    expect(tx.code, 'REF-1');
    expect(tx.description, 'Rent transfer');
    expect(tx.postings.map((p) => (p.account, p.amount)), [
      ('Expenses:Food', thb(6000)),
      ('Assets:Bank:KBank', thb(-6000)),
    ]);
  });

  test('uses the id tag, and no code or time when absent', () {
    final ledger = parse([
      _transaction(
        status: 'Cleared',
        tags: [
          ['id', '0192f0a1-7b2c-7000-8000-000000000001'],
        ],
      ),
    ]);

    final tx = ledger.transactions.single;
    expect(tx.id, '0192f0a1-7b2c-7000-8000-000000000001');
    expect(tx.status, TransactionStatus.cleared);
    expect(tx.code, isNull);
    expect(tx.time, isNull);
  });

  test('rescales quantities to minor units', () {
    final ledger = parse([
      _transaction(
        postings: [
          _posting('Assets:A', [_amount(1, places: 0)]),
          _posting('Assets:B', [_amount(-12345000, places: 5)]),
          _posting('Assets:C', [_amount(500, places: 0, commodity: 'JPY')]),
          _posting('Assets:D', [_amount(12245, commodity: '฿')]),
        ],
      ),
    ]);

    expect(ledger.issues, isEmpty);
    expect(ledger.transactions.single.postings.map((p) => p.amount), [
      thb(100),
      thb(-12345),
      Money.fromInt(500, isoCode: 'JPY'),
      thb(12245),
    ]);
  });

  test('splits a posting with several commodities', () {
    final ledger = parse([
      _transaction(
        postings: [
          _posting('Assets:Cash', [
            _amount(100),
            _amount(0, places: 0, commodity: 'JPY'),
          ]),
          _posting('equity:opening/closing balances', [_amount(-100)]),
        ],
      ),
    ]);

    expect(ledger.transactions.single.postings.map((p) => p.account), [
      'Assets:Cash',
      'Assets:Cash',
      'equity:opening/closing balances',
    ]);
  });

  test('infers account types from English root names', () {
    final ledger = parse([
      _transaction(
        postings: [
          _posting('Income:Salary', [_amount(-100)]),
          _posting('Liabilities:Card', [_amount(50)]),
          _posting('equity:opening', [_amount(50)]),
        ],
      ),
    ]);

    expect(ledger.accounts, const [
      Account(name: 'Income', type: AccountType.income),
      Account(name: 'Liabilities', type: AccountType.liability),
      Account(name: 'equity', type: AccountType.equity),
    ]);
  });

  test('reports entries it cannot represent and keeps the rest', () {
    final ledger = parse([
      _transaction(
        postings: [
          _posting('สินทรัพย์:เงินสด', [_amount(100)]),
          _posting('Equity:Opening', [_amount(-100)]),
        ],
      ),
      _transaction(
        postings: [
          _posting('Assets:Broker', [
            _amount(7295, places: 4, commodity: 'NVDA'),
          ]),
          _posting('Assets:Cash', [_amount(-100)]),
        ],
      ),
      _transaction(
        postings: [
          _posting('Assets:YouTrip', [
            _amount(1000, places: 0, commodity: 'JPY', cost: {}),
          ]),
          _posting('Assets:Cash', [_amount(-23000)]),
        ],
      ),
      _transaction(
        postings: [
          _posting('Assets:Budget', [_amount(100)], type: 'VirtualPosting'),
        ],
      ),
      _transaction(
        postings: [
          _posting('Assets:A', [_amount(1005, places: 3)]),
          _posting('Assets:B', [_amount(-1005, places: 3)]),
        ],
      ),
      {'tdate': '2026-09-29'},
      _transaction(),
    ]);

    expect(ledger.issues.map((i) => (i.entry, i.kind)), [
      (0, LedgerIssueKind.unknownAccountType),
      (1, LedgerIssueKind.unsupportedCommodity),
      (2, LedgerIssueKind.unsupportedCost),
      (3, LedgerIssueKind.unsupportedVirtualPosting),
      (4, LedgerIssueKind.badAmount),
      (5, LedgerIssueKind.malformed),
    ]);
    expect(ledger.transactions, hasLength(1));
  });

  test('reports an export that is not a JSON array', () {
    for (final source in ['not json', '{}']) {
      expect(parser.parse(source).issues, const [
        LedgerIssue(kind: LedgerIssueKind.malformed),
      ]);
    }
  });

  test('reads the bundled sample export without issues', () {
    final source = File('assets/ledger/sample.json').readAsStringSync();

    final ledger = parser.parse(source);

    expect(ledger.issues, isEmpty);
    expect(ledger.transactions, hasLength(37));
    expect(
      ledger.accounts.map((a) => a.type),
      unorderedEquals(AccountType.values),
    );
  });
}
