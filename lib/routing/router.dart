import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/domain/use_cases/review_queue_use_case.dart';
import 'package:ledger_app/ui/accounts/view/accounts_page.dart';
import 'package:ledger_app/ui/boot/view/boot_page.dart';
import 'package:ledger_app/ui/core/widgets/app_shell.dart';
import 'package:ledger_app/ui/home/view/home_page.dart';
import 'package:ledger_app/ui/inbox/bloc/inbox_cubit.dart';
import 'package:ledger_app/ui/inbox/view/inbox_view.dart';
import 'package:ledger_app/ui/reports/view/reports_page.dart';
import 'package:ledger_app/ui/settings/view/settings_view.dart';
import 'package:ledger_app/ui/setup/view/setup_import_page.dart';
import 'package:ledger_app/ui/setup/view/setup_new_page.dart';
import 'package:ledger_app/ui/setup/view/setup_welcome_view.dart';
import 'package:ledger_app/ui/slip_review/view/slip_review_page.dart';
import 'package:ledger_app/ui/transaction_detail/view/transaction_detail_page.dart';
import 'package:ledger_app/ui/transactions/view/transactions_page.dart';

import 'routes.dart';

GoRouter createRouter({String initialLocation = Routes.boot}) {
  final rootKey = GlobalKey<NavigatorState>();
  return GoRouter(
    navigatorKey: rootKey,
    initialLocation: initialLocation,
    routes: [
      GoRoute(path: Routes.boot, builder: (context, state) => const BootPage()),
      GoRoute(
        path: Routes.setup,
        builder: (context, state) => const SetupWelcomeView(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const SetupNewPage(),
          ),
          GoRoute(
            path: 'import',
            builder: (context, state) => const SetupImportPage(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.transaction,
        parentNavigatorKey: rootKey,
        builder: (context, state) =>
            TransactionDetailPage(id: state.pathParameters['id'] ?? ''),
      ),
      GoRoute(
        path: Routes.slipReview,
        parentNavigatorKey: rootKey,
        builder: (context, state) => SlipReviewPage(
          imagePaths: switch (state.extra) {
            final List<String> paths => paths,
            _ => const [],
          },
        ),
      ),
      StatefulShellRoute.indexedStack(
        // The inbox cubit sits above the tabs so the tab bar can show how
        // many items are open.
        builder: (context, state, navigationShell) => BlocProvider(
          create: (context) => InboxCubit(
            reviewQueue: ReviewQueueUseCase(ledgerRepository: context.read()),
            editTransaction: EditTransactionUseCase(
              ledgerRepository: context.read(),
            ),
            importSlip: ImportSlipUseCase(
              slipRepository: context.read(),
              ledgerRepository: context.read(),
            ),
          )..load(),
          child: BlocSelector<InboxCubit, InboxState, int>(
            selector: (state) => state.openItems.length,
            builder: (context, inboxCount) => AppShell(
              navigationShell: navigationShell,
              inboxCount: inboxCount,
            ),
          ),
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => const HomePage(),
                routes: [
                  GoRoute(
                    path: Routes.accounts.substring(1),
                    builder: (context, state) => const AccountsPage(),
                  ),
                  GoRoute(
                    path: Routes.reports.substring(1),
                    builder: (context, state) => const ReportsPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.transactions,
                builder: (context, state) => const TransactionsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.inbox,
                builder: (context, state) => const InboxView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings,
                builder: (context, state) => const SettingsView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
