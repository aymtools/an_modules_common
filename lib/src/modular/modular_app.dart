import 'package:an_modules/an_modules.dart';
import 'package:anlifecycle/anlifecycle.dart';
import 'package:flutter/material.dart';

/// 启动一个模块化的app
/// * [configs] 模块化app的配置
/// * [debugConfigs] 调试配置
/// * [themeConfigs] 主题配置
/// * [navigatorConfigs] 导航配置
/// * [localizationConfigs] 本地化配置
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

/// 模块化的app
class ModularApp extends StatelessWidget {
  final AppConfigs configs;
  final AppDebugConfigs debugConfigs;
  final AppThemeConfigs themeConfigs;
  final AppNavigatorConfigs navigatorConfigs;
  final AppLocalizationConfigs localizationConfigs;

  /// 模块化的app
  /// * [configs] 模块化app的配置
  /// * [debugConfigs] 调试配置
  /// * [themeConfigs] 主题配置
  /// * [navigatorConfigs] 导航配置
  /// * [localizationConfigs] 本地化配置
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

/// app debug 配置
class AppDebugConfigs {
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final bool debugShowMaterialGrid;

  /// app debug 配置
  const AppDebugConfigs({
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
  });
}

/// app navigator 配置
class AppNavigatorConfigs {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialRoute;
  final String Function(BuildContext)? onGenerateInitialRouteName;
  final RouteFactory? onUnknownRoute;

  final NotificationListenerCallback<NavigationNotification>?
      onNavigationNotification;
  final List<NavigatorObserver> navigatorObservers;

  ///  app navigator 配置
  const AppNavigatorConfigs({
    this.navigatorKey,
    this.initialRoute,
    this.onGenerateInitialRouteName,
    this.onUnknownRoute = _notFindPage,
    this.onNavigationNotification,
    this.navigatorObservers = const <NavigatorObserver>[],
  });
}

/// app theme 配置
class AppThemeConfigs {
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Duration themeAnimationDuration;
  final Curve themeAnimationCurve;

  /// app theme 配置
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

/// app localization 配置
class AppLocalizationConfigs {
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;

  /// app localization 配置
  const AppLocalizationConfigs({
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
  });
}

/// app initializer 配置
class AppConfigs {
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;

  final Widget initializing;

  /// app initializer 配置
  const AppConfigs({
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.restorationScopeId,
    this.scrollBehavior,
    this.initializing = const _AppInitializing(),
  });
}

/// 默认的app初始化
class _AppInitializing extends StatelessWidget {
  const _AppInitializing();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// 默认的找不到路由
Route _notFindPage(RouteSettings settings) => MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('Can not find route\n$settings'),
        ),
      ),
    );
