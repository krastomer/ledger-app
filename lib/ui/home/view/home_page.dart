import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/use_cases/home_summary_use_case.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';

import '../bloc/home_cubit.dart';
import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        homeSummary: HomeSummaryUseCase(ledgerRepository: context.read()),
        amountsHidden: context
            .read<SettingsCubit>()
            .state
            .settings
            .hideOnLaunch,
      )..load(),
      child: const HomeView(),
    );
  }
}
