import 'package:weather/domain/entity/weather_forecast.dart';

/// Measurement system used to represent the values of [WeatherForecast].
///
/// Currently, only [MeasurementUnit.metric] is supported.
enum MeasurementUnit {
  /// Temperature is measured in Fahrenheit
  imperial('imperial'),

  /// Temperature is measured in Celsius
  metric('metric'),

  /// Temperature is measured in Kelvin
  standard('default');

  final String value;

  const MeasurementUnit(this.value);
}
