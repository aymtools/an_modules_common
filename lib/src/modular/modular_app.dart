import 'package:an_modules/an_modules.dart';
import 'package:anlifecycle/anlifecycle.dart';
import 'package:flutter/material.dart';

/// 启动一个模块化的app
void runModularApp({
  AppConfigs configs = const AppConfigs(),
  AppDebugConfigs debugConfigs = const AppDebugConfigs(),
  AppThemeConfigs themeConfigs = const AppThemeConfigs(),
  AppNavigatorConfigs navigatorConfigs = const AppNavigatorConfigs(),
  AppLocalizationConfigs localizationConfigs = const AppLocalizationConfigs(),
}) {
  runApp(ModularApp(
    configs: configs,
    debugConfigs: debugConfigs,
    themeConfigs: themeConfigs,
    navigatorConfigs: navigatorConfigs,
    localizationConfigs: localizationConfigs,
  ));
}

class ModularApp extends StatelessWidget {
  final AppConfigs configs;
  final AppDebugConfigs debugConfigs;
  final AppThemeConfigs themeConfigs;
  final AppNavigatorConfigs navigatorConfigs;
  final AppLocalizationConfigs localizationConfigs;

  const ModularApp(
      {super.key,
      required this.configs,
      required this.debugConfigs,
      required this.themeConfigs,
      required this.navigatorConfigs,
      required this.localizationConfigs});

  @override
  Widget build(BuildContext context) {
    return LifecycleApp(
      child: Builder(builder: (context) {
        final app = Module.app;
        return MaterialApp(
          navigatorKey: navigatorConfigs.navigatorKey,
          initialRoute:
              navigatorConfigs.onGenerateInitialRouteName?.call(context) ??
                  navigatorConfigs.initialRoute,
          onUnknownRoute: navigatorConfigs.onUnknownRoute,
          navigatorObservers: [
            LifecycleNavigatorObserver.hookMode(),
            ...navigatorConfigs.navigatorObservers,
          ],
          title: configs.title,
          onGenerateTitle: configs.onGenerateTitle,
          theme: themeConfigs.theme,
          darkTheme: themeConfigs.darkTheme,
          highContrastTheme: themeConfigs.highContrastTheme,
          highContrastDarkTheme: themeConfigs.highContrastDarkTheme,
          themeMode: themeConfigs.themeMode,
          themeAnimationDuration: themeConfigs.themeAnimationDuration,
          themeAnimationCurve: themeConfigs.themeAnimationCurve,
          color: configs.color,
          locale: localizationConfigs.locale,
          localizationsDelegates: localizationConfigs.localizationsDelegates,
          localeListResolutionCallback:
              localizationConfigs.localeListResolutionCallback,
          localeResolutionCallback:
              localizationConfigs.localeResolutionCallback,
          supportedLocales: localizationConfigs.supportedLocales,
          showPerformanceOverlay: debugConfigs.showPerformanceOverlay,
          checkerboardRasterCacheImages:
              debugConfigs.checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: debugConfigs.checkerboardOffscreenLayers,
          showSemanticsDebugger: debugConfigs.showSemanticsDebugger,
          debugShowCheckedModeBanner: debugConfigs.debugShowCheckedModeBanner,
          restorationScopeId: configs.restorationScopeId,
          scrollBehavior: configs.scrollBehavior,
          debugShowMaterialGrid: debugConfigs.debugShowMaterialGrid,
          onGenerateRoute: app.generateRouteFactory,
          builder: AppInitializer.builder(
              initializing: configs.initializing, builder: configs.builder),
        );
      }),
    );
  }
}

class AppDebugConfigs {
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final bool debugShowMaterialGrid;

  const AppDebugConfigs({
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
  });
}

class AppNavigatorConfigs {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialRoute;
  final String Function(BuildContext)? onGenerateInitialRouteName;
  final RouteFactory? onUnknownRoute;

  final NotificationListenerCallback<NavigationNotification>?
      onNavigationNotification;
  final List<NavigatorObserver> navigatorObservers;

  const AppNavigatorConfigs({
    this.navigatorKey,
    this.initialRoute,
    this.onGenerateInitialRouteName,
    this.onUnknownRoute,
    this.onNavigationNotification,
    this.navigatorObservers = const <NavigatorObserver>[],
  });
}

class AppThemeConfigs {
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Duration themeAnimationDuration;
  final Curve themeAnimationCurve;

  const AppThemeConfigs({
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
  });
}

class AppLocalizationConfigs {
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;

  const AppLocalizationConfigs({
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
  });
}

class AppConfigs {
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;

  final Widget initializing;

  const AppConfigs({
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.restorationScopeId,
    this.scrollBehavior,
    this.initializing = const SizedBox.shrink(),
  });
}
