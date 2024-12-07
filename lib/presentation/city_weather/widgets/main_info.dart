import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/domain/entity/measurement_unit.dart';
import 'package:weather/domain/entity/weather_condition.dart';
import 'package:weather/gen/assets.gen.dart';

class MainInfo extends StatelessWidget {
  final String weatherDescription;
  final WeatherCondition weatherCondition;
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
    required this.weatherDescription,
    required this.weatherCondition,
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
            SvgPicture.asset(
              _conditionIconAssetPath(),
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 8),
            Text(weatherDescription),
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

  String _conditionIconAssetPath() {
    return switch (weatherCondition) {
      WeatherCondition.clear => Assets.icons.icClearSky,
      WeatherCondition.cloudy => Assets.icons.icFewClouds,
      WeatherCondition.scatteredClouds => Assets.icons.icScatteredClouds,
      WeatherCondition.rain => Assets.icons.icRain,
      WeatherCondition.snow => Assets.icons.icSnow,
      WeatherCondition.mist => Assets.icons.icMist,
      WeatherCondition.thunderstorm => Assets.icons.icThunderstorm,
    };
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
