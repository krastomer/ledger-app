import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/ui/core/l10n.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              label: l10n.navHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.list),
              label: l10n.navTransactions,
            ),
            NavigationDestination(
              icon: const Icon(Icons.inbox_outlined),
              label: l10n.navInbox,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              label: l10n.navSettings,
            ),
          ],
        ),
      ),
    );
  }
}
