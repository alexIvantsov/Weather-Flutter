import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/gen/assets.gen.dart';
import 'package:weather/presentation/enter_city/search_field.dart';

class EnterCityScreen extends StatefulWidget {
  const EnterCityScreen({super.key});

  @override
  State<EnterCityScreen> createState() => _EnterCityScreenState();
}

class _EnterCityScreenState extends State<EnterCityScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  bool isButtonEnabled = false;

  static const _smallHeightThreshold = 250;
  static const _maxWidthWithButton = 450.0;
  static const _maxWidthWithoutButton = 400.0;

  @override
  void initState() {
    controller.addListener(textControllerListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallHeight = constraints.maxHeight < _smallHeightThreshold;
          return SingleChildScrollView(
            child: IntrinsicHeight(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    // If the height is small, the width should be bigger
                    // because the button will be in the same row as the text field.
                    maxWidth: isSmallHeight
                        ? _maxWidthWithButton
                        : _maxWidthWithoutButton,
                    minHeight: constraints.maxHeight,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      SvgPicture.asset(Assets.icons.icWeather),
                      const Spacer(flex: 1),
                      Text(context.localizations.enterCityToSeeWeather),
                      const SizedBox(height: 16),
                      _SearchField(
                        controller: controller,
                        isVerticalView: !isSmallHeight,
                        onSubmitted: isButtonEnabled ? onSubmitted : null,
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void textControllerListener() {
    final isButtonEnabled = controller.text.isNotEmpty;
    if (this.isButtonEnabled != isButtonEnabled) {
      setState(() {
        this.isButtonEnabled = isButtonEnabled;
      });
    }
  }

  void onSubmitted() {
    context.appRouter.replaceAllNamed('/city_weather/${controller.text}');
  }

  @override
  void dispose() {
    controller.removeListener(textControllerListener);
    controller.dispose();
    super.dispose();
  }
}

class _SearchField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSubmitted;
  final bool isVerticalView;

  const _SearchField({
    required this.controller,
    this.onSubmitted,
    this.isVerticalView = true,
  });

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final searchFieldKey = GlobalKey();
  final searchButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final searchField = SearchField(
      key: searchFieldKey,
      controller: widget.controller,
    );
    final searchButton = _SearchButton(
      key: searchButtonKey,
      onTap: widget.onSubmitted,
    );

    if (widget.isVerticalView) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchField,
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: searchButton,
          ),
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: searchField),
        const SizedBox(width: 8),
        searchButton,
      ],
    );
  }
}

class _SearchButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _SearchButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.primary,
        foregroundColor: context.theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        minimumSize: const Size(0, 54),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      onPressed: onTap,
      child: Text(context.localizations.search),
    );
  }
}
