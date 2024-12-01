import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather/di/injection.dart';
import 'package:weather/presentation/core/app_router.dart';

class AppWidget extends StatefulWidget {
  final AppRouterDelegateProvider routerDelegateProvider;

  const AppWidget({
    super.key,
    required this.routerDelegateProvider,
  });

  factory AppWidget.create() {
    return AppWidget(routerDelegateProvider: getIt());
  }

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: widget.routerDelegateProvider.routerDelegate,
      routeInformationParser:
          widget.routerDelegateProvider.routeInformationParser,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return AppRouterProvider(
          appRouter: AppRouter(widget.routerDelegateProvider),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
