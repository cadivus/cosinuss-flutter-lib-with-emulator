import 'package:flutter_test/flutter_test.dart';
import 'package:cosinuss_lib/data_model/accelerometer.dart';

void main() {
  group('Accelerometer toString()', () {
    for (var testSet in [
      {'string': '1 | 2 | 3', 'data': Accelerometer(x: 1, y: 2, z: 3)},
      {'string': '100 | -2 | 30', 'data': Accelerometer(x: 100, y: -2, z: 30)},
      {
        'string': '-13 | 675 | 435',
        'data': Accelerometer(x: -13, y: 675, z: 435)
      },
      {
        'string': '345 | -243 | 333',
        'data': Accelerometer(x: 345, y: -243, z: 333)
      },
      {
        'string': '756 | -324 | -96',
        'data': Accelerometer(x: 756, y: -324, z: -96)
      },
    ]) {
      test('Test getting string "${testSet['string']}"', () {
        expect(testSet['data'].toString(), testSet['string']);
      });
    }
  });

  group('Accelerometer ==', () {
    for (var testSet in [
      {
        'first': Accelerometer(x: 1, y: 2, z: 3),
        'second': Accelerometer(x: 1, y: 2, z: 3)
      },
      {
        'first': Accelerometer(x: 100, y: -2, z: 30),
        'second': Accelerometer(x: 100, y: -2, z: 30)
      },
      {
        'first': Accelerometer(x: -13, y: 675, z: 435),
        'second': Accelerometer(x: -13, y: 675, z: 435)
      },
      {
        'first': Accelerometer(x: 345, y: -243, z: 333),
        'second': Accelerometer(x: 345, y: -243, z: 333)
      },
      {
        'first': Accelerometer(x: 756, y: -324, z: -96),
        'second': Accelerometer(x: 756, y: -324, z: -96)
      },
    ]) {
      test(
          'Test Accelerometer "${testSet['first']}" == Accelerometer "${testSet['second']}"',
          () {
        expect(testSet['first'] == testSet['second'], true);
      });
    }
  });

  group('Accelerometer !=', () {
    for (var testSet in [
      {
        'first': Accelerometer(x: 10, y: 2, z: 3),
        'second': Accelerometer(x: 1, y: 2, z: 3)
      },
      {
        'first': Accelerometer(x: 100, y: -2, z: 30),
        'second': Accelerometer(x: 100, y: -24, z: 30)
      },
      {
        'first': Accelerometer(x: -13, y: 675, z: 435),
        'second': Accelerometer(x: -13, y: 675, z: 467)
      },
      {
        'first': Accelerometer(x: 345, y: -645, z: 333),
        'second': Accelerometer(x: 345, y: -243, z: -333)
      },
      {
        'first': Accelerometer(x: -756, y: 324, z: 96),
        'second': Accelerometer(x: 756, y: -324, z: -96)
      },
    ]) {
      test(
          'Test Accelerometer "${testSet['first']}" != Accelerometer "${testSet['second']}"',
          () {
        expect(testSet['first'] == testSet['second'], false);
        expect(testSet['first'] != testSet['second'], true);
      });
    }
  });

  test('From JSON', () {
    Map<String, dynamic> json = {'x': -13, 'y': 675, 'z': 435};
    Accelerometer parsedAccelerometer = Accelerometer.fromJson(json);

    expect(-13, parsedAccelerometer.x);
    expect(675, parsedAccelerometer.y);
    expect(435, parsedAccelerometer.z);
  });

  test('To JSON', () {
    Accelerometer accelerometer = Accelerometer(x: -13, y: 675, z: 435);
    Map<String, dynamic> json = accelerometer.toJson();

    expect(-13, json['x']);
    expect(675, json['y']);
    expect(435, json['z']);
  });
}
