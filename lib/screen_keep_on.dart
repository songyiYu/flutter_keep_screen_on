import 'dart:async';

import 'package:flutter/services.dart';

class ScreenKeepOn {
  static const MethodChannel _channel =
      const MethodChannel('cindyu.com/screen_keep_on');

  static Future<bool> get isOn async {
    return await _channel.invokeMethod('isOn') as bool;
  }

  static turnOn(bool turnOn) {
    _channel.invokeMethod('turnOn', {"turnOn": turnOn});
  }

  static Future<double> get brightness async {
    return await _channel.invokeMethod('getBrightness') as double;
  }

  static setBrightness(double brightness) {
    _channel.invokeMethod('setBrightness', {"brightness": brightness});
  }
}
