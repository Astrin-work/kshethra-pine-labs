import 'package:flutter/services.dart';

import '../utils/logger.dart';

class PlutusSmart {
  static const MethodChannel _channel = MethodChannel('plutus_channel');

  static Future<String> bindToService() async {
    try {
      final result = await _channel.invokeMethod('bindToService');
      Logger.info('bindToService result: $result');
      return result;
    } catch (e) {
      Logger.error('bindToService error: $e');
      return e.toString();
    }
  }

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

  static Future<String> startPrintJob(String printData) async {
    try {
      final result = await _channel.invokeMethod('startPrintJob', {
        'printData': printData,
      });
      return result;
    } catch (e) {
      return e.toString();
    }
  }
}