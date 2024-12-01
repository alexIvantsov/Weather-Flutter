part of 'app_router.dart';

/// Provides [RouterDelegate] and [RouteInformationParser] for the app
///
/// Used to avoid direct dependency on [BeamerDelegate] and [BeamerParser]
@injectable
abstract class AppRouterDelegateProvider {
  @factoryMethod
  factory AppRouterDelegateProvider() => _AppRouterDelegateProviderImpl();

  RouteInformationParser<Object>? get routeInformationParser;

  RouterDelegate<Object> get routerDelegate;

  BeamerDelegate get _beamerDelegate;
}

class _AppRouterDelegateProviderImpl implements AppRouterDelegateProvider {
  @override
  RouteInformationParser<Object> get routeInformationParser => BeamerParser();

  @override
  RouterDelegate<Object> get routerDelegate => _routerDelegate;

  @override
  BeamerDelegate get _beamerDelegate => _routerDelegate;

  final _routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const CityWeatherScreen(),
      },
    ).call,
  );
}
