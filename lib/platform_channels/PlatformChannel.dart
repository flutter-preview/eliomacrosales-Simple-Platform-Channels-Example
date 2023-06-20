
import 'package:flutter/services.dart';

class PlatformChannel {
  final MethodChannel _methodChannel = const MethodChannel("implementation.channel");

  Future<void> getOSVersion() async {
    try{
      final result =  await _methodChannel.invokeMethod("version");
      print('OS version is: $result');
    }
    catch (e){
      print('error: $e');
    }


  }

}