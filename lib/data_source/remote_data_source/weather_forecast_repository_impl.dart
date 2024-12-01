import 'package:injectable/injectable.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/domain/repositories/weather_forecast_repository.dart';

@Injectable(as: WeatherForecastRepository)
class WeatherForecastRepositoryImpl implements WeatherForecastRepository {
  @override
  Future<List<WeatherForecast>> getWeatherForecast(
    String cityName, {
    int forecastsCount = 1,
  }) async {
    throw UnimplementedError();
  }
}
