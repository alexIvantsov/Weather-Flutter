import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/di/injection.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
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
      child: const CityWeatherView(),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
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

            final city = state.city;
            if (city == null) {
              return const SizedBox.shrink();
            }

            final weather = state.weather;
            if (weather != null) {
              return WeatherWidget(
                cityName: city,
                weatherUiModel: weather,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
