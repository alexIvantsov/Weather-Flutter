part of 'city_weather_bloc.dart';

@freezed
class CityWeatherState with _$CityWeatherState {
  const factory CityWeatherState({
    required WeatherUiModel? weather,
    required bool isLoading,
    required Object? exception,
    required String? city,
  }) = _CityWeatherState;

  factory CityWeatherState.initial() {
    return const CityWeatherState(
      weather: null,
      isLoading: true,
      exception: null,
      city: null,
    );
  }
}

@freezed
class WeatherUiModel with _$WeatherUiModel {
  const factory WeatherUiModel({
    required MeasurementUnit measurementUnit,
    required String temperature,
    required String temperatureFeelsLike,
    required String minTemperature,
    required String maxTemperature,
    required int pressure,
    required int humidity,
    required String weatherCondition,
    required String weatherConditionDescription,
    required int cloudiness,
    required WindUiModel wind,
    required int visibility,
    required int precipitationProbability,
  }) = _WeatherUiModel;
}

@freezed
class WindUiModel with _$WindUiModel {
  const factory WindUiModel({
    required double speed,
    required int direction,
    required double gust,
  }) = _WindUiModel;
}
