import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Dimens.gapS,
        children: [
          const _SearchField(),
          Wrap(
            spacing: Dimens.gapS,
            children: [
              FilterChip(
                label: Text(l10n.filterPending),
                selected: filter.pendingOnly,
                onSelected: (_) => cubit.togglePendingOnly(),
              ),
              FilterChip(
                label: Text(l10n.filterWithSlip),
                selected: filter.withSlipOnly,
                onSelected: (_) => cubit.toggleWithSlipOnly(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField();

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    context.read<TransactionsCubit>().setQuery('');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SearchBar(
      controller: _controller,
      hintText: l10n.searchTransactions,
      elevation: const WidgetStatePropertyAll(0),
      leading: const Icon(Icons.search),
      onChanged: context.read<TransactionsCubit>().setQuery,
      trailing: [
        ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => _controller.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  tooltip: l10n.clearSearch,
                  onPressed: _clear,
                  icon: const Icon(Icons.close),
                ),
        ),
      ],
    );
  }
}
