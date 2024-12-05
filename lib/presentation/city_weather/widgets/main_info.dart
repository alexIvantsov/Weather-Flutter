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

  final double horizontalConstraint;

  static const _minHorizontalViewWidth = 300.0;
  static const _maxViewWidth = 400.0;

  const MainInfo({
    super.key,
    required this.measurementUnit,
    required this.temperature,
    required this.feelsLikeTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
    required this.type,
    required this.horizontalConstraint,
  });

  @override
  Widget build(BuildContext context) {
    final mainPart = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
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
    );

    final additionalPart = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(context.localizations.min(minTemperature)),
        const SizedBox(height: 8),
        Text(context.localizations.max(maxTemperature)),
        const SizedBox(height: 8),
        Text(context.localizations.feelsLike(feelsLikeTemperature)),
      ],
    );

    final isHorizontalLayout = horizontalConstraint >= _minHorizontalViewWidth;

    final Widget layout;
    if (isHorizontalLayout) {
      layout = _HorizontalLayout(
        main: mainPart,
        additional: additionalPart,
      );
    } else {
      layout = _VerticalLayout(
        main: mainPart,
        additional: additionalPart,
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(
        maxWidth: _maxViewWidth,
        minWidth: _minHorizontalViewWidth,
      ),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: layout,
    );
  }
}

class _HorizontalLayout extends StatelessWidget {
  final Widget main;
  final Widget additional;

  const _HorizontalLayout({
    required this.main,
    required this.additional,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: main),
        Expanded(child: additional),
      ],
    );
  }
}

class _VerticalLayout extends StatelessWidget {
  final Widget main;
  final Widget additional;

  const _VerticalLayout({
    required this.main,
    required this.additional,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        main,
        const SizedBox(height: 16),
        additional,
      ],
    );
  }
}
