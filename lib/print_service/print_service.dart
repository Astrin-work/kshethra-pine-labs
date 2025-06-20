import 'dart:convert';

import '../model/api models/get_temple_model.dart';
import '../services/plutus_smart.dart';
import '../utils/logger.dart';

class PrintService {
  /// Public method to print a formatted receipt
  static Future<void> printReceipt({
    required String serialNumber,
    required List<Map<String, dynamic>> receipts,
    required List<GetTemplemodel> temples,
    required int index,
  }) async {
    try {
      final currentTemple = temples[index];
      final receiptDate = _formattedDate();
      final vazhipaduDate = receipts.first['date'] ?? receiptDate;

      final vazhipaduItems =
          receipts
              .map(
                (item) => {
                  'vazhipadu': item['name'] ?? '',
                  'name': item['personName'] ?? '',
                  'amount': item['amount'] ?? 0,
                  'qty': item['count'] ?? 1,
                },
              )
              .toList();

      final List<Map<String, dynamic>> formattedLines =
          buildTempleReceiptPrintData(
            currentTemple: currentTemple,
            vazhipaduItems: vazhipaduItems,
            receiptNo: serialNumber,
            receiptDate: receiptDate,
            vazhipaduDate: vazhipaduDate,
          );

      Map<String, dynamic> printData = {
        "Header": {
          "ApplicationId": "f0d097be4df3441196d1e37cb2c98875",
          "UserId": "user1234",
          "MethodId": "1002",
          "VersionNo": "1.0",
        },
        "Detail": {
          "PrintRefNo": serialNumber,
          "SavePrintData": false,
          "Data": formattedLines,
        },
      };

      final printDataJson = jsonEncode(printData);

      Logger.info('🖨️ Binding to Plutus service...');
      final bindResult = await PlutusSmart.bindToService();

      if (bindResult == "SUCCESS" || bindResult == "BINDING SUCCESS.") {
        Logger.success("Service bound successfully.");
        final result = await PlutusSmart.startPrintJob(printDataJson);
        Logger.success("🧾 Print result: $result");
      } else {
        Logger.error("Binding failed: $bindResult");
      }
    } catch (e, stack) {
      Logger.error("Exception during printing: ${e.toString()}");
    }
  }

  static List<Map<String, dynamic>> buildTempleReceiptPrintData({
    required GetTemplemodel currentTemple,
    required List<Map<String, dynamic>> vazhipaduItems,
    required String receiptNo,
    required String receiptDate,
    required String vazhipaduDate,
  }) {
    String formatRow(
      int sl,
      String vazhipadu,
      String name,
      int amount,
      int qty,
    ) {
      return '${sl.toString().padRight(3)}'
          '${vazhipadu.padRight(15)}'
          '${name.padRight(8)}'
          '${amount.toString().padRight(6)}'
          '$qty';
    }

    final List<Map<String, dynamic>> lines = [
      _printLine(currentTemple.templeName),
      _printLine(currentTemple.address),
    ];

    return lines;
  }

  /// Formats a line for printing
  static Map<String, dynamic> _printLine(
    String data, ) {
    return {
      "PrintDataType": "0",
      "PrinterWidth": 24,
      "IsCenterAligned": true,
      "DataToPrint": data,
      "ImagePath": "0",
      "ImageData": "0"

    };
  }

  static String _formattedDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}';
  }
}
