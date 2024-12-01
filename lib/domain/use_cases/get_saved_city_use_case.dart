import 'package:injectable/injectable.dart';
import 'package:weather/domain/repositories/settings_repository.dart';

@injectable
class GetSavedCityUseCase {
  final SettingsRepository _settingsRepository;

  GetSavedCityUseCase(this._settingsRepository);

  Future<String?> invoke() => _settingsRepository.getSavedCity();
}
