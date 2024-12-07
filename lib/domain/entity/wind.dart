import 'dart:math';

class Wind {
  /// Unit depends on the [MeasurementUnit] in the [WeatherForecast] object.
  final double speed;

  /// The direction of the wind in degrees.
  final int direction;

  /// Wind gust.
  ///
  /// Unit depends on the [MeasurementUnit] in the [WeatherForecast] object.
  final double gust;

  Wind({
    required this.speed,
    required this.direction,
    required this.gust,
  });

  double radiansDirection() {
    return direction * (pi / 180);
  }
}
