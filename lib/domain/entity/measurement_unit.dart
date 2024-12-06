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
