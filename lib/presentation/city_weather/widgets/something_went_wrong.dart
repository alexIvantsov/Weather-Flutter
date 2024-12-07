import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';

class SomethingWentWrong extends StatelessWidget {
  final String city;
  final VoidCallback onRetry;
  final VoidCallback onEnterAnotherCity;

  const SomethingWentWrong({
    super.key,
    required this.city,
    required this.onRetry,
    required this.onEnterAnotherCity,
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
              context.localizations.somethingWentWrong,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.theme.colorScheme.primary,
                foregroundColor: context.theme.colorScheme.onPrimary,
              ),
              child: Text(context.localizations.retry),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onEnterAnotherCity,
              child: Text(context.localizations.enterAnotherCity),
            ),
          ],
        ),
      ),
    );
  }
}
