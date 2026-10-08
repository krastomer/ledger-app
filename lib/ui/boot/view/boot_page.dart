import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/use_cases/ledger_check_use_case.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';

import '../bloc/boot_cubit.dart';
import 'boot_view.dart';

class BootPage extends StatelessWidget {
  const BootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BootCubit(
        ledgerCheck: LedgerCheckUseCase(ledgerRepository: context.read()),
        isFirstRun: !context.read<SettingsCubit>().state.settings.setupComplete,
      )..run(),
      child: const BootView(),
    );
  }
}
