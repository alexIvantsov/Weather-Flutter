part of 'city_weather_bloc.dart';

@freezed
class CityWeatherEvent with _$CityWeatherEvent {
  /// Check if there is saved city and fetch weather for it.
  const factory CityWeatherEvent.init() = _Init;

  /// Fetch weather for the given city.
  const factory CityWeatherEvent.fetchWeather(String city) = _FetchWeather;
}
