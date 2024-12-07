import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/domain/entity/distance.dart';
import 'package:weather/gen/assets.gen.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/city_weather/widgets/parameter_widget.dart';
import 'package:weather/presentation/core/common_widgets/not_scrollable_grid_view.dart';

/// Represents the additional parameters of the weather forecast.
///
/// The parameters are:
/// - Pressure
/// - Humidity
/// - Cloudiness
/// - Wind
/// - Visibility
/// - Precipitation probability
class AdditionalParameters extends StatelessWidget {
  final String pressure;
  final String humidity;
  final String cloudiness;
  final WindUiModel wind;
  final DistanceUiModel? visibility;
  final String precipitationProbability;

  /// How many items should be in the row.
  final int itemsCountInTheRow;

  /// The width of the widget.
  ///
  /// If [scrollable] is false, the width must be provided,
  /// to calculate the items size.
  final double? width;

  /// Whether the widget should be scrollable.
  ///
  /// If false, the content will be displayed in a "grid" like view,
  /// it can be wrapped in a [SingleChildScrollView] to make it scrollable.
  final bool scrollable;
  final EdgeInsets? padding;

  final double itemsSpacing;
  final double itemAspectRatio;

  const AdditionalParameters({
    super.key,
    required this.pressure,
    required this.humidity,
    required this.cloudiness,
    required this.wind,
    required this.visibility,
    required this.precipitationProbability,
    required this.itemsCountInTheRow,
    this.width,
    this.padding,
    required this.scrollable,
    this.itemsSpacing = 8,
    this.itemAspectRatio = 1.35,
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
        crossAxisCount: itemsCountInTheRow,
        mainAxisSpacing: itemsSpacing,
        crossAxisSpacing: itemsSpacing,
        childAspectRatio: itemAspectRatio,
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
        crossAxisCount: itemsCountInTheRow,
        mainAxisSpacing: itemsSpacing,
        crossAxisSpacing: itemsSpacing,
        childAspectRatio: itemAspectRatio,
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
