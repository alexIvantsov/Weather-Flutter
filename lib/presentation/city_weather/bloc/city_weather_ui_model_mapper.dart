import 'package:injectable/injectable.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/formatters/formatter.dart';

@injectable
class CityWeatherUiModelMapper {
  WeatherUiModel mapWeatherToUiModel(WeatherForecast weather) {
    final formatter = Formatter(weather.measurementUnit);
    final precipitationProbability =
        (weather.precipitationProbability * 100).round();
    return WeatherUiModel(
      measurementUnit: weather.measurementUnit,
      temperature: formatter.formatTemperature(weather.temperature),
      temperatureFeelsLike:
          formatter.formatTemperature(weather.temperatureFeelsLike),
      minTemperature: formatter.formatTemperature(weather.minTemperature),
      maxTemperature: formatter.formatTemperature(weather.maxTemperature),
      pressure: formatter.formatPressure(weather.pressure),
      humidity: formatter.formatPercentage(weather.humidity),
      weatherCondition: weather.weatherCondition,
      weatherConditionDescription: weather.weatherConditionDescription,
      cloudiness: formatter.formatPercentage(weather.cloudiness),
      wind: WindUiModel(
        speed: formatter.formatSpeed(weather.wind.speed),
        direction: weather.wind.direction,
        gust: formatter.formatSpeed(weather.wind.gust),
      ),
      visibility: weather.visibility,
      precipitationProbability:
          formatter.formatPercentage(precipitationProbability),
    );
  }
}
