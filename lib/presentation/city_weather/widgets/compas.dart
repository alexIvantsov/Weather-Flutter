import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/gen/assets.gen.dart';

class Compass extends StatelessWidget {
  final double radialDirection;

  const Compass(this.radialDirection, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('N', style: context.theme.textTheme.labelSmall),
        Transform.rotate(
          angle: radialDirection,
          child: SvgPicture.asset(
            Assets.icons.icCompass,
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }
}
