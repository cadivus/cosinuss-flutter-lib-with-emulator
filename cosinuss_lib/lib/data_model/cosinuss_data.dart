import 'package:cosinuss_lib/data_model/accelerometer.dart';
import 'package:cosinuss_lib/data_model/body_temperature.dart';
import 'package:cosinuss_lib/data_model/heart_rate.dart';
import 'package:cosinuss_lib/data_model/ppg_raw.dart';

class CosinussData {
  final bool connected;
  final Accelerometer? accelerometer;
  final BodyTemperature? bodyTemperature;
  final HeartRate? heartRate;
  final PPGRaw? ppgRaw;

  const CosinussData({
    required this.connected,
    this.accelerometer,
    this.bodyTemperature,
    this.heartRate,
    this.ppgRaw,
  });

  @override
  String toString() =>
      "Connected: $connected\nAccelerometer: $accelerometer\nBody temperature: $bodyTemperature\nHeart rate: $heartRate\nPPG raw: $ppgRaw";

  @override
  bool operator ==(other) =>
      other is CosinussData &&
      connected == other.connected &&
      accelerometer == other.accelerometer &&
      bodyTemperature == other.bodyTemperature &&
      heartRate == other.heartRate &&
      ppgRaw == other.ppgRaw;

  @override
  int get hashCode => toString().hashCode;
}
