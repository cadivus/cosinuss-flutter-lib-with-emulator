import 'package:cosinuss_lib/data_model/body_temperature.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  group("BodyTemperature toString()", () {
    for (var testSet in [
      {"string": "12.0 °C", "data": BodyTemperature(value: 12)},
      {"string": "-12.0 °C", "data": BodyTemperature(value: -12)},
      {"string": "234.56 °C", "data": BodyTemperature(value: 234.56)},
      {"string": "234.57 °C", "data": BodyTemperature(value: 234.565)},
      {"string": "234.45 °C", "data": BodyTemperature(value: 234.451)},
    ]) {
      test("Test getting string \"${testSet["string"]}\"", () {
        expect(testSet["data"].toString(), testSet["string"]);
      });
    }
  });

  group("BodyTemperature ==", () {
    for (var testSet in [
      {"first": BodyTemperature(value: 1), "second": BodyTemperature(value: 1)},
      {
        "first": BodyTemperature(value: 100.12),
        "second": BodyTemperature(value: 100.12)
      },
      {
        "first": BodyTemperature(value: 13),
        "second": BodyTemperature(value: 13)
      },
      {
        "first": BodyTemperature(value: 345),
        "second": BodyTemperature(value: 345)
      },
      {
        "first": BodyTemperature(value: 756.12),
        "second": BodyTemperature(value: 756.12)
      },
    ]) {
      test(
          "Test BodyTemperature \"${testSet["first"]}\" == BodyTemperature \"${testSet["second"]}\"",
          () {
        expect(testSet["first"] == testSet["second"], true);
      });
    }
  });

  group("BodyTemperature !=", () {
    for (var testSet in [
      {
        "first": BodyTemperature(value: 1),
        "second": BodyTemperature(value: -1)
      },
      {
        "first": BodyTemperature(value: 100),
        "second": BodyTemperature(value: 345.00)
      },
      {
        "first": BodyTemperature(value: -13),
        "second": BodyTemperature(value: -13.01)
      },
      {
        "first": BodyTemperature(value: 43),
        "second": BodyTemperature(value: 345)
      },
      {
        "first": BodyTemperature(value: 43.43),
        "second": BodyTemperature(value: -756)
      },
    ]) {
      test(
          "Test BodyTemperature \"${testSet["first"]}\" == BodyTemperature \"${testSet["second"]}\"",
          () {
        expect(testSet["first"] == testSet["second"], false);
        expect(testSet["first"] != testSet["second"], true);
      });
    }
  });
}
