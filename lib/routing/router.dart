import 'package:go_router/go_router.dart';
import 'package:ledger_app/data/parsers/slip/slip_parser.dart';
import 'package:ledger_app/data/services/slip_ocr_service.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/widgets/app_shell.dart';
import 'package:ledger_app/ui/core/widgets/coming_soon_page.dart';
import 'package:ledger_app/ui/dev/ocr_test_page.dart';
import 'package:ledger_app/ui/home/view/home_page.dart';
import 'package:ledger_app/ui/settings/view/settings_view.dart';

import 'routes.dart';

GoRouter createRouter({required SlipOcrService ocrService}) => GoRouter(
  initialLocation: Routes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: Routes.accounts.substring(1),
                  builder: (context, state) =>
                      ComingSoonPage(title: context.l10n.accountsTitle),
                ),
                GoRoute(
                  path: Routes.reports.substring(1),
                  builder: (context, state) =>
                      ComingSoonPage(title: context.l10n.reportsTitle),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.transactions,
              builder: (context, state) =>
                  ComingSoonPage(title: context.l10n.navTransactions),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.inbox,
              // TODO(kasama): replace the OCR test screen with the real inbox.
              builder: (context, state) =>
                  OcrTestPage(ocr: ocrService, parser: const SlipParser()),
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
