import 'package:flutter/material.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/city_weather/widgets/main_info.dart';
import 'package:weather/presentation/enter_city/search_field.dart';

class WeatherWidget extends StatelessWidget {
  final String cityName;
  final WeatherUiModel weatherUiModel;

  const WeatherWidget({
    super.key,
    required this.cityName,
    required this.weatherUiModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SearchField(
            initialValue: cityName,
            isEditable: false,
          ),
          const SizedBox(height: 16),
          MainInfo(
            description: weatherUiModel.weatherConditionDescription,
            type: weatherUiModel.weatherCondition,
            measurementUnit: weatherUiModel.measurementUnit,
            temperature: weatherUiModel.temperature,
            feelsLikeTemperature: weatherUiModel.temperatureFeelsLike,
            minTemperature: weatherUiModel.minTemperature,
            maxTemperature: weatherUiModel.maxTemperature,
          ),
        ],
      ),
    );
  }
}
