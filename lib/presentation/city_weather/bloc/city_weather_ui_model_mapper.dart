import 'package:injectable/injectable.dart';
import 'package:weather/domain/entity/distance.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/formatters/formatter.dart';

@injectable
class CityWeatherUiModelMapper {
  final _formatter = Formatter();

  WeatherUiModel mapWeatherToUiModel(WeatherForecast weather) {
    final precipitationProbability =
        (weather.precipitationProbability * 100).round();
    return WeatherUiModel(
      measurementUnit: weather.measurementUnit,
      temperature: _formatter.formatTemperature(weather.temperature),
      temperatureFeelsLike:
          _formatter.formatTemperature(weather.temperatureFeelsLike),
      minTemperature: _formatter.formatTemperature(weather.minTemperature),
      maxTemperature: _formatter.formatTemperature(weather.maxTemperature),
      pressureBar: _formatter.formatPressure(weather.pressureBar),
      humidity: _formatter.formatPercentage(weather.humidity),
      weatherCondition: weather.weatherCondition,
      weatherConditionDescription: weather.weatherConditionDescription,
      cloudiness: _formatter.formatPercentage(weather.cloudiness),
      wind: WindUiModel(
        speed: _formatter.formatDouble(weather.wind.speed),
        radianDirection: weather.wind.radiansDirection(),
        gust: _formatter.formatDouble(weather.wind.gust),
      ),
      visibility: _mapDistanceToUiModel(weather.visibility),
      precipitationProbability:
          _formatter.formatPercentage(precipitationProbability),
    );
  }

  DistanceUiModel? _mapDistanceToUiModel(Distance? distance) {
    if (distance == null) {
      return null;
    }

    final unit = distance.unit;
    if (unit == DistanceUnit.meter && distance.value >= 1000) {
      final kilometers = distance.value / 1000;
      return DistanceUiModel(
        value: _formatter.formatDouble(kilometers),
        unit: DistanceUnit.kilometer,
      );
    }
    return DistanceUiModel(
      value: distance.value.round().toString(),
      unit: distance.unit,
    );
  }


}
