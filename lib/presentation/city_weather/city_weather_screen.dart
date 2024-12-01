import 'package:flutter/material.dart';
import 'package:weather/presentation/city_weather/widgets/search_field_widget.dart';

class CityWeatherScreen extends StatelessWidget {
  const CityWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SearchFieldWidget(
          onSubmitted: (value) {
            print(value);
          },
        ),
      ),
    );
  }
}
