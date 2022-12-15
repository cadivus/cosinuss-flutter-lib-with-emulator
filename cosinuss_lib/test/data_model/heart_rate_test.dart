import 'package:cosinuss_lib/data_model/heart_rate.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  group("HeartRate toString()", () {
    for (var testSet in [
      {"string": "12 bpm", "data": HeartRate(value: 12)},
      {"string": "23 bpm", "data": HeartRate(value: 23)},
      {"string": "54 bpm", "data": HeartRate(value: 54)},
      {"string": "45 bpm", "data": HeartRate(value: 45)},
      {"string": "120 bpm", "data": HeartRate(value: 120)},
    ]) {
      test("Test getting string \"${testSet["string"]}\"", () {
        expect(testSet["data"].toString(), testSet["string"]);
      });
    }
  });

  group("HeartRate ==", () {
    for (var testSet in [
      {"first": HeartRate(value: 1), "second": HeartRate(value: 1)},
      {"first": HeartRate(value: 100), "second": HeartRate(value: 100)},
      {"first": HeartRate(value: -13), "second": HeartRate(value: -13)},
      {"first": HeartRate(value: 345), "second": HeartRate(value: 345)},
      {"first": HeartRate(value: 756), "second": HeartRate(value: 756)},
    ]) {
      test(
          "Test HeartRate \"${testSet["first"]}\" == HeartRate \"${testSet["second"]}\"",
          () {
        expect(testSet["first"] == testSet["second"], true);
      });
    }
  });

  group("HeartRate !=", () {
    for (var testSet in [
      {"first": HeartRate(value: 1), "second": HeartRate(value: -1)},
      {"first": HeartRate(value: 100), "second": HeartRate(value: 345)},
      {"first": HeartRate(value: -13), "second": HeartRate(value: -133)},
      {"first": HeartRate(value: 43), "second": HeartRate(value: 345)},
      {"first": HeartRate(value: 43), "second": HeartRate(value: -756)},
    ]) {
      test(
          "Test HeartRate \"${testSet["first"]}\" == HeartRate \"${testSet["second"]}\"",
          () {
        expect(testSet["first"] == testSet["second"], false);
        expect(testSet["first"] != testSet["second"], true);
      });
    }
  });
}
