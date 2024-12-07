import 'package:flutter/material.dart';

/// Builds a GridView that is not scrollable and doesn't use [LayoutBuilder].
///
/// It can be used within a IntrinsicsHeight widget, [GridView] widget can't be.
class NotScrollableGridView extends StatelessWidget {
  final double width;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<Widget> children;
  final EdgeInsets? padding;

  const NotScrollableGridView({
    super.key,
    required this.width,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final itemWidth =
        (width - (crossAxisCount - 1) * crossAxisSpacing) / crossAxisCount;
    final itemHeight = itemWidth / childAspectRatio;

    return Container(
      padding: padding,
      width: width,
      child: Wrap(
        spacing: crossAxisSpacing,
        runSpacing: mainAxisSpacing,
        children: children.map((child) {
          return SizedBox(
            width: itemWidth,
            height: itemHeight,
            child: child,
          );
        }).toList(),
      ),
    );
  }
}
