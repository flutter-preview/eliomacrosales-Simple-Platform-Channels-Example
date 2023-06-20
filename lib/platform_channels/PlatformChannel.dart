import 'package:flutter/services.dart';

class PlatformChannel {
  final MethodChannel _methodChannel =
      const MethodChannel("implementation.channel");

  Future<String> getOSVersion() async {
    String result = '';
    try {
      result = await _methodChannel.invokeMethod("version");
      return result;
    } catch (e) {
      result = 'error: $e';
      return result;
    }
  }
}
