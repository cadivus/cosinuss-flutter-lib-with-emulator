import 'dart:math';
import 'package:json_annotation/json_annotation.dart';

part 'body_temperature.g.dart';

@JsonSerializable()
class BodyTemperature {
  final double value;
  final String unit = "°C";

  const BodyTemperature({required this.value});

  double _roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  String toString() => "${_roundDouble(value, 2)} $unit";

  @override
  bool operator ==(other) =>
      other is BodyTemperature && value == other.value && unit == other.unit;

  @override
  int get hashCode => value.hashCode;

  factory BodyTemperature.fromJson(Map<String, dynamic> json) =>
      _$BodyTemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$BodyTemperatureToJson(this);
}
