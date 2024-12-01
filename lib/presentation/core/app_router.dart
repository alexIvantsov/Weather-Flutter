import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/presentation/city_weather/city_weather_screen.dart';

part 'app_router_delegate_provider.dart';

/// Provider to provide [AppRouter] to the widget tree
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
  factory AppRouter(AppRouterDelegateProvider appRouterDelegate) {
    return _AppRouterImpl(appRouterDelegate);
  }

  void pushNamed(String routeName);

  void pop();
}

class _AppRouterImpl implements AppRouter {
  final AppRouterDelegateProvider _appRouterDelegate;

  const _AppRouterImpl(this._appRouterDelegate);

  @override
  void pushNamed(String routeName) {
    _appRouterDelegate._beamerDelegate.beamToNamed(routeName);
  }

  @override
  void pop() {
    _appRouterDelegate._beamerDelegate.beamBack();
  }
}
