import "package:flutter/foundation.dart";

bool get isCosinussEmulatorMode =>
    const bool.fromEnvironment("COSINUSS_EMULATOR_MODE", defaultValue: false) &&
    kDebugMode;

String get cosinussEmulatorHost {
  const host = String.fromEnvironment("COSINUSS_EMULATOR_HOST",
      defaultValue: "localhost");
  String mappedHost = host;

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    if (mappedHost == "localhost" || mappedHost == "127.0.0.1") {
      // ignore: avoid_print
      print('Mapping Auth Emulator host "$mappedHost" to "10.0.2.2".');
      mappedHost = "10.0.2.2";
    }
  }

  return mappedHost;
}

int get cosinussEmulatorPort =>
    const int.fromEnvironment("COSINUSS_EMULATOR_HOST", defaultValue: 3000);
