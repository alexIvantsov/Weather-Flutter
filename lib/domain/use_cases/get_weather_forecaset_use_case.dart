import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/domain/exceptions/not_found_exception.dart';
import 'package:weather/domain/repositories/settings_repository.dart';
import 'package:weather/domain/repositories/weather_forecast_repository.dart';

/// Use case to get the weather forecast for the given [cityName].
///
/// If the forecast is not found, [NotFoundException] is thrown.
/// If the forecast is found, the city is saved to the settings,
/// so that it can be used as default city on the next app launch.
@injectable
class GetWeatherForecastUseCase {
  final WeatherForecastRepository _weatherRepository;
  final SettingsRepository _settingsRepository;

  GetWeatherForecastUseCase(
    this._weatherRepository,
    this._settingsRepository,
  );

  Future<WeatherForecast> invoke(String cityName) async {
    final forecast = await _weatherRepository.getWeatherForecast(cityName);
    if (forecast.isEmpty) throw NotFoundException();
    unawaited(_settingsRepository.saveCity(cityName));
    return forecast.first;
  }
}
