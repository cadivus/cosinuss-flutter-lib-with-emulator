import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:cosinuss_lib/data_model/accelerometer.dart';
import 'package:cosinuss_lib/data_model/body_temperature.dart';
import 'package:cosinuss_lib/data_model/cosinuss_data.dart';
import 'package:cosinuss_lib/data_model/heart_rate.dart';
import 'package:cosinuss_lib/data_model/ppg_raw.dart';
import 'package:cosinuss_lib/debug.dart';

class CosinussSensor {
  BluetoothDevice? _earConnect;
  bool _isConnected = false;

  Accelerometer? _accelerometer;
  BodyTemperature? _bodyTemperature;
  HeartRate? _heartRate;
  PPGRaw? _ppgRaw;

  WebSocketChannel? _sendEmulatorLogChannel;

  static final CosinussSensor _singleton = CosinussSensor._internal();

  factory CosinussSensor() {
    return _singleton;
  }

  CosinussSensor._internal();

  static CosinussSensor get instance {
    return _singleton;
  }

  final StreamController<CosinussData> _streamController =
      StreamController.broadcast();

  Stream<CosinussData> get stream {
    return _streamController.stream;
  }

  bool get isConnected {
    return _isConnected;
  }

  HeartRate _getHeartRate(rawData) {
    Uint8List bytes = Uint8List.fromList(rawData);

    // based on GATT standard
    var bpm = bytes[1];
    if (!((bytes[0] & 0x01) == 0)) {
      bpm = (((bpm >> 8) & 0xFF) | ((bpm << 8) & 0xFF00));
    }

    return HeartRate(value: bpm);
  }

  BodyTemperature _getBodyTemperature(rawData) {
    var flag = rawData[0];

    // based on GATT standard
    double temperature = _twosComplimentOfNegativeMantissa(
            ((rawData[3] << 16) | (rawData[2] << 8) | rawData[1]) & 16777215) /
        100.0;
    if ((flag & 1) != 0) {
      temperature = ((98.6 * temperature) - 32.0) *
          (5.0 / 9.0); // convert Fahrenheit to Celsius
    }

    return BodyTemperature(value: temperature);
  }

  PPGRaw _getPPGRaw(rawData) {
    Uint8List bytes = Uint8List.fromList(rawData);

    // corresponds to the raw reading of the PPG sensor from which the heart rate is computed
    //
    // example plot https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/73/Screen-Shot-2019_2D00_01_2D00_24-at-19.30.24.png
    // (image just for illustration purpose, obtained from a different sensor! Sensor value range differs.)

    var ppgRed = bytes[0] |
        bytes[1] << 8 |
        bytes[2] << 16 |
        bytes[3] << 32; // raw green color value of PPG sensor
    var ppgGreen = bytes[4] |
        bytes[5] << 8 |
        bytes[6] << 16 |
        bytes[7] << 32; // raw red color value of PPG sensor

    var ppgGreenAmbient = bytes[8] |
        bytes[9] << 8 |
        bytes[10] << 16 |
        bytes[11] <<
            32; // ambient light sensor (e.g., if sensor is not placed correctly)

    return PPGRaw(
        ppgRed: ppgRed, ppgGreen: ppgGreen, ppgAmbient: ppgGreenAmbient);
  }

  Accelerometer _getAccelerometer(rawData) {
    Int8List bytes = Int8List.fromList(rawData);

    // description based on placing the earable into your right ear canal
    int accX = bytes[14];
    int accY = bytes[16];
    int accZ = bytes[18];

    return Accelerometer(x: accX, y: accY, z: accZ);
  }

  int _twosComplimentOfNegativeMantissa(int mantissa) {
    if ((4194304 & mantissa) != 0) {
      return (((mantissa ^ -1) & 16777215) + 1) * -1;
    }

    return mantissa;
  }

  void sendCosinussData() {
    CosinussData newCosinussData = CosinussData(
      connected: _isConnected,
      accelerometer: _accelerometer,
      bodyTemperature: _bodyTemperature,
      heartRate: _heartRate,
      ppgRaw: _ppgRaw,
    );
    _streamController.sink.add(newCosinussData);
    if (!isCosinussEmulatorLogMode) {
      return;
    }

    if (_sendEmulatorLogChannel == null) {
      String host = cosinussEmulatorHost;
      int port = cosinussEmulatorPort;
      _sendEmulatorLogChannel = WebSocketChannel.connect(
          Uri(scheme: "ws", host: host, port: port, path: "/websocket/"));

      _sendEmulatorLogChannel?.stream.listen(null, onDone: () {
        _sendEmulatorLogChannel = null;
      });
    }
    Map<String, dynamic> jsonLog = newCosinussData.toJson();
    jsonLog["timestamp"] = DateTime.now().millisecondsSinceEpoch;
    _sendEmulatorLogChannel!.sink.add(jsonEncode(jsonLog));
  }

  void connect() {
    if (isCosinussEmulatorMode) {
      emulatorConnect();
      return;
    }

    _bluetoothConnect();
  }

  void emulatorConnect() {
    if (_isConnected) {
      return;
    }

    String host = cosinussEmulatorHost;
    int port = cosinussEmulatorPort;

    final channel = WebSocketChannel.connect(
        Uri(scheme: "ws", host: host, port: port, path: "/websocket/"));

    _isConnected = true;

    channel.stream.listen((data) {
      try {
        Map<String, dynamic> jsonDecoded = jsonDecode(data.toString());
        jsonDecoded["connected"] ??= true;
        CosinussData update = CosinussData.fromJson(jsonDecoded);
        _accelerometer = update.accelerometer;
        _bodyTemperature = update.bodyTemperature;
        _heartRate = update.heartRate;
        _ppgRaw = update.ppgRaw;
        sendCosinussData();
      } catch (e) {
        if (kDebugMode) {
          print("Invalid JSON: $e");
        }
      }
    }, onDone: () {
      _isConnected = false;
      sendCosinussData();
      if (kDebugMode) {
        print("End connection to Cosinuss emulator");
      }
    });
  }

  void _disconnectBluetooth() {
    FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;
    flutterBluePlus.stopScan();
    _isConnected = false;
    _earConnect?.disconnect();
    _earConnect = null;
    sendCosinussData();
  }

  void _bluetoothConnect() async {
    FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;

    flutterBluePlus.state.listen((event) {
      if (![BluetoothState.off, BluetoothState.unavailable].contains(event)) {
        return;
      }
      _disconnectBluetooth();
    });

    // disconnect if already connected
    _disconnectBluetooth();

    // start scanning
    flutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    // listen to scan results
    flutterBluePlus.scanResults.listen((results) async {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name != "earconnect" || _earConnect != null) {
          continue;
        }

        // avoid multiple connects attempts to same device
        _earConnect = r.device;

        await flutterBluePlus.stopScan();

        r.device.state.listen((state) {
          // listen for connection state changes
          _isConnected = state == BluetoothDeviceState.connected;
          sendCosinussData();
        });

        _earConnect = r.device;
        await r.device.connect();

        List<BluetoothService> services = await r.device.discoverServices();

        for (var service in services) {
          // iterate over services
          for (var characteristic in service.characteristics) {
            // iterate over characterstics
            switch (characteristic.uuid.toString()) {
              case "0000a001-1212-efde-1523-785feabcd123":
                await characteristic.write([
                  0x32,
                  0x31,
                  0x39,
                  0x32,
                  0x37,
                  0x34,
                  0x31,
                  0x30,
                  0x35,
                  0x39,
                  0x35,
                  0x35,
                  0x30,
                  0x32,
                  0x34,
                  0x35
                ]);
                await Future.delayed(const Duration(
                    seconds:
                        2)); // short delay before next bluetooth operation otherwise BLE crashes
                characteristic.value.listen((rawData) {
                  _accelerometer = _getAccelerometer(rawData);
                  _ppgRaw = _getPPGRaw(rawData);
                  _isConnected = true;
                  sendCosinussData();
                });
                await characteristic.setNotifyValue(true);
                await Future.delayed(const Duration(seconds: 2));
                break;

              case "00002a37-0000-1000-8000-00805f9b34fb":
                characteristic.value.listen((rawData) {
                  _heartRate = _getHeartRate(rawData);
                  _isConnected = true;
                  sendCosinussData();
                });
                await characteristic.setNotifyValue(true);
                await Future.delayed(const Duration(
                    seconds:
                        2)); // short delay before next bluetooth operation otherwise BLE crashes
                break;

              case "00002a1c-0000-1000-8000-00805f9b34fb":
                characteristic.value.listen((rawData) {
                  _bodyTemperature = _getBodyTemperature(rawData);
                  _isConnected = true;
                  sendCosinussData();
                });
                await characteristic.setNotifyValue(true);
                await Future.delayed(const Duration(
                    seconds:
                        2)); // short delay before next bluetooth operation otherwise BLE crashes
                break;
            }
          }
        }
      }
    });
  }
}
