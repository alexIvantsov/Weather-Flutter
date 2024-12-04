// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:weather/data_source/local_data_source/settings_repository_impl.dart'
    as _i209;
import 'package:weather/data_source/remote_data_source/weather_forecast_repository_impl.dart'
    as _i447;
import 'package:weather/domain/repositories/settings_repository.dart' as _i281;
import 'package:weather/domain/repositories/weather_forecast_repository.dart'
    as _i602;
import 'package:weather/domain/use_cases/get_saved_city_use_case.dart' as _i54;
import 'package:weather/domain/use_cases/get_weather_forecaset_use_case.dart'
    as _i170;
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart'
    as _i747;
import 'package:weather/presentation/city_weather/bloc/city_weather_ui_model_mapper.dart'
    as _i556;
import 'package:weather/presentation/core/app_router.dart' as _i416;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i416.AppRouterConfigProvider>(
        () => _i416.AppRouterConfigProvider());
    gh.factory<_i556.CityWeatherUiModelMapper>(
        () => _i556.CityWeatherUiModelMapper());
    gh.factory<_i281.SettingsRepository>(() => _i209.SettingsRepositoryImpl());
    gh.factory<_i602.WeatherForecastRepository>(
        () => _i447.WeatherForecastRepositoryImpl());
    gh.factory<_i54.GetSavedCityUseCase>(
        () => _i54.GetSavedCityUseCase(gh<_i281.SettingsRepository>()));
    gh.factory<_i170.GetWeatherForecastUseCase>(
        () => _i170.GetWeatherForecastUseCase(
              gh<_i602.WeatherForecastRepository>(),
              gh<_i281.SettingsRepository>(),
            ));
    gh.factory<_i747.CityWeatherBloc>(() => _i747.CityWeatherBloc(
          gh<_i54.GetSavedCityUseCase>(),
          gh<_i170.GetWeatherForecastUseCase>(),
          gh<_i556.CityWeatherUiModelMapper>(),
        ));
    return this;
  }
}
