import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/domain/entity/measurement_unit.dart';
import 'package:weather/domain/entity/weather_condition.dart';
import 'package:weather/gen/assets.gen.dart';

/// The widget with the main weather information.
///
/// The widget displays:
/// - weather condition icon,
/// - description,
/// - temperature,
/// - feels like temperature,
/// - min and max temperature.
class MainInfo extends StatelessWidget {
  final String weatherDescription;
  final WeatherCondition weatherCondition;
  final MeasurementUnit measurementUnit;
  final String temperature;
  final String feelsLikeTemperature;
  final String minTemperature;
  final String maxTemperature;

  final double horizontalConstraint;

  /// The width of the widget when the horizontal layout is used.
  ///
  /// If the available width is less than this value,
  /// the [_VerticalLayout] will be used, otherwise the [_HorizontalLayout].
  static const _minHorizontalViewWidth = 300.0;

  /// The maximum width of the widget.
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
    final weatherCondition = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          _conditionIconAssetPath(),
          width: 32,
          height: 32,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            weatherDescription,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleLarge?.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );

    final temperatureValue = Text(
      temperature,
      style: context.theme.textTheme.headlineLarge?.copyWith(
        fontSize: 74,
      ),
    );

    final additionalTemperatureValues = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _AdditionalItem(context.localizations.min(minTemperature)),
        const SizedBox(height: 8),
        _AdditionalItem(context.localizations.max(maxTemperature)),
        const SizedBox(height: 8),
        _AdditionalItem(context.localizations.feelsLike(feelsLikeTemperature)),
      ],
    );

    final isHorizontalLayout = horizontalConstraint >= _minHorizontalViewWidth;

    final Widget layout;
    if (isHorizontalLayout) {
      layout = _HorizontalLayout(
        main: temperatureValue,
        additional: additionalTemperatureValues,
      );
    } else {
      layout = _VerticalLayout(
        main: temperatureValue,
        additional: additionalTemperatureValues,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          weatherCondition,
          const SizedBox(height: 8),
          layout,
        ],
      ),
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

class _AdditionalItem extends StatelessWidget {
  final String value;

  const _AdditionalItem(this.value);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.theme.textTheme.bodyMedium?.copyWith(
        color: context.theme.colorScheme.secondary,
      ),
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
        Expanded(child: Center(child: additional)),
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
