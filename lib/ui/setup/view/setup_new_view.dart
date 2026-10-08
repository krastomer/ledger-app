import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/models/starter_accounts.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/ui/settings/widgets/settings_tile.dart';

import '../bloc/setup_cubit.dart';
import '../widgets/setup_listener.dart';
import '../widgets/setup_scaffold.dart';

class SetupNewView extends StatelessWidget {
  const SetupNewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final saving = context.select(
      (SetupCubit cubit) => cubit.state.status == SetupStatus.saving,
    );
    return SetupListener(
      child: SetupScaffold(
        step: 2,
        footer: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TuiButton.primary(
            label: l10n.setupCreate,
            onPressed: saving ? null : context.read<SetupCubit>().startNew,
          ),
        ),
        children: [
          TuiPanel(
            title: l10n.setupNewTitle,
            accent: true,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.panelPadding,
              vertical: Dimens.gapXS,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: Dimens.tapTarget,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: SettingKeyValue(
                      label: l10n.setupCurrency,
                      value: 'THB',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimens.panelGap),
          TuiPanel(
            title: l10n.accountsTitle,
            padding: const EdgeInsets.fromLTRB(
              Dimens.panelPadding,
              Dimens.panelPadding,
              Dimens.panelPadding,
              Dimens.panelPadding,
            ),
            background: scheme.surfaceContainerLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final account in starterAccounts)
                  Text(account.name, style: theme.textTheme.bodySmall),
                const SizedBox(height: Dimens.gapS),
                SettingComment(l10n.setupAccountsHint, small: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
