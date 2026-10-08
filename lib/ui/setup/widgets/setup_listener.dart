import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';

import '../bloc/setup_cubit.dart';

class SetupListener extends StatelessWidget {
  const SetupListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<SetupCubit, SetupState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          (current.error == SetupError.saveFailed &&
              previous.error != current.error),
      listener: (context, state) {
        if (state.status == SetupStatus.done) {
          context.push(Routes.setupRules);
        } else if (state.error == SetupError.saveFailed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.setupSaveFailed)));
        }
      },
      child: child,
    );
  }
}
