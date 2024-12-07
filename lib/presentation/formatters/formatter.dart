import 'package:intl/intl.dart';

class Formatter {
  final _oneSignNumberFormatter = NumberFormat('0.#');

  String formatTemperature(double temperature) {
    final roundedTemperature = temperature.round();
    return '${_oneSignNumberFormatter.format(roundedTemperature)}°';
  }

  String formatPressure(double pressure) {
    return _oneSignNumberFormatter.format(pressure);
  }

  String formatPercentage(num percentage) {
    return '$percentage%';
  }

  String formatDouble(double speed) {
    return _oneSignNumberFormatter.format(speed);
  }
}
