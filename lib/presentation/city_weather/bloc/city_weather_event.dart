part of 'city_weather_bloc.dart';

@freezed
class CityWeatherEvent with _$CityWeatherEvent {
  const factory CityWeatherEvent.init() = _Init;

  const factory CityWeatherEvent.fetchWeather(String city) = _FetchWeather;
}
