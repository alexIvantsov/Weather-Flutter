part of 'app_router.dart';

/// Provides [RouterDelegate] and [RouteInformationParser] for the app
///
/// Used to avoid direct dependency on [BeamerDelegate] and [BeamerParser]
@injectable
abstract class AppRouterConfigProvider {
  @factoryMethod
  factory AppRouterConfigProvider() => _GoRouterConfigProvider();

  RouterConfig<Object>? get routerConfig;

  GoRouter get _goRouter;
}

class _GoRouterConfigProvider implements AppRouterConfigProvider {
  @override
  RouterConfig<Object>? get routerConfig => _goRouter;

  @override
  final _goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const CityWeatherScreen(),
      ),
      GoRoute(
        path: '/city_weather/:city',
        builder: (context, state) {
          return CityWeatherScreen(
            key: state.pageKey,
            city: state.pathParameters['city'],
          );
        },
      ),
      GoRoute(
        path: '/enter_city',
        builder: (context, state) => const EnterCityScreen(),
      ),
    ],
  );
}
