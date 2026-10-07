import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/account_type.dart';

const starterAccounts = [
  Account(name: 'Assets', type: AccountType.asset),
  Account(name: 'Liabilities', type: AccountType.liability),
  Account(name: 'Equity', type: AccountType.equity),
  Account(name: 'Income', type: AccountType.income),
  Account(name: 'Expenses', type: AccountType.expense),
];
