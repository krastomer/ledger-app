import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/daily_spend.dart';
import 'package:ledger_app/domain/models/income_statement.dart';
import 'package:ledger_app/l10n/app_localizations_en.dart';
import 'package:ledger_app/ui/reports/bloc/reports_cubit.dart';
import 'package:ledger_app/ui/reports/view/report_level.dart';

import '../../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  AccountNode tree(String name, int satang) => AccountNode(
    account: name,
    name: name,
    amount: thb(satang),
    ownAmount: thb(satang),
    ownEntryCount: 1,
    children: const [],
  );

  final statement = IncomeStatement(
    month: DateTime(2026, 9),
    earliestMonth: DateTime(2026, 9),
    latestMonth: DateTime(2026, 9),
    income: thb(5000000),
    expenses: thb(1000000),
    net: thb(4000000),
    savingsPerMille: 800,
    expensesPerMille: 200,
    expenseTree: tree('Expenses', 1000000),
    incomeTree: tree('Income', 5000000),
    dailySpend: DailySpend(
      month: DateTime(2026, 9),
      days: const [],
      elapsedDays: 30,
      average: thb(0),
    ),
  );

  ReportLevel level(ReportSide? side, List<AccountNode> trail) =>
      buildReportLevel(
        l10n: AppLocalizationsEn(),
        statement: statement,
        side: side,
        trail: trail,
      );

  test('the overview links both the left-over slice and a row to income', () {
    final overview = level(null, const []);

    expect(overview.parent, isNull);
    expect(overview.incomeLink?.label, 'Income');
    expect(overview.slices.map((s) => (s.label, s.opensSide)), [
      ('Expenses', ReportSide.expense),
      ('Left over', ReportSide.income),
    ]);
  });

  test('a side has a parent row and no income link', () {
    final expenses = level(ReportSide.expense, [statement.expenseTree]);

    expect(expenses.parent?.label, 'Expenses');
    expect(expenses.incomeLink, isNull);
  });
}
