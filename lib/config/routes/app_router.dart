import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robinhood_app_testing/features/screen_lock/states/auth_state.dart';
import '../../features/main/views/main_screen.dart';
import '../../features/screen_lock/views/screen_lock_screen.dart';
import 'route_config.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    errorBuilder: (ctx, state) => Scaffold(
      body: Center(
        child: Text('Error Route: ${state.error}'),
      ),
    ),
    routes: [
      GoRoute(
        path: Routes.mainScreen,
        pageBuilder: (context, state) {
          if (ref.watch(authState)) {
            return const NoTransitionPage(child: MainScreen());
          } else {
            return const NoTransitionPage(child: ScreenLockScreen());
          }
        },
      ),
    ],
  );
});
