import 'package:flutter/material.dart';
import 'package:weather/presentation/city_weather/widgets/search_field_widget.dart';

class SearchStateWidget extends StatelessWidget {
  final String value;
  final ValueChanged<String> onSubmitted;

  const SearchStateWidget({
    super.key,
    required this.value,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SearchFieldWidget(
        value: value,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
