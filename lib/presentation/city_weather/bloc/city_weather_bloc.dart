import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/core/tools.dart';
import 'package:weather/domain/entity/measurement_unit.dart';
import 'package:weather/domain/use_cases/get_saved_city_use_case.dart';
import 'package:weather/domain/use_cases/get_weather_forecaset_use_case.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_ui_model_mapper.dart';

part 'city_weather_bloc.freezed.dart';
part 'city_weather_event.dart';
part 'city_weather_state.dart';

@injectable
class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  final GetSavedCityUseCase _getSavedCityUseCase;
  final GetWeatherForecastUseCase _getWeatherUseCase;
  final CityWeatherUiModelMapper _mapper;

  CityWeatherBloc(
    this._getSavedCityUseCase,
    this._getWeatherUseCase,
    this._mapper,
  ) : super(CityWeatherState.initial()) {
    on<CityWeatherEvent>((event, emit) async {
      await runCatching(
        action: () => event.when(
          init: () => _onInit(emit),
          fetchWeather: (city) => _fetchWeather(city, emit),
        ),
        onException: (e, _) {
          emit(state.copyWith(isLoading: false, exception: e));
        },
      );
    });
  }

  Future<void> _onInit(Emitter<CityWeatherState> emit) async {
    emit(state.copyWith(isLoading: true));
    final savedCity = await _getSavedCityUseCase.invoke();
    if (savedCity == null || savedCity.isEmpty) {
      emit(state.copyWith(isLoading: false));
    } else {
      return _fetchWeather(savedCity, emit);
    }
  }

  Future<void> _fetchWeather(
    String city,
    Emitter<CityWeatherState> emit,
  ) async {
    emit(state.copyWith(
      city: city,
      isLoading: true,
    ));
    final weather = await _getWeatherUseCase.invoke(city);
    final weatherUiModel = _mapper.mapWeatherToUiModel(weather);
    emit(state.copyWith(
      isLoading: false,
      weather: weatherUiModel,
      city: city,
    ));
  }
}
