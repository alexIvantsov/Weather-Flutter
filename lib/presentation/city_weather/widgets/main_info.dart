import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/domain/entity/measurement_unit.dart';

class MainInfo extends StatelessWidget {
  final String description;
  final String type;
  final MeasurementUnit measurementUnit;
  final String temperature;
  final String feelsLikeTemperature;
  final String minTemperature;
  final String maxTemperature;

  const MainInfo({
    super.key,
    required this.measurementUnit,
    required this.temperature,
    required this.feelsLikeTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.sunny),
                      const SizedBox(width: 8),
                      Text(description),
                    ],
                  ),
                  Text(
                    temperature,
                    style: context.theme.textTheme.headlineLarge?.copyWith(
                      fontSize: 74,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(context.localizations.min(minTemperature)),
                  const SizedBox(height: 8),
                  Text(context.localizations.max(maxTemperature)),
                  const SizedBox(height: 8),
                  Text(context.localizations.feelsLike(feelsLikeTemperature)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
