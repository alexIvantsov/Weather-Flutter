/// Represents distance using [value] and [unit].
///
/// Example:
/// 1 kilometer
/// 100 meters
class Distance {
  final num value;
  final DistanceUnit unit;

  Distance({
    required this.value,
    required this.unit,
  });

  @override
  String toString() {
    return '$value $unit';
  }
}

enum DistanceUnit {
  kilometer,
  meter,
}
