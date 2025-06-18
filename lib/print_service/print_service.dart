import 'dart:convert';

import '../model/api models/get_temple_model.dart';
import '../services/plutus_smart.dart';
import '../utils/logger.dart';

class PrintService {
  static Future<void> printReceipt({
    required String serialNumber,
    required List<Map<String, dynamic>> receipts,
    required List<GetTemplemodel> temples,
    required int index,
  }) async {
    final List<Map<String, dynamic>> formattedLines = _buildFormattedPrintLines(
      serialNumber: serialNumber,
      receipts: receipts,
      temples: temples,
      index: index,
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

    try {
      Logger.info('🖨️ Binding to Plutus service...');
      final bindResult = await PlutusSmart.bindToService();

      if (bindResult == "SUCCESS" || bindResult == "BINDING SUCCESS.") {
        Logger.success("Service bound successfully.");
        final result = await PlutusSmart.startPrintJob(printDataJson);
        Logger.success("🧾 Print result: $result");
      } else {
        Logger.error(" Binding failed: $bindResult");
      }
    } catch (e) {
      Logger.error(" Exception during printing: ${e.toString()}");
    }
  }

  static List<Map<String, dynamic>> _buildFormattedPrintLines({
    required String serialNumber,
    required List<Map<String, dynamic>> receipts,
    required List<GetTemplemodel> temples,
    required int index,
  }) {
    final now = DateTime.now();
    final formattedDate = "${now.day}-${now.month}-${now.year}";
    final formattedTime = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

    final List<Map<String, dynamic>> lines = [];
    final currentTemple = temples[index];

    // Temple Header Info
    final templeInfo = [
      currentTemple.templeName ?? 'Unknown Temple',
      currentTemple.address ?? 'No address',
      currentTemple.phoneNumber ?? 'No phone',
      "Father --------------------------",
    ];
    for (var line in templeInfo) {
      final map = _printLine(line, center: true);
      lines.add(map);
      print(line);
    }

    print("Date: $formattedDate  Time: $formattedTime");
    lines.add(_printLine("Date: $formattedDate  Time: $formattedTime", center: true));
    lines.add(_printLine("------------------------", center: true));

    int totalAmount = 0;

    for (var item in receipts) {
      final name = item['personName'] ?? 'Unknown';
      final star = item['personStar'] ?? 'Unknown';
      final offer = item['offerName'] ?? 'Unknown Vazhipadu';
      final qty = item['quantity'] ?? 1;
      final rate = item['rate'] ?? 0;
      final total = qty * rate;
      final repeatType = item['type']?.toString().toUpperCase() ?? '-';

      totalAmount += total as int;

      final repeatLine = "Repeat: $repeatType";
      final nameLine = "Name: $name, Star: $star";
      final offerLine = "$offer   ₹$rate x $qty";

      print(repeatLine);
      print(nameLine);
      print(offerLine);
      print("------------------------");

      lines.addAll([
        _printLine(repeatLine),
        _printLine(nameLine),
        _printLine(offerLine),
        _printLine("------------------------"),
      ]);
    }

    final totalLine = "Total Amount: ₹$totalAmount";
    print(totalLine);
    print("Thank you!");

    lines.add(_printLine(totalLine, center: true));
    lines.add(_printLine("Thank you!", center: true));

    return lines;
  }

  static Map<String, dynamic> _printLine(String data, {bool center = false}) {
    return {
      "PrintDataType": "0",
      "PrinterWidth": 24,
      "IsCenterAligned": center,
      "DataToPrint": data,
      "ImagePath": "0",
      "ImageData": "0",
    };
  }
}
