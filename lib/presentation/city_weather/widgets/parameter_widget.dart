import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/core/extensions/context_extension.dart';

class ParameterWidget extends StatelessWidget {
  final String title;
  final String value;
  final String svgIconAssetPath;

  const ParameterWidget({
    super.key,
    required this.title,
    required this.value,
    required this.svgIconAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgIconAssetPath,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: context.theme.colorScheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                maxLines: 1,
                style: context.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 42,
                  color: context.theme.colorScheme.onTertiaryContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
