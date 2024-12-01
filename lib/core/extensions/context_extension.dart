import 'package:flutter/material.dart';
import 'package:weather/presentation/core/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExtension on BuildContext {
  AppRouter get appRouter => AppRouterProvider.of(this);

  ThemeData get theme => Theme.of(this);

  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
