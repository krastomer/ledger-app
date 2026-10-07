import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/transaction_detail_use_case.dart';

import '../bloc/transaction_detail_cubit.dart';
import 'transaction_detail_view.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionDetailCubit(
        id: id,
        transactionDetail: TransactionDetailUseCase(
          ledgerRepository: context.read(),
        ),
        editTransaction: EditTransactionUseCase(
          ledgerRepository: context.read(),
        ),
      )..load(),
      child: const TransactionDetailView(),
    );
  }
}
