import 'package:cosinuss_lib/data_model/accelerometer.dart';
import 'package:cosinuss_lib/data_model/body_temperature.dart';
import 'package:cosinuss_lib/data_model/cosinuss_data.dart';
import 'package:cosinuss_lib/data_model/heart_rate.dart';
import 'package:cosinuss_lib/data_model/ppg_raw.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  group("CosinussData toString()", () {
    Accelerometer accelerometer = Accelerometer(x: 100, y: -2, z: 30);
    BodyTemperature bodyTemperature = BodyTemperature(value: 234.56);
    HeartRate heartRate = HeartRate(value: 120);
    PPGRaw ppgRaw = PPGRaw(ppgRed: 345, ppgGreen: 243, ppgAmbient: 333);

    for (var testSet in [
      {
        "string":
            "Connected: true\nAccelerometer: 100 | -2 | 30\nBody temperature: 234.56 °C\nHeart rate: 120 bpm\nPPG raw: 345 | 243 | 333",
        "data": CosinussData(
            connected: true,
            accelerometer: accelerometer,
            bodyTemperature: bodyTemperature,
            heartRate: heartRate,
            ppgRaw: ppgRaw)
      },
      {
        "string":
            "Connected: true\nAccelerometer: null\nBody temperature: 234.56 °C\nHeart rate: 120 bpm\nPPG raw: 345 | 243 | 333",
        "data": CosinussData(
            connected: true,
            accelerometer: null,
            bodyTemperature: bodyTemperature,
            heartRate: heartRate,
            ppgRaw: ppgRaw)
      },
      {
        "string":
            "Connected: false\nAccelerometer: 100 | -2 | 30\nBody temperature: null\nHeart rate: 120 bpm\nPPG raw: 345 | 243 | 333",
        "data": CosinussData(
            connected: false,
            accelerometer: accelerometer,
            bodyTemperature: null,
            heartRate: heartRate,
            ppgRaw: ppgRaw)
      },
      {
        "string":
            "Connected: true\nAccelerometer: 100 | -2 | 30\nBody temperature: 234.56 °C\nHeart rate: null\nPPG raw: 345 | 243 | 333",
        "data": CosinussData(
            connected: true,
            accelerometer: accelerometer,
            bodyTemperature: bodyTemperature,
            heartRate: null,
            ppgRaw: ppgRaw)
      },
      {
        "string":
            "Connected: true\nAccelerometer: 100 | -2 | 30\nBody temperature: 234.56 °C\nHeart rate: 120 bpm\nPPG raw: null",
        "data": CosinussData(
            connected: true,
            accelerometer: accelerometer,
            bodyTemperature: bodyTemperature,
            heartRate: heartRate,
            ppgRaw: null)
      },
    ]) {
      test("Test getting string \"${testSet["string"]}\"", () {
        expect(testSet["data"].toString(), testSet["string"]);
      });
    }
  });

  test("CosinussData ==", () {
    Accelerometer accelerometer1 = Accelerometer(x: 100, y: -2, z: 30);
    Accelerometer accelerometer2 = Accelerometer(x: 100, y: -2, z: 30);
    BodyTemperature bodyTemperature1 = BodyTemperature(value: 234.56);
    BodyTemperature bodyTemperature2 = BodyTemperature(value: 234.56);
    HeartRate heartRate1 = HeartRate(value: 120);
    HeartRate heartRate2 = HeartRate(value: 120);
    PPGRaw ppgRaw1 = PPGRaw(ppgRed: 345, ppgGreen: 243, ppgAmbient: 333);
    PPGRaw ppgRaw2 = PPGRaw(ppgRed: 345, ppgGreen: 243, ppgAmbient: 333);

    CosinussData cosinussData1 = CosinussData(
        connected: true,
        accelerometer: accelerometer1,
        bodyTemperature: bodyTemperature1,
        heartRate: heartRate1,
        ppgRaw: ppgRaw1);

    CosinussData cosinussData2 = CosinussData(
        connected: true,
        accelerometer: accelerometer2,
        bodyTemperature: bodyTemperature2,
        heartRate: heartRate2,
        ppgRaw: ppgRaw2);

    expect(cosinussData1 == cosinussData2, true);
  });

  test("CosinussData !=", () {
    Accelerometer accelerometer1 = Accelerometer(x: 100, y: -2, z: 30);
    Accelerometer accelerometer2 = Accelerometer(x: 100, y: -2, z: 30);
    BodyTemperature bodyTemperature1 = BodyTemperature(value: 234.56);
    BodyTemperature bodyTemperature2 = BodyTemperature(value: 234.56);
    HeartRate heartRate1 = HeartRate(value: 120);
    HeartRate heartRate2 = HeartRate(value: 120);
    PPGRaw ppgRaw1 = PPGRaw(ppgRed: 345, ppgGreen: 243, ppgAmbient: 333);
    PPGRaw ppgRaw2 = PPGRaw(ppgRed: 345, ppgGreen: 243, ppgAmbient: 33);

    CosinussData cosinussData1 = CosinussData(
        connected: true,
        accelerometer: accelerometer1,
        bodyTemperature: bodyTemperature1,
        heartRate: heartRate1,
        ppgRaw: ppgRaw1);

    CosinussData cosinussData2 = CosinussData(
        connected: true,
        accelerometer: accelerometer2,
        bodyTemperature: bodyTemperature2,
        heartRate: heartRate2,
        ppgRaw: ppgRaw2);

    expect(cosinussData1 == cosinussData2, false);
    expect(cosinussData1 != cosinussData2, true);
  });
}
