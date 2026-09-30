import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/use_cases/month_transactions_use_case.dart';

import '../bloc/transactions_cubit.dart';
import 'transactions_view.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsCubit(
        monthTransactions: MonthTransactionsUseCase(
          ledgerRepository: context.read(),
        ),
      )..load(),
      child: const TransactionsView(),
    );
  }
}
