import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/presentation/city_weather/city_weather_screen.dart';
import 'package:weather/presentation/enter_city/enter_city_screen.dart';

part 'app_router_config_provider.dart';

/// Provides [AppRouter] for the widget tree
class AppRouterProvider extends InheritedWidget {
  final AppRouter appRouter;

  const AppRouterProvider({
    super.key,
    required this.appRouter,
    required super.child,
  });

  static AppRouter of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<AppRouterProvider>();
    assert(result != null, 'No AppRouterProvider found in context');
    return result!.appRouter;
  }

  @override
  bool updateShouldNotify(AppRouterProvider oldWidget) {
    return appRouter != oldWidget.appRouter;
  }
}

/// Wraps the router actions to not to depend on particular router implementation
abstract class AppRouter {
  factory AppRouter(AppRouterConfigProvider appRouterDelegate) {
    return _GoRouterAppRouterImpl(appRouterDelegate);
  }

  void pushNamed(String routeName);

  void replaceAllNamed(String routeName);

  void pushReplacementNamed(String routeName);

  void pop();
}

class _GoRouterAppRouterImpl implements AppRouter {
  final AppRouterConfigProvider _appRouterDelegate;

  const _GoRouterAppRouterImpl(this._appRouterDelegate);

  @override
  void pushNamed(String routeName) {
    _appRouterDelegate._goRouter.push(routeName);
  }

  @override
  void replaceAllNamed(String routeName) {
    _appRouterDelegate._goRouter.go(routeName);
  }

  @override
  void pushReplacementNamed(String routeName) {
    _appRouterDelegate._goRouter.pushReplacement(routeName);
  }

  @override
  void pop() {
    _appRouterDelegate._goRouter.pop();
  }
}
