import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';

class CityNotFound extends StatelessWidget {
  final String city;
  final VoidCallback onChangeCity;

  const CityNotFound({
    super.key,
    required this.city,
    required this.onChangeCity,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.localizations.cityNotFound(city),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onChangeCity,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.theme.colorScheme.primary,
                foregroundColor: context.theme.colorScheme.onPrimary,
              ),
              child: Text(context.localizations.enterAnotherCity),
            ),
          ],
        ),
      ),
    );
  }
}
