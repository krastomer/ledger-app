import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:money2/money2.dart';

Money thb(int satang) => Money.fromInt(satang, isoCode: 'THB');

const fixtureAccounts = [
  Account(name: 'Assets', type: AccountType.asset),
  Account(name: 'Liabilities', type: AccountType.liability),
  Account(name: 'Equity', type: AccountType.equity),
  Account(name: 'Income', type: AccountType.income),
  Account(name: 'Expenses', type: AccountType.expense),
];

/// "Today" for [fixtureTransactions].
final fixtureToday = DateTime(2026, 9, 29);

LedgerTransaction fixtureTransaction(
  String id,
  DateTime date,
  Map<String, Money> postings, {
  Duration? time,
  TransactionStatus status = TransactionStatus.cleared,
  String? code,
}) => LedgerTransaction(
  id: id,
  date: date,
  time: time,
  description: id,
  status: status,
  code: code,
  postings: [
    for (final MapEntry(key: account, value: amount) in postings.entries)
      Posting(account: account, amount: amount),
  ],
);

final fixtureTransactions = [
  fixtureTransaction('opening', DateTime(2026, 8), {
    'Assets:Bank:KBank': thb(10000000),
    'Liabilities:Credit card': thb(-100000),
    'Equity:Opening': thb(-9900000),
  }),
  fixtureTransaction('august food', DateTime(2026, 8, 20), {
    'Expenses:Food': thb(50000),
    'Assets:Bank:KBank': thb(-50000),
  }),
  fixtureTransaction('salary', DateTime(2026, 9, 25), {
    'Assets:Bank:KBank': thb(5000000),
    'Income:Salary': thb(-5000000),
  }),
  fixtureTransaction(
    'lunch',
    DateTime(2026, 9, 28),
    {'Expenses:Food:Lunch': thb(20000), 'Assets:Bank:KBank': thb(-20000)},
    time: const Duration(hours: 12),
    code: 'REF-1',
  ),
  fixtureTransaction('rent', DateTime(2026, 9, 28), {
    'Expenses:Rent': thb(800000),
    'Assets:Bank:KBank': thb(-800000),
  }, status: TransactionStatus.pending),
  fixtureTransaction('bts', DateTime(2026, 9, 28), {
    'Expenses:Transport': thb(5000),
    'Liabilities:Credit card': thb(-5000),
  }, time: const Duration(hours: 18)),
  fixtureTransaction('to savings', DateTime(2026, 9, 29), {
    'Assets:Bank:Savings': thb(100000),
    'Assets:Bank:KBank': thb(-100000),
  }),
];
