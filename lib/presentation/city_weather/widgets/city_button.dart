import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';

/// Button with the current city name.
///
/// Used to change the city by redirecting to the screen where the user can
/// enter the city name.
class CityButton extends StatelessWidget {
  final String city;
  final VoidCallback onPressed;

  const CityButton({
    super.key,
    required this.city,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.theme.colorScheme.secondaryFixedDim,
        foregroundColor: context.theme.colorScheme.onSecondaryFixedVariant,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.search),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            city,
            style: context.theme.textTheme.titleLarge?.copyWith(
              color: context.theme.colorScheme.onSecondaryFixedVariant,
            ),
          ),
          const SizedBox(width: 8),
          const Spacer(),
        ],
      ),
    );
  }
}
