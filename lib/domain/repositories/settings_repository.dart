abstract interface class SettingsRepository {
  Future<String> getSavedCity();

  Future<void> saveCity(String city);
}
