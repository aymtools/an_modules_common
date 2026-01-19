import 'package:an_lifecycle_cancellable/an_lifecycle_cancellable.dart';
import 'package:anlifecycle/anlifecycle.dart';

extension LifecycleAppScopeExt on ILifecycle {
  /// 查找 AppScope
  LifecycleAppOwnerState findAppScope() {
    return findLifecycleOwner<LifecycleAppOwnerState>(
        test: (owner) => owner.lifecycle.parent == null)!;
  }

  /// 获取 AppScope 的 LiveExtData
  LiveExtData getAppExtData() => findAppScope().extData;
}
