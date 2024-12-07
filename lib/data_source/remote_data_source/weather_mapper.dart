import 'package:injectable/injectable.dart';
import 'package:weather/data_source/models/weather_icon_type.dart';
import 'package:weather/data_source/models/weather_response.dart';
import 'package:weather/domain/entity/distance.dart';
import 'package:weather/domain/entity/measurement_unit.dart';
import 'package:weather/domain/entity/weather_condition.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/domain/entity/wind.dart';

@lazySingleton
class WeatherMapper {
  /// Maps the [WeatherResponse] to a list of [WeatherForecast] entities.
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
      weatherCondition:
          _weatherConditionFromIcon(weatherList.weather.first.icon),
      weatherConditionDescription: weatherList.weather.first.description,
      cloudiness: weatherList.clouds.all,
      wind: Wind(
        speed: weatherList.wind.speed,
        // The API returns the wind degree from 0 to 360,
        // and it means the direction from which the wind is blowing.
        // Adding 180 degrees to the wind direction to get the direction
        // to which the wind is blowing.
        direction: weatherList.wind.degree + 180,
        gust: weatherList.wind.gust,
      ),
      visibility: _visibilityDistance(weatherList.visibility),
      precipitationProbability: weatherList.precipitationProbability,
    );
  }

  Distance? _visibilityDistance(int? visibility) {
    if (visibility == null) {
      return null;
    }
    return Distance(
      value: visibility,
      unit: DistanceUnit.meter,
    );
  }

  WeatherCondition _weatherConditionFromIcon(String weatherIcon) {
    final iconType = WeatherIconType.fromValue(weatherIcon);
    switch (iconType) {
      case WeatherIconType.clearSkyDay:
      case WeatherIconType.clearSkyNight:
        return WeatherCondition.clear;
      case WeatherIconType.fewCloudsDay:
      case WeatherIconType.fewCloudsNight:
      case WeatherIconType.brokenCloudsDay:
      case WeatherIconType.brokenCloudsNight:
        return WeatherCondition.cloudy;
      case WeatherIconType.scatteredCloudsDay:
      case WeatherIconType.scatteredCloudsNight:
        return WeatherCondition.scatteredClouds;
      case WeatherIconType.showerRainDay:
      case WeatherIconType.showerRainNight:
      case WeatherIconType.rainDay:
      case WeatherIconType.rainNight:
        return WeatherCondition.rain;
      case WeatherIconType.thunderstormDay:
      case WeatherIconType.thunderstormNight:
        return WeatherCondition.thunderstorm;
      case WeatherIconType.snowDay:
      case WeatherIconType.snowNight:
        return WeatherCondition.snow;
      case WeatherIconType.mistDay:
      case WeatherIconType.mistNight:
        return WeatherCondition.mist;
    }
  }
}
