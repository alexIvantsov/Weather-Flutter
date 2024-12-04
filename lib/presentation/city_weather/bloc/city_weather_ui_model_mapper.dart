import 'package:injectable/injectable.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/formatters/formatter.dart';

@injectable
class CityWeatherUiModelMapper {
  WeatherUiModel mapWeatherToUiModel(WeatherForecast weather) {
    final formatter = Formatter(weather.measurementUnit);
    return WeatherUiModel(
      measurementUnit: weather.measurementUnit,
      temperature: formatter.formatTemperature(weather.temperature),
      temperatureFeelsLike:
          formatter.formatTemperature(weather.temperatureFeelsLike),
      minTemperature: formatter.formatTemperature(weather.minTemperature),
      maxTemperature: formatter.formatTemperature(weather.maxTemperature),
      pressure: weather.pressure,
      humidity: weather.humidity,
      weatherCondition: weather.weatherCondition,
      weatherConditionDescription: weather.weatherConditionDescription,
      cloudiness: weather.cloudiness,
      wind: WindUiModel(
        speed: weather.wind.speed,
        direction: weather.wind.direction,
        gust: weather.wind.gust,
      ),
      visibility: weather.visibility,
      precipitationProbability:
          (weather.precipitationProbability * 100).round(),
    );
  }
}
