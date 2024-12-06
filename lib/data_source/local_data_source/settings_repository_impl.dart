import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/domain/repositories/settings_repository.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  static const _cityKey = 'city';

  Future<SharedPreferences> get _sharedPrefsFuture =>
      SharedPreferences.getInstance();

  @override
  Future<String> getSavedCity() {
    return _sharedPrefsFuture.then((prefs) {
      return prefs.getString(_cityKey) ?? '';
    });
  }

  @override
  Future<void> saveCity(String city) {
    return _sharedPrefsFuture.then((prefs) async {
      await prefs.setString(_cityKey, city);
    });
  }
}
