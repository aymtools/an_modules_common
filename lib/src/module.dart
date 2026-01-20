import 'package:an_modules/an_modules.dart';
import 'package:an_modules_common/src/tools/lifecycle_ext.dart';
import 'package:an_modules_common/src/tools/shared_preferences_ext.dart';
import 'package:anlifecycle/anlifecycle.dart';

class ModuleCommon {
  // ignore: strict_top_level_inference
  static void registerWith([_]) {
    Module.registerModule(
      containerId: kCoreContainerId,
      module: Module(
        name: 'an_modules_common',
        initializerExecutor: _initializer,
      ),
    );
  }
}

bool _isRegistered = false;

Future<void> _initializer(MIContext context) async {
  if (_isRegistered) return;
  _isRegistered = true;
  if (context.isRetry) return;
  final uiContext = context.context;
  final appExt = Lifecycle.of(uiContext, listen: false).getAppExtData();
  await initSharedPreferences(appExt);
}
