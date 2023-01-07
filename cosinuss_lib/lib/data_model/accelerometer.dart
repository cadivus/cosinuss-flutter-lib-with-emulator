import 'package:json_annotation/json_annotation.dart';

part 'accelerometer.g.dart';

@JsonSerializable()
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

  factory Accelerometer.fromJson(Map<String, dynamic> json) =>
      _$AccelerometerFromJson(json);

  Map<String, dynamic> toJson() => _$AccelerometerToJson(this);

  int getByAxis(Axis axis) {
    switch(axis) {
      case Axis.x:
        return x;
      case Axis.y:
        return y;
      default:
        return z;
    }
  }
}

enum Axis {
  x,
  y,
  z
}
