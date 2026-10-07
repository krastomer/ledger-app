import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/use_cases/accounts_summary_use_case.dart';

import '../bloc/accounts_cubit.dart';
import 'accounts_view.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountsCubit(
        accountsSummary: AccountsSummaryUseCase(
          ledgerRepository: context.read(),
        ),
      )..load(),
      child: const AccountsView(),
    );
  }
}
