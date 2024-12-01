import 'package:weather/domain/entity/measurement_unit.dart';
import 'package:weather/domain/entity/wind.dart';

class WeatherForecast {
  final DateTime date;

  final MeasurementUnit measurementUnit;

  /// The temperature.
  ///
  /// The unit of measurement is determined by the [measurementUnit] parameter.
  final double temperature;

  /// This temperature parameter accounts for the human perception of weather.
  ///
  /// The unit of measurement is determined by the [measurementUnit] parameter.
  final double temperatureFeelsLike;

  /// Atmospheric pressure on the sea level in hPa.
  final int pressure;

  /// The humidity in percentage.
  final int humidity;

  /// The weather condition like Rain, Snow, Clouds etc.
  final String weatherCondition;

  /// The cloudiness in percentage.
  final int cloudiness;

  final Wind wind;

  /// The visibility in meters.
  final int visibility;

  /// The probability of precipitation in percentage.
  ///
  /// The value is between 0 and 1,
  /// where 0 means no precipitation
  /// and 1 means 100% chance of precipitation.
  final double precipitationProbability;

  WeatherForecast({
    required this.date,
    required this.measurementUnit,
    required this.temperature,
    required this.temperatureFeelsLike,
    required this.pressure,
    required this.humidity,
    required this.weatherCondition,
    required this.cloudiness,
    required this.wind,
    required this.visibility,
    required this.precipitationProbability,
  });
}
