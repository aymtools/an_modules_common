import 'package:an_lifecycle_cancellable/an_lifecycle_cancellable.dart';
import 'package:an_modules_common/src/tools/lifecycle_ext.dart';
import 'package:an_viewmodel/an_viewmodel.dart';
import 'package:anlifecycle/anlifecycle.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _keySharedPreferencesInjector = Object();

Future<void> initSharedPreferences(LiveExtData appExt) async {
  final sp = await SharedPreferences.getInstance();
  appExt.putIfAbsent(key: _keySharedPreferencesInjector, ifAbsent: () => sp);
}

extension LifecycleSharedPreferencesExt on ILifecycle {
  /// 获取 SharedPreferences 实例
  SharedPreferences get sharedPreferences => getAppExtData()
      .get<SharedPreferences>(key: _keySharedPreferencesInjector)!;
}

extension ViewModelSharedPreferencesExt on ViewModel {
  /// 获取 SharedPreferences 实例
  SharedPreferences get sharedPreferences =>
      useHostLifecycle(block: (l) => l.sharedPreferences);
}
