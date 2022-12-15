class Accelerometer {
  final String unit = "<unknown unit>";
  final int x;
  final int y;
  final int z;

  const Accelerometer({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  String toString() => "$x | $y | $z";

  @override
  bool operator ==(other) =>
      other is Accelerometer &&
      x == other.x &&
      y == other.y &&
      z == other.z &&
      unit == other.unit;

  @override
  int get hashCode => toString().hashCode;
}
