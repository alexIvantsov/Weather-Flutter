import 'package:flutter/cupertino.dart';
import 'package:weather/presentation/core/app_router.dart';

extension ContextExtension on BuildContext {
  AppRouter get appRouter => AppRouterProvider.of(this);
}
