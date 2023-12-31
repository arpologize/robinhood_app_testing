import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:robinhood_app_testing/features/screen_lock/controllers/screen_lock_controller.dart';
import 'config/routes/app_router.dart';
import 'config/themes/custom_themes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appRouter = ref.watch(appRouterProvider);
    return GestureDetector(
      onTap: () => ref
          .read(screenLockControllerProvider.notifier)
          .handleUserInteraction(),
      onPanDown: (_) => ref
          .read(screenLockControllerProvider.notifier)
          .handleUserInteraction(),
      onScaleStart: (_) => ref
          .read(screenLockControllerProvider.notifier)
          .handleUserInteraction(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Robinhood app testing',
        theme: CustomThemes.mainTheme,
        locale: const Locale('en'),
        builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),
            maxWidth: 1200,
            minWidth: 420,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(420, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        routerConfig: appRouter,
      ),
    );
  }
}
