import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/rules/bloc/rules_cubit.dart';

import 'settings_tile.dart';

class RulesTile extends StatelessWidget {
  const RulesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RulesCubit(repository: context.read())..load(),
      child: const _RulesTileBody(),
    );
  }
}

class _RulesTileBody extends StatelessWidget {
  const _RulesTileBody();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final saved = context.select((RulesCubit cubit) => cubit.state.saved);
    return SettingsTile(
      label: l10n.settingsRules,
      value: saved?.fileName ?? l10n.rulesNone,
      kind: saved == null ? SettingValueKind.literal : SettingValueKind.text,
      hint: saved == null
          ? l10n.rulesNoFile
          : l10n.rulesLoadedCount(saved.rules.length),
      onTap: () async {
        final cubit = context.read<RulesCubit>();
        await context.push(Routes.rules);
        if (context.mounted) await cubit.load();
      },
    );
  }
}
