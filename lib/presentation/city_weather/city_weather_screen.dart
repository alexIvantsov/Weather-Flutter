import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/di/injection.dart';
import 'package:weather/domain/entity/measurement_unit.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/city_weather/widgets/weather_widget.dart';

class CityWeatherScreen extends StatelessWidget {
  final String? city;

  const CityWeatherScreen({super.key, this.city});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<CityWeatherBloc>();
        if (city == null) {
          bloc.add(const CityWeatherEvent.init());
        } else {
          bloc.add(CityWeatherEvent.fetchWeather(city!));
        }
        return bloc;
      },
      child: const CityWeatherView(),
    );
  }
}

class CityWeatherView extends StatelessWidget {
  const CityWeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CityWeatherBloc, CityWeatherState>(
          listener: (context, state) {
            if (state.city == null && state.isLoading == false) {
              context.appRouter.pushReplacementNamed('/enter_city');
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const WeatherWidget(
              cityName: "Kyiv",
              weatherUiModel: WeatherUiModel(
                measurementUnit: MeasurementUnit.metric,
                temperature: '27°',
                temperatureFeelsLike: '25°',
                minTemperature: '25°',
                maxTemperature: '25°',
                pressure: '10',
                humidity: '25%',
                weatherCondition: 'Clear',
                weatherConditionDescription: 'Clear sky',
                cloudiness: '0%',
                wind: WindUiModel(
                  speed: '10',
                  direction: 90,
                  gust: '15',
                ),
                visibility: 100,
                precipitationProbability: '0%',
              ),
            );
          },
        ),
      ),
    );
  }
}
