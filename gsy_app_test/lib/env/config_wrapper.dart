import 'package:flutter/material.dart';
import 'package:gsy_app_test/common/config/config.dart';
import 'package:gsy_app_test/env/env_config.dart';

//往下共享环境配置
class ConfigWrapper extends StatelessWidget {
  const ConfigWrapper({Key? key, this.config, this.child}) : super(key: key);

  final EnvConfig? config;

  final Widget? child;

  static EnvConfig? of(BuildContext context) {
    final _InheritedConfig inheritedConfig =
        context.dependOnInheritedWidgetOfExactType<_InheritedConfig>()!;
    return inheritedConfig.config;
  }

  @override
  Widget build(BuildContext context) {
    //设置 Config.DEBUG的静态变量
    Config.DEBUG = config?.debug;
    print("ConfigWrapper build ${Config.DEBUG}");
    return _InheritedConfig(
      config: config,
      child: child!,
    );
  }
}

class _InheritedConfig extends InheritedWidget {
  const _InheritedConfig({required this.config, required super.child});

  final EnvConfig? config;

  @override
  bool updateShouldNotify(_InheritedConfig oldWidget) {
    return config != oldWidget.config;
  }
}
