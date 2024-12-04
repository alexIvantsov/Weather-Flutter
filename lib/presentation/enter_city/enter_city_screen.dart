import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';
import 'package:weather/presentation/city_weather/widgets/search_field_widget.dart';

class EnterCityScreen extends StatelessWidget {
  const EnterCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SearchFieldWidget(
            onSubmitted: (value) {
              context.appRouter.pushReplacementNamed('/city_weather/$value');
            },
          ),
        ),
      ),
    );
  }
}
