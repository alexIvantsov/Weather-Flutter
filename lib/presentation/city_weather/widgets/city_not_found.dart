import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';

/// Represents the state when the entered city was not found.
///
/// There is an ability to change the city in this case.
class CityNotFound extends StatelessWidget {
  final String city;
  final VoidCallback onChangeCity;
  final double maxWidth;

  const CityNotFound({
    super.key,
    required this.city,
    required this.onChangeCity,
    this.maxWidth = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
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
