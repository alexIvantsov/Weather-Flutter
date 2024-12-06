import 'package:injectable/injectable.dart';
import 'package:weather/data_source/models/weather_response.dart';
import 'package:weather/domain/entity/measurement_unit.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/domain/entity/wind.dart';

@lazySingleton
class WeatherMapper {
  List<WeatherForecast> mapToWeatherForecastList({
    required WeatherResponse response,
    required MeasurementUnit measurementUnit,
  }) {
    return response.weatherList
        .map((item) => _mapToWeatherForecast(item, measurementUnit))
        .toList();
  }

  WeatherForecast _mapToWeatherForecast(
    WeatherDTOList weatherList,
    MeasurementUnit measurementUnit,
  ) {
    return WeatherForecast(
      date: DateTime.fromMillisecondsSinceEpoch(weatherList.dateSeconds * 1000),
      measurementUnit: measurementUnit,
      temperature: weatherList.main.temperature,
      temperatureFeelsLike: weatherList.main.feelsLike,
      minTemperature: weatherList.main.minTemperature,
      maxTemperature: weatherList.main.maxTemperature,
      pressure: weatherList.main.pressure,
      humidity: weatherList.main.humidity,
      weatherCondition: weatherList.weather.first.main,
      weatherConditionDescription: weatherList.weather.first.description,
      cloudiness: weatherList.clouds.all,
      wind: Wind(
        speed: weatherList.wind.speed,
        direction: weatherList.wind.degree,
        gust: weatherList.wind.gust,
      ),
      visibility: weatherList.visibility,
      precipitationProbability: weatherList.precipitationProbability,
    );
  }
}
