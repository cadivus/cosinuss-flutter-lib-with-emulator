class HeartRate {
  final int value;
  final String unit = "bpm";

  const HeartRate({required this.value});

  @override
  String toString() => "$value $unit";

  @override
  bool operator ==(other) =>
      other is HeartRate && value == other.value && unit == other.unit;

  @override
  int get hashCode => value;
}
