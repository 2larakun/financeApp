// === NavigatorKey 群 ===============================================
import 'package:finance_app/presentation/router/route_path.dart';
import 'package:finance_app/presentation/screens/expense_input_screen.dart';
import 'package:finance_app/presentation/screens/home_screen.dart';
import 'package:finance_app/presentation/screens/report_screen.dart';
import 'package:finance_app/presentation/screens/settings_screen.dart';
import 'package:finance_app/presentation/widgets/app_shell';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _homeNavkey = GlobalKey<NavigatorState>(debugLabel: 'lib');
final _reportNavKey = GlobalKey<NavigatorState>(debugLabel: 'report');
final _settingsNavKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

// // === Riverpod Provider =============================================
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavKey,
    initialLocation: AppRoutes.home.path,
    debugLogDiagnostics: true,

    routes: [
      // ---------- BottomNav を含むアプリ本体 ----------
      StatefulShellRoute.indexedStack(
        //parentNavigatorKey: _rootNavKey,
        builder: (context, state, navShell) =>
            AppShell(navigationShell: navShell),

        branches: [
          // ---- Branch 0 : マイライブラリ ----
          StatefulShellBranch(
            initialLocation: AppRoutes.home.path,
            navigatorKey: _homeNavkey,
            routes: [
              GoRoute(
                path: AppRoutes.home.path,
                name: AppRoutes.home.name,
                builder: (_, __) => HomeScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavKey,
                    path: AppRoutes.expenseInput.path,
                    name: AppRoutes.expenseInput.name,
                    builder: (_, __) => const ExpenseInputScreen(),
                  ),
                ],
              ),
            ],
          ),

          // ---- Branch 1 : 振り返り ----
          StatefulShellBranch(
            initialLocation: AppRoutes.report.path,
            navigatorKey: _reportNavKey,
            routes: [
              GoRoute(
                path: AppRoutes.report.path,
                name: AppRoutes.report.name,
                builder: (_, __) => const ReportScreen(),
              ),
            ],
          ),

          // ---- Branch 2 : カレンダー ----
          StatefulShellBranch(
            initialLocation: AppRoutes.settings.path,
            navigatorKey: _settingsNavKey,
            routes: [
              GoRoute(
                path: AppRoutes.settings.path,
                name: AppRoutes.settings.name,
                builder: (_, __) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
