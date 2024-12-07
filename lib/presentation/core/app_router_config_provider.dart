part of 'app_router.dart';

/// Provides [RouterConfig] for the [MaterialApp.router]
///
/// Used to avoid direct dependency on any particular router implementation
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
      // Initial route.
      // This route is used when the app is launched.
      // It doesn't have any parameters.
      GoRoute(
        path: '/',
        builder: (context, state) => const CityWeatherScreen(),
      ),

      // Route to display weather for a specific city.
      // The same screen as the initial one is used.
      // But the city name is passed as a parameter.
      GoRoute(
        path: '/city_weather/:city',
        builder: (context, state) {
          return CityWeatherScreen(
            key: state.pageKey,
            city: state.pathParameters['city'],
          );
        },
      ),

      // Route to enter the city name.
      GoRoute(
        path: '/enter_city',
        builder: (context, state) => const EnterCityScreen(),
      ),
    ],
  );
}
