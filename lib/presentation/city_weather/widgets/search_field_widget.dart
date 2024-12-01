import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';

class SearchFieldWidget extends StatefulWidget {
  final String value;
  final ValueChanged<String> onSubmitted;

  const SearchFieldWidget({
    super.key,
    this.value = '',
    required this.onSubmitted,
  });

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textField = TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: context.localizations.enterCityName,
        prefixIcon: const Icon(Icons.search),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );

    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      onPressed: onSubmitted,
      child: Text(context.localizations.search),
    );

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(24),
            ),
            child: textField,
          ),
        ),
        button,
      ],
    );
  }

  void onSubmitted() {
    widget.onSubmitted(controller.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
