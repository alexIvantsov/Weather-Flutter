import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/gen/assets.gen.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/core/common_widgets/compas.dart';

/// Widget which represents weather parameter (like pressure, humidity, etc.).
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
    return _Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(
            title: title,
            svgIconAssetPath: svgIconAssetPath,
          ),
          Expanded(child: _Value(value)),
        ],
      ),
    );
  }
}

class WindParameterWidget extends StatelessWidget {
  final WindUiModel wind;

  const WindParameterWidget(
    this.wind, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(
                  title: context.localizations.wind,
                  svgIconAssetPath: Assets.icons.icWind,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _Value(
                          context.localizations.speedValue(wind.speed),
                        ),
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(context.localizations.gustValue(wind.gust)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Compass(wind.radianDirection),
        ],
      ),
    );
  }
}

class _Value extends StatelessWidget {
  final String value;

  const _Value(this.value);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        value,
        maxLines: 1,
        style: context.theme.textTheme.headlineLarge?.copyWith(
          fontSize: 42,
          color: context.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}

class _Container extends StatelessWidget {
  final Widget child;

  const _Container({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String svgIconAssetPath;

  const _Header({
    required this.title,
    required this.svgIconAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          svgIconAssetPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            context.theme.colorScheme.onTertiaryContainer,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleMedium?.copyWith(
              color: context.theme.colorScheme.onTertiaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
