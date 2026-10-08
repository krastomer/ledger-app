import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';

import '../bloc/setup_scan_cubit.dart';

class SetupScanListener extends StatelessWidget {
  const SetupScanListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<SetupScanCubit, SetupScanState>(
      listenWhen: (previous, current) =>
          previous.phase != current.phase ||
          (current.error == SetupScanError.saveFailed &&
              previous.error != current.error),
      listener: (context, state) async {
        if (state.phase == SetupScanPhase.done) {
          await context.read<SettingsCubit>().completeSetup();
          if (context.mounted) context.go(Routes.home);
        } else if (state.error == SetupScanError.saveFailed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.setupSaveFailed)));
        }
      },
      child: child,
    );
  }
}
