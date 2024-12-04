import 'package:flutter/material.dart';
import 'package:weather/core/extensions/context_extension.dart';

class SearchField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final bool isEditable;

  const SearchField({
    super.key,
    this.controller,
    this.initialValue,
    this.isEditable = true,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    controller.text = widget.initialValue ?? '';
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchField oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      controller.text = widget.initialValue ?? '';
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextField(
        enabled: widget.isEditable,
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
      ),
    );
  }
}
