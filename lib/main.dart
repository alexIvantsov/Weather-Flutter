import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/presentation/core/app_widget.dart';

import 'di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _setupSystemChrome();
  _initDependencyInjection();
  runApp(AppWidget.create());
}

void _initDependencyInjection() {
  configureDependencies();
}

void _setupSystemChrome() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}
