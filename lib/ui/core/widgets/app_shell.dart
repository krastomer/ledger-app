import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.navigationShell,
    this.inboxCount = 0,
  });

  /// Index of the inbox tab, which shows [inboxCount] as `[n]`.
  static const inboxTab = 2;

  final StatefulNavigationShell navigationShell;
  final int inboxCount;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final current = navigationShell.currentIndex;
    final labels = [
      l10n.navHome,
      l10n.navTransactions,
      l10n.navInbox,
      l10n.navSettings,
    ];
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          border: Border(top: BorderSide(color: scheme.outlineVariant)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: Dimens.tapTarget,
            child: Row(
              children: [
                for (final (index, label) in labels.indexed)
                  Expanded(
                    child: _Tab(
                      index: index,
                      label: label,
                      count: index == inboxTab ? inboxCount : 0,
                      isSelected: index == current,
                      onTap: () => navigationShell.goBranch(
                        index,
                        initialLocation: index == current,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.index,
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Semantics(
      button: true,
      selected: isSelected,
      label: count > 0 ? '$label, $count' : label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        child: ColoredBox(
          color: isSelected ? scheme.primary : Colors.transparent,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.gapXS),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '$index:${label.toLowerCase()}'
                            '${isSelected ? '*' : ''}',
                      ),
                      if (count > 0)
                        TextSpan(
                          text: '[$count]',
                          style: TextStyle(
                            color: isSelected ? null : scheme.error,
                          ),
                        ),
                    ],
                  ),
                  maxLines: 1,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? scheme.onPrimary
                        : scheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
