// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cosinuss_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CosinussData _$CosinussDataFromJson(Map<String, dynamic> json) => CosinussData(
      connected: json['connected'] as bool,
      accelerometer: json['accelerometer'] == null
          ? null
          : Accelerometer.fromJson(
              json['accelerometer'] as Map<String, dynamic>),
      bodyTemperature: json['bodyTemperature'] == null
          ? null
          : BodyTemperature.fromJson(
              json['bodyTemperature'] as Map<String, dynamic>),
      heartRate: json['heartRate'] == null
          ? null
          : HeartRate.fromJson(json['heartRate'] as Map<String, dynamic>),
      ppgRaw: json['ppgRaw'] == null
          ? null
          : PPGRaw.fromJson(json['ppgRaw'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CosinussDataToJson(CosinussData instance) =>
    <String, dynamic>{
      'connected': instance.connected,
      'accelerometer': instance.accelerometer?.toJson(),
      'bodyTemperature': instance.bodyTemperature?.toJson(),
      'heartRate': instance.heartRate?.toJson(),
      'ppgRaw': instance.ppgRaw?.toJson(),
    };
