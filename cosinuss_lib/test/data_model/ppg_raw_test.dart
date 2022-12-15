import 'package:cosinuss_lib/data_model/ppg_raw.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  group("PPGRaw toString()", () {
    for (var testSet in [
      {
        "string": "1 | 2 | 3",
        "data": PPGRaw(ppgRed: 1, ppgGreen: 2, ppgAmbient: 3)
      },
      {
        "string": "100 | 2 | 30",
        "data": PPGRaw(ppgRed: 100, ppgGreen: 2, ppgAmbient: 30)
      },
      {
        "string": "13 | 675 | 435",
        "data": PPGRaw(ppgRed: 13, ppgGreen: 675, ppgAmbient: 435)
      },
      {
        "string": "345 | 243 | 333",
        "data": PPGRaw(ppgRed: 345, ppgGreen: 243, ppgAmbient: 333)
      },
      {
        "string": "756 | 324 | 96",
        "data": PPGRaw(ppgRed: 756, ppgGreen: 324, ppgAmbient: 96)
      },
    ]) {
      test("Test getting string \"${testSet["string"]}\"", () {
        expect(testSet["data"].toString(), testSet["string"]);
      });
    }
  });

  group("PPGRaw ==", () {
    for (var testSet in [
      {
        "first": PPGRaw(ppgRed: 1, ppgGreen: 2, ppgAmbient: 3),
        "second": PPGRaw(ppgRed: 1, ppgGreen: 2, ppgAmbient: 3)
      },
      {
        "first": PPGRaw(ppgRed: 100, ppgGreen: 2, ppgAmbient: 30),
        "second": PPGRaw(ppgRed: 100, ppgGreen: 2, ppgAmbient: 30)
      },
      {
        "first": PPGRaw(ppgRed: 13, ppgGreen: 675, ppgAmbient: 435),
        "second": PPGRaw(ppgRed: 13, ppgGreen: 675, ppgAmbient: 435)
      },
      {
        "first": PPGRaw(ppgRed: 345, ppgGreen: 243, ppgAmbient: 333),
        "second": PPGRaw(ppgRed: 345, ppgGreen: 243, ppgAmbient: 333)
      },
      {
        "first": PPGRaw(ppgRed: 756, ppgGreen: 324, ppgAmbient: 96),
        "second": PPGRaw(ppgRed: 756, ppgGreen: 324, ppgAmbient: 96)
      },
    ]) {
      test(
          "Test PPGRaw \"${testSet["first"]}\" == PPGRaw \"${testSet["second"]}\"",
          () {
        expect(testSet["first"] == testSet["second"], true);
      });
    }
  });

  group("PPGRaw !=", () {
    for (var testSet in [
      {
        "first": PPGRaw(ppgRed: 10, ppgGreen: 2, ppgAmbient: 3),
        "second": PPGRaw(ppgRed: 1, ppgGreen: 2, ppgAmbient: 3)
      },
      {
        "first": PPGRaw(ppgRed: 100, ppgGreen: 2, ppgAmbient: 30),
        "second": PPGRaw(ppgRed: 100, ppgGreen: 24, ppgAmbient: 30)
      },
      {
        "first": PPGRaw(ppgRed: 13, ppgGreen: 675, ppgAmbient: 435),
        "second": PPGRaw(ppgRed: 13, ppgGreen: 675, ppgAmbient: 467)
      },
      {
        "first": PPGRaw(ppgRed: 345, ppgGreen: 645, ppgAmbient: 333),
        "second": PPGRaw(ppgRed: 345, ppgGreen: 243, ppgAmbient: 333)
      },
      {
        "first": PPGRaw(ppgRed: 756, ppgGreen: 324, ppgAmbient: 96),
        "second": PPGRaw(ppgRed: 756, ppgGreen: 324, ppgAmbient: 97)
      },
    ]) {
      test(
          "Test PPGRaw \"${testSet["first"]}\" != PPGRaw \"${testSet["second"]}\"",
          () {
        expect(testSet["first"] == testSet["second"], false);
        expect(testSet["first"] != testSet["second"], true);
      });
    }
  });
}
