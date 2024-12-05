import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';

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
        backgroundColor: context.theme.colorScheme.tertiaryContainer,
        foregroundColor: context.theme.colorScheme.onTertiaryContainer,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
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
          Text(city),
          const SizedBox(width: 8),
          const Spacer(),
        ],
      ),
    );
  }
}
