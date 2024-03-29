import 'package:json_annotation/json_annotation.dart';

part 'ppg_raw.g.dart';

@JsonSerializable()
class PPGRaw {
  final String unit = "<unknown unit>";
  final int ppgRed;
  final int ppgGreen;
  final int ppgAmbient;

  const PPGRaw({
    required this.ppgRed,
    required this.ppgGreen,
    required this.ppgAmbient,
  });

  @override
  String toString() => "$ppgRed | $ppgGreen | $ppgAmbient";

  @override
  bool operator ==(other) =>
      other is PPGRaw &&
      ppgRed == other.ppgRed &&
      ppgGreen == other.ppgGreen &&
      ppgAmbient == other.ppgAmbient &&
      unit == other.unit;

  @override
  int get hashCode => toString().hashCode;

  factory PPGRaw.fromJson(Map<String, dynamic> json) =>
      _$PPGRawFromJson(json);

  Map<String, dynamic> toJson() => _$PPGRawToJson(this);
}
