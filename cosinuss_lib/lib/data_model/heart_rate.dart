import 'package:json_annotation/json_annotation.dart';

part 'heart_rate.g.dart';

@JsonSerializable()
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

  factory HeartRate.fromJson(Map<String, dynamic> json) =>
      _$HeartRateFromJson(json);

  Map<String, dynamic> toJson() => _$HeartRateToJson(this);
}
