import 'package:injectable/injectable.dart';
import 'package:weather/domain/repositories/settings_repository.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  @override
  Future<String> getSavedCity() {
    // TODO: implement getSavedCity
    throw UnimplementedError();
  }

  @override
  Future<void> saveCity(String city) {
    // TODO: implement saveCity
    throw UnimplementedError();
  }
}
