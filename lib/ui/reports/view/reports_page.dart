import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/use_cases/income_statement_use_case.dart';

import '../bloc/reports_cubit.dart';
import 'reports_view.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit(
        incomeStatement: IncomeStatementUseCase(
          ledgerRepository: context.read(),
        ),
      )..load(),
      child: const ReportsView(),
    );
  }
}
