import 'package:flutter/material.dart';
import 'package:weather/gen/assets.gen.dart';
import 'package:weather/presentation/city_weather/widgets/parameter_widget.dart';

class AdditionalParameters extends StatelessWidget {
  final String pressure;
  final String humidity;
  final String cloudiness;

  const AdditionalParameters({
    super.key,
    required this.pressure,
    required this.humidity,
    required this.cloudiness,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.3,
      children: [
        ParameterWidget(
          title: 'Pressure',
          value: '$pressure hPa',
          svgIconAssetPath: Assets.icons.icAirPressure,
        ),
        ParameterWidget(
          title: 'Humidity',
          value: humidity,
          svgIconAssetPath: Assets.icons.icHumidity,
        ),
        ParameterWidget(
          title: 'Cloudiness',
          value: cloudiness,
          svgIconAssetPath: Assets.icons.icCloudiness,
        ),
      ],
    );
  }
}
