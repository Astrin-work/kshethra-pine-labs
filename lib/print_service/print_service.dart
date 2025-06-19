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
      final vazhipaduDate = receipts.first['date'] ?? receiptDate; // fallback

      final vazhipaduItems = receipts.map((item) => {
        'vazhipadu': item['name'] ?? '',
        'name': item['personName'] ?? '',
        'amount': item['amount'] ?? 0,
        'qty': item['count'] ?? 1,
      }).toList();

      final List<Map<String, dynamic>> formattedLines =
      buildTempleReceiptPrintData(
        currentTemple: currentTemple,
        vazhipaduItems: vazhipaduItems,
        receiptNo: serialNumber,
        receiptDate: receiptDate,
        vazhipaduDate: vazhipaduDate,
      );

      final printDataJson = jsonEncode({
        "Header": {
          "ApplicationId": "f0d097be4df3441196d1e37cb2c98875",
          "UserId": "123456",
          "MethodId": "1002",
          "VersionNo": "1.0",
        },
        "Detail": {
          "PrintRefNo": serialNumber,
          "SavePrintData": false,
          "Data": formattedLines,
        }
      });

      Logger.info('🖨️ Binding to Plutus service...');
      final bindResult = await PlutusSmart.bindToService();

      if (bindResult == "SUCCESS" || bindResult == "BINDING SUCCESS.") {
        Logger.success("Service bound successfully.");
        final result = await PlutusSmart.startPrintJob(printDataJson);
        Logger.success("🧾 Print result: $result");
      } else {
        Logger.error("❌ Binding failed: $bindResult");
      }
    } catch (e, stack) {
      Logger.error("❗ Exception during printing: ${e.toString()}");

    }
  }

  /// Builds receipt data layout
  static List<Map<String, dynamic>> buildTempleReceiptPrintData({
    required GetTemplemodel currentTemple,
    required List<Map<String, dynamic>> vazhipaduItems,
    required String receiptNo,
    required String receiptDate,
    required String vazhipaduDate,
  }) {
    String formatRow(int sl, String vazhipadu, String name, int amount, int qty) {
      return '${sl.toString().padRight(3)}'
          '${vazhipadu.padRight(15)}'
          '${name.padRight(8)}'
          '${amount.toString().padRight(6)}'
          '$qty';
    }

    return [
      _printLine(currentTemple.templeName ?? 'no', center: true, bold: true, fontSize: 2),
      _printLine(currentTemple.address ?? 'no', center: true),
      _printLine("📞 ${currentTemple.phoneNumber ?? 'no'}", center: true),
      _printLine("------------------------------", center: true),
      _printLine("റസീത് നമ്പർ: $receiptNo"),
      _printLine("തീയതി: $receiptDate"),
      _printLine("വഴിപാട് രസീത്", center: true, bold: true, fontSize: 2),
      _printLine("------------------------------"),
      _printLine("Sl  വഴിപാട്              പേര്     തുക Qty", bold: true),

      ...vazhipaduItems.asMap().entries.map((entry) {
        final i = entry.key + 1;
        final item = entry.value;
        return _printLine(
          formatRow(i, item['vazhipadu'], item['name'], item['amount'], item['qty']),
        );
      }),

      _printLine("------------------------------"),
      _printLine("വഴിപാട് തീയതി: $vazhipaduDate"),
      _printLine("ആശംസകൾ", center: true),
      _printLine("Software by Astrins - 8137043838", center: true, fontSize: 1),
    ];
  }

  /// Formats a line for printing
  static Map<String, dynamic> _printLine(
      String data, {
        bool center = false,
        int fontSize = 2,
        bool bold = false,
        bool underline = false,
      }) {
    return {
      "PrintDataType": "0",
      "PrinterWidth": 24,
      "IsCenterAligned": center,
      "FontSize": fontSize,
      "IsBold": bold,
      "IsUnderlined": underline,
      "DataToPrint": data,
      "ImagePath": "0",
      "ImageData": "0",
    };
  }

  /// Returns today's date as dd/MM/yyyy
  static String _formattedDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}';
  }
}
