import 'package:weather/domain/entity/weather_forecast.dart';

abstract interface class WeatherForecastRepository {
  /// Returns the weather forecasts for the given [cityName].
  ///
  /// The list of forecasts is returned with some interval.
  /// The number of forecasts is determined by the [forecastsCount] parameter.
  Future<List<WeatherForecast>> getWeatherForecast(
    String cityName, {
    int forecastsCount = 1,
  });
}
