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
    required String pressure,
    required String humidity,
    required String weatherCondition,
    required String weatherConditionDescription,
    required String cloudiness,
    required WindUiModel wind,
    required String visibility,
    required String precipitationProbability,
  }) = _WeatherUiModel;
}

@freezed
class WindUiModel with _$WindUiModel {
  const factory WindUiModel({
    required String speed,
    required double radianDirection,
    required String gust,
  }) = _WindUiModel;
}
