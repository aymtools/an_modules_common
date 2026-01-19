import 'package:an_modules_common/an_modules_common.dart';
import 'package:flutter/material.dart';

void main() {
  /// 一般会在 [startApp] 注册 全局异常捕获等操作
  startApp();

  /// 由于使用了自动化注册 此处无须任何的手动注册
}

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 启动模块化的app
  runModularApp(
    configs: const AppConfigs(
      title: 'Modular Demo',
      initializing: Initializing(),
    ),
  );
}

/// 定义loading时的ui
class Initializing extends StatelessWidget {
  const Initializing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
