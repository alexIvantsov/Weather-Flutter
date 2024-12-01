import 'package:injectable/injectable.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';

@injectable
class CityWeatherUiModelMapper {
  WeatherUiModel mapWeatherToUiModel(WeatherForecast weather) {
    return WeatherUiModel(
      measurementUnit: weather.measurementUnit,
      temperature: weather.temperature.round(),
      temperatureFeelsLike: weather.temperatureFeelsLike.round(),
      pressure: weather.pressure,
      humidity: weather.humidity,
      weatherCondition: weather.weatherCondition,
      cloudiness: weather.cloudiness,
      wind: WindUiModel(
        speed: weather.wind.speed,
        direction: weather.wind.direction,
        gust: weather.wind.gust,
      ),
      visibility: weather.visibility,
      precipitationProbability:
          (weather.precipitationProbability * 100).round(),
    );
  }
}
