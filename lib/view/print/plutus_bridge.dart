import 'package:flutter/services.dart';

class PlutusBridge {
  static const MethodChannel _channel = MethodChannel('plutus_channel');

  static Future<String> startTransaction(String transactionData) async {
    try {
      final result = await _channel.invokeMethod('startTransaction', {
        'transactionData': transactionData,
      });
      return result;
    } catch (e) {
      return e.toString();
    }
  }
}
