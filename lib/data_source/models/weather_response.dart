import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

//ignore_for_file: invalid_annotation_target

/// OpenWeatherMap API response model
///
/// See https://openweathermap.org/forecast5#geocoding for more info.
@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    @JsonKey(name: 'cod') required String cod,
    @JsonKey(name: 'message') required int message,
    @JsonKey(name: 'cnt') required int count,
    @JsonKey(name: 'list') required List<WeatherDTOList> weatherList,
    @JsonKey(name: 'city') required CityDTO city,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}

@freezed
class WeatherDTOList with _$WeatherDTOList {
  const factory WeatherDTOList({
    @JsonKey(name: 'dt') required int dateSeconds,
    @JsonKey(name: 'main') required MainWeatherParamsDTO main,
    @JsonKey(name: 'weather') required List<WeatherDTO> weather,
    @JsonKey(name: 'clouds') required CloudsDTO clouds,
    @JsonKey(name: 'wind') required WindDTO wind,
    @JsonKey(name: 'visibility') required int? visibility,
    @JsonKey(name: 'pop') required double precipitationProbability,
    @JsonKey(name: 'rain') RainDTO? rain,
    @JsonKey(name: 'sys') SysDTO? sys,
    @JsonKey(name: 'dt_txt') required String dateText,
  }) = _WeatherDTOList;

  factory WeatherDTOList.fromJson(Map<String, dynamic> json) =>
      _$WeatherDTOListFromJson(json);
}

@freezed
class MainWeatherParamsDTO with _$MainWeatherParamsDTO {
  const factory MainWeatherParamsDTO({
    @JsonKey(name: 'temp') required double temperature,
    @JsonKey(name: 'feels_like') required double feelsLike,
    @JsonKey(name: 'temp_min') required double minTemperature,
    @JsonKey(name: 'temp_max') required double maxTemperature,
    @JsonKey(name: 'pressure') required int pressure,
    @JsonKey(name: 'sea_level') required int seaLevel,
    @JsonKey(name: 'grnd_level') required int groundLevel,
    @JsonKey(name: 'humidity') required int humidity,
    @JsonKey(name: 'temp_kf') required double temperatureKf,
  }) = _MainWeatherParamsDTO;

  factory MainWeatherParamsDTO.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherParamsDTOFromJson(json);
}

@freezed
class WeatherDTO with _$WeatherDTO {
  const factory WeatherDTO({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'main') required String main,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'icon') required String icon,
  }) = _WeatherDTO;

  factory WeatherDTO.fromJson(Map<String, dynamic> json) =>
      _$WeatherDTOFromJson(json);
}

@freezed
class CloudsDTO with _$CloudsDTO {
  const factory CloudsDTO({
    @JsonKey(name: 'all') required int all,
  }) = _CloudsDTO;

  factory CloudsDTO.fromJson(Map<String, dynamic> json) =>
      _$CloudsDTOFromJson(json);
}

@freezed
class WindDTO with _$WindDTO {
  const factory WindDTO({
    @JsonKey(name: 'speed') required double speed,
    @JsonKey(name: 'deg') required int degree,
    @JsonKey(name: 'gust') required double gust,
  }) = _WindDTO;

  factory WindDTO.fromJson(Map<String, dynamic> json) =>
      _$WindDTOFromJson(json);
}

@freezed
class RainDTO with _$RainDTO {
  const factory RainDTO({
    @JsonKey(name: '3h') required double threeHour,
  }) = _RainDTO;

  factory RainDTO.fromJson(Map<String, dynamic> json) =>
      _$RainDTOFromJson(json);
}

@freezed
class SysDTO with _$SysDTO {
  const factory SysDTO({
    @JsonKey(name: 'pod') required String pod,
  }) = _SysDTO;

  factory SysDTO.fromJson(Map<String, dynamic> json) => _$SysDTOFromJson(json);
}

@freezed
class CityDTO with _$CityDTO {
  const factory CityDTO({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'coord') required CoordinatesDTO coordinates,
    @JsonKey(name: 'country') required String country,
    @JsonKey(name: 'population') required int population,
    @JsonKey(name: 'timezone') required int timezone,
    @JsonKey(name: 'sunrise') required int sunrise,
    @JsonKey(name: 'sunset') required int sunset,
  }) = _CityDTO;

  factory CityDTO.fromJson(Map<String, dynamic> json) =>
      _$CityDTOFromJson(json);
}

@freezed
class CoordinatesDTO with _$CoordinatesDTO {
  const factory CoordinatesDTO({
    @JsonKey(name: 'lat') required double latitude,
    @JsonKey(name: 'lon') required double longitude,
  }) = _CoordinatesDTO;

  factory CoordinatesDTO.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesDTOFromJson(json);
}
