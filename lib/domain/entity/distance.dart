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
