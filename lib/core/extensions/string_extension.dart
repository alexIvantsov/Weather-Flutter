extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
