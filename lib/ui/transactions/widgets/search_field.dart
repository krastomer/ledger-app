import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';

import '../bloc/transactions_cubit.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    return Container(
      height: 40,
      padding: const EdgeInsetsDirectional.only(start: 10),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        spacing: 8,
        children: [
          ExcludeSemantics(
            child: Text('/', style: TextStyle(color: scheme.primary)),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: context.read<TransactionsCubit>().setQuery,
              textInputAction: TextInputAction.search,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration.collapsed(
                hintText: l10n.searchTransactions.toLowerCase(),
                hintStyle: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ),
          ),
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => _controller.text.isEmpty
                ? const SizedBox(width: 2)
                : TuiButton(
                    label: '[x]',
                    tooltip: l10n.clearSearch,
                    onPressed: _clear,
                  ),
          ),
        ],
      ),
    );
  }
}
