import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/city_weather/widgets/additional_parameters.dart';
import 'package:weather/presentation/city_weather/widgets/city_button.dart';
import 'package:weather/presentation/city_weather/widgets/main_info.dart';

class WeatherWidget extends StatelessWidget {
  final String cityName;
  final WeatherUiModel weatherUiModel;

  const WeatherWidget({
    super.key,
    required this.cityName,
    required this.weatherUiModel,
  });

  static const _horizontalLeftFlex = 3;
  static const _horizontalRightFlex = 4;
  static const _horizontalSpacing = 16.0;
  static const _phonePortraitMaxWidth = 600.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isHorizontalLayout = this.isHorizontalLayout(constraints);

          final paramsWidth = isHorizontalLayout
              ? calculateParamsViewWidthInHorizontalLayout(constraints.maxWidth)
              : calculateParamsViewWidthInVerticalLayout(constraints.maxWidth);

          final mainInfoWidth = isHorizontalLayout
              ? constraints.maxWidth - paramsWidth - _horizontalSpacing
              : constraints.maxWidth;

          final paramsCrossAxisCount =
              calculateParamsItemsCountInRow(paramsWidth);

          final city = ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: CityButton(
              city: cityName,
              onPressed: () => _onCityButtonPressed(context),
            ),
          );

          final mainInfo = MainInfo(
            description: weatherUiModel.weatherConditionDescription,
            type: weatherUiModel.weatherCondition,
            measurementUnit: weatherUiModel.measurementUnit,
            temperature: weatherUiModel.temperature,
            feelsLikeTemperature: weatherUiModel.temperatureFeelsLike,
            minTemperature: weatherUiModel.minTemperature,
            maxTemperature: weatherUiModel.maxTemperature,
            horizontalConstraint: mainInfoWidth,
          );

          final additionalInfo = AdditionalParameters(
            padding: isHorizontalLayout ? const EdgeInsets.all(16) : null,
            pressure: weatherUiModel.pressureBar,
            humidity: weatherUiModel.humidity,
            cloudiness: weatherUiModel.cloudiness,
            wind: weatherUiModel.wind,
            visibility: weatherUiModel.visibility,
            precipitationProbability: weatherUiModel.precipitationProbability,
            crossAxisCount: paramsCrossAxisCount,
            width: paramsWidth,
            scrollable: isHorizontalLayout,
          );

          if (isHorizontalLayout) {
            return _HorizontalLayout(
              city: city,
              mainInfo: mainInfo,
              additionalInfo: additionalInfo,
              leftFlex: _horizontalLeftFlex,
              rightFlex: _horizontalRightFlex,
              spacing: _horizontalSpacing,
            );
          } else {
            return _VerticalLayout(
              city: city,
              mainInfo: mainInfo,
              additionalInfo: additionalInfo,
              constraints: constraints,
            );
          }
        },
      ),
    );
  }

  void _onCityButtonPressed(BuildContext context) {
    context.appRouter.pushNamed('/enter_city');
  }

  bool isHorizontalLayout(BoxConstraints constraints) {
    final aspectRatio = constraints.maxWidth / constraints.maxHeight;
    return aspectRatio >= 2 && constraints.maxHeight < _phonePortraitMaxWidth;
  }

  int calculateParamsItemsCountInRow(double paramsWidth) {
    var paramsCrossAxisCount = paramsWidth ~/ 160;
    if (paramsWidth > 300) {
      paramsCrossAxisCount = max(paramsCrossAxisCount, 2);
    }
    paramsCrossAxisCount = max(paramsCrossAxisCount, 1);
    return paramsCrossAxisCount;
  }

  double calculateParamsViewWidthInHorizontalLayout(double widthConstraint) {
    const paramsWidthCoefficient =
        _horizontalRightFlex / (_horizontalLeftFlex + _horizontalRightFlex);
    var paramsWidth =
        (widthConstraint - _horizontalSpacing) * paramsWidthCoefficient;
    return min(paramsWidth, _phonePortraitMaxWidth);
  }

  double calculateParamsViewWidthInVerticalLayout(double widthConstraint) {
    return min(widthConstraint, _phonePortraitMaxWidth);
  }
}

class _HorizontalLayout extends StatelessWidget {
  final Widget city;
  final Widget mainInfo;
  final Widget additionalInfo;
  final int leftFlex;
  final int rightFlex;
  final double spacing;

  const _HorizontalLayout({
    required this.city,
    required this.mainInfo,
    required this.additionalInfo,
    required this.leftFlex,
    required this.rightFlex,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                city,
                SizedBox(height: spacing),
                mainInfo,
              ],
            ),
          ),
        ),
        SizedBox(width: spacing),
        Flexible(
          flex: 4,
          child: additionalInfo,
        ),
      ],
    );
  }
}

class _VerticalLayout extends StatelessWidget {
  final Widget city;
  final Widget mainInfo;
  final Widget additionalInfo;
  final BoxConstraints constraints;

  const _VerticalLayout({
    required this.city,
    required this.mainInfo,
    required this.additionalInfo,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(vertical: 16);
    return SingleChildScrollView(
      padding: padding,
      child: IntrinsicHeight(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight - padding.vertical,
          ),
          child: Column(
            children: [
              city,
              const SizedBox(height: 16),
              const Spacer(flex: 1),
              mainInfo,
              const SizedBox(height: 16),
              const Spacer(flex: 1),
              additionalInfo,
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
