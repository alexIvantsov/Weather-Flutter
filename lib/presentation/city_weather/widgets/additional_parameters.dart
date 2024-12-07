import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/domain/entity/distance.dart';
import 'package:weather/gen/assets.gen.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/city_weather/widgets/parameter_widget.dart';
import 'package:weather/presentation/core/common_widgets/not_scrollable_grid_view.dart';

class AdditionalParameters extends StatelessWidget {
  final String pressure;
  final String humidity;
  final String cloudiness;
  final WindUiModel wind;
  final DistanceUiModel? visibility;
  final String precipitationProbability;

  final int crossAxisCount;
  final double? width;
  final bool scrollable;
  final EdgeInsets? padding;

  const AdditionalParameters({
    super.key,
    required this.pressure,
    required this.humidity,
    required this.cloudiness,
    required this.wind,
    required this.visibility,
    required this.precipitationProbability,
    required this.crossAxisCount,
    this.width,
    this.padding,
    required this.scrollable,
  }) : assert(!scrollable || (scrollable && width != null));

  @override
  Widget build(BuildContext context) {
    final parameters = [
      ParameterWidget(
        title: context.localizations.pressure,
        value: context.localizations.pressureValue(pressure),
        svgIconAssetPath: Assets.icons.icAirPressure,
      ),
      ParameterWidget(
        title: context.localizations.humidity,
        value: humidity,
        svgIconAssetPath: Assets.icons.icHumidity,
      ),
      ParameterWidget(
        title: context.localizations.cloudiness,
        value: cloudiness,
        svgIconAssetPath: Assets.icons.icCloudiness,
      ),
      WindParameterWidget(wind),
      if (visibility != null)
        ParameterWidget(
          title: context.localizations.visibility,
          value: _distance(context, visibility!),
          svgIconAssetPath: Assets.icons.icFog,
        ),
      ParameterWidget(
        title: context.localizations.precipitationProbability,
        value: precipitationProbability,
        svgIconAssetPath: Assets.icons.icPrecipitation,
      ),
    ];

    if (scrollable) {
      final gridView = GridView.count(
        padding: padding,
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.35,
        children: parameters,
      );
      if (width == null) {
        return gridView;
      }
      return SizedBox(
        width: width,
        child: gridView,
      );
    } else {
      if (width == null) {
        throw Exception('Width must be provided for the not scrollable view');
      }
      return NotScrollableGridView(
        padding: padding,
        width: width!,
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.35,
        children: parameters,
      );
    }
  }

  String _distance(BuildContext context, DistanceUiModel distance) {
    return switch (distance.unit) {
      DistanceUnit.meter =>
        context.localizations.distanceMetersValue(distance.value),
      DistanceUnit.kilometer =>
        context.localizations.distanceKilometersValue(distance.value),
    };
  }
}
