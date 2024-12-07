import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/di/injection.dart';
import 'package:weather/domain/exceptions/not_found_exception.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/city_weather/widgets/city_not_found.dart';
import 'package:weather/presentation/city_weather/widgets/something_went_wrong.dart';
import 'package:weather/presentation/city_weather/widgets/weather_widget.dart';

class CityWeatherScreen extends StatefulWidget {
  final String? city;

  const CityWeatherScreen({super.key, this.city});

  @override
  State<CityWeatherScreen> createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  final bloc = getIt<CityWeatherBloc>();

  @override
  void initState() {
    if (widget.city == null) {
      bloc.add(const CityWeatherEvent.init());
    } else {
      bloc.add(CityWeatherEvent.fetchWeather(widget.city!));
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CityWeatherScreen oldWidget) {
    if (bloc.state.city != widget.city && widget.city != null) {
      bloc.add(CityWeatherEvent.fetchWeather(widget.city!));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: CityWeatherView(
        onEnterCity: () {
          context.appRouter.replaceAllNamed('/enter_city');
        },
        onChangeCity: () {
          context.appRouter.pushNamed('/enter_city');
        },
        onRetry: () {
          final city = bloc.state.city;
          if (city == null) return;
          bloc.add(CityWeatherEvent.fetchWeather(city));
        },
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}

class CityWeatherView extends StatelessWidget {
  final VoidCallback onEnterCity;
  final VoidCallback onChangeCity;
  final VoidCallback onRetry;

  const CityWeatherView({
    super.key,
    required this.onEnterCity,
    required this.onChangeCity,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CityWeatherBloc, CityWeatherState>(
          listener: (context, state) {
            if (state.city == null && state.isLoading == false) {
              onEnterCity();
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final city = state.city;
            if (city == null) {
              // User should be redirected to enter city screen
              return const SizedBox.shrink();
            }

            final weather = state.weather;
            if (weather != null) {
              return WeatherWidget(
                cityName: city,
                weatherUiModel: weather,
              );
            }

            final error = state.exception;
            if (error != null) {
              if (error is NotFoundException) {
                return CityNotFound(
                  city: city,
                  onChangeCity: onChangeCity,
                );
              } else {
                return SomethingWentWrong(
                  city: city,
                  onRetry: onRetry,
                  onEnterAnotherCity: onChangeCity,
                );
              }
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
