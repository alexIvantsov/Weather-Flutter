import 'package:intl/intl.dart';
import 'package:weather/domain/entity/measurement_unit.dart';

class Formatter {
  final MeasurementUnit _measurementUnit;

  Formatter(this._measurementUnit);

  String formatTemperature(double temperature) {
    final numberFormat = NumberFormat('0.#');
    return '${numberFormat.format(temperature)}°';
  }

  String formatPressure(int pressure) {
    return pressure.toString();
  }

  String formatPercentage(num percentage) {
    return '$percentage%';
  }

  String formatSpeed(double speed) {
    final numberFormat = NumberFormat('0.#');
    return numberFormat.format(speed);
  }
}
