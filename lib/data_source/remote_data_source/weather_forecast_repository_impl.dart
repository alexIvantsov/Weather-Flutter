import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:weather/data_source/models/weather_response.dart';
import 'package:weather/data_source/remote_data_source/weather_mapper.dart';
import 'package:weather/domain/entity/measurement_unit.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/domain/exceptions/not_found_exception.dart';
import 'package:weather/domain/exceptions/unexpected_exception.dart';
import 'package:weather/domain/repositories/weather_forecast_repository.dart';
import 'package:weather/variables.dart' as variables;

@Injectable(as: WeatherForecastRepository)
class WeatherForecastRepositoryImpl implements WeatherForecastRepository {
  final WeatherMapper _weatherMapper;

  WeatherForecastRepositoryImpl(this._weatherMapper);

  @override
  Future<List<WeatherForecast>> getWeatherForecast(
    String cityName, {
    int forecastsCount = 1,
    MeasurementUnit measurementUnit = MeasurementUnit.metric,
  }) async {
    try {
      final uri = Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/data/2.5/forecast',
        queryParameters: {
          'q': cityName,
          'cnt': forecastsCount.toString(),
          'units': measurementUnit.value,
          'appid': variables.openWeatherMapApiKey,
        },
      );
      final result = await http.get(uri);
      final code = result.statusCode;
      switch (code) {
        case 200:
          return _bodyToWeatherForecastList(result.body, measurementUnit);
        case 404:
          throw NotFoundException();
        default:
          throw UnexpectedException(
              'Failed to get weather forecast. Status code: $code');
      }
    } on Exception catch (_) {
      rethrow;
    } catch (e, s) {
      log('Failed to get weather forecast', error: e, stackTrace: s);
      throw UnexpectedException(e.toString());
    }
  }

  List<WeatherForecast> _bodyToWeatherForecastList(
    String body,
    MeasurementUnit measurementUnit,
  ) {
    final json = jsonDecode(body);
    final weatherResponse = WeatherResponse.fromJson(json);
    return _weatherMapper.mapToWeatherForecastList(
      response: weatherResponse,
      measurementUnit: measurementUnit,
    );
  }
}
