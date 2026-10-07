import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';

import '../bloc/transactions_cubit.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final filter = context.select(
      (TransactionsCubit cubit) => cubit.state.filter,
    );
    final cubit = context.read<TransactionsCubit>();
    return Row(
      spacing: 6,
      children: [
        TuiButton.chip(
          label: l10n.filterPendingFlag,
          tooltip: l10n.filterPending,
          selected: filter.pendingOnly,
          onPressed: cubit.togglePendingOnly,
        ),
        TuiButton.chip(
          label: l10n.filterSlipFlag,
          tooltip: l10n.slipAttached,
          selected: filter.withSlipOnly,
          onPressed: cubit.toggleWithSlipOnly,
        ),
      ],
    );
  }
}
