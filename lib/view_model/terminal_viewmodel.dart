import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/logger.dart';
import '../model/api models/get_temple_model.dart';
import '../services/plutus_smart.dart';

class TerminalViewmodel with ChangeNotifier {
  String _selectedTransaction = 'SALE';
  bool _isChecked = false;
  List<String> statusMessages = [];
  bool printerEnabled = false;

  Map<String, dynamic> printData = {};
  Map<String, dynamic> payload = {
    "Detail": {
      "BillingRefNo": "TX98765432",
      "PaymentAmount": 100,
      "TransactionType": 4001,
    },
    "Header": {
      "ApplicationId": "f0d097be4df3441196d1e37cb2c98875",
      "MethodId": "1001",
      "UserId": "user1234",
      "VersionNo": "1.0",
    }
  };

  TextEditingController jsonController = TextEditingController(
      text: const JsonEncoder.withIndent('').convert({
        "Header": {
          "ApplicationId": "f0d097be4df3441196d1e37cb2c98875",
          "UserId": "user1234",
          "MethodId": "1002",
          "VersionNo": "1.0",
        },
        "Detail": {
          "PrintRefNo": "123456789",
          "SavePrintData": false,
          "Data": [
            {
              "PrintDataType": "0",
              "PrinterWidth": 24,
              "IsCenterAligned": true,
              "DataToPrint": "String Data",
              "ImagePath": "0",
              "ImageData": "0"
            },
            // Add other print data items here
          ],
        },
      }));
  final TextEditingController amountController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();

  String _bindingStatus = "Not Bound";
  bool _isBound = false;
  bool _isBindingInitiated = false;
  ScrollController scrollController = ScrollController();
  int _paymentAmount = 100;

  String get bindingStatus => _bindingStatus;
  bool get isBound => _isBound;
  bool get isBindingInitiated => _isBindingInitiated;
  int get paymentAmount => _paymentAmount;

  @override
  void dispose() {
    amountController.dispose();
    amountFocusNode.dispose();
    super.dispose();
  }

  void setBindingStatus(String status) {
    _bindingStatus = status;
    notifyListeners();
  }

  void setIsBound(bool bound) {
    _isBound = bound;
    notifyListeners();
  }

  void setBindingInitiated(bool value) {
    _isBindingInitiated = value;
    notifyListeners();
  }

  void setPaymentAmount(int amount){
    _paymentAmount = amount;
    notifyListeners();
  }

  String get selectedTransaction => _selectedTransaction;
  bool get isChecked => _isChecked;

  void setSelectedTransaction(String value) {
    _selectedTransaction = value;
    printerEnabled = value == 'PRINT';
    Logger.info('Selected Transaction: $value, Printer Enabled: $printerEnabled');
    notifyListeners();
  }

  void setIsChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  void addStatusMessage(String message) {
    String currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    statusMessages.add('$currentTime :  $message');
    notifyListeners();
    Timer(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void updatePrintData(String value) {
    try {
      var parsedData = jsonDecode(value);
      printData = convertToMapOfMaps(parsedData);
    } catch (e) {
      Logger.error('Error parsing JSON: $e');
    }
    notifyListeners();
  }

  Map<String, dynamic> convertToMapOfMaps(Map<String, dynamic> data) {
    Map<String, dynamic> result = {};
    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        result[key] = value;
      }
    });
    return result;
  }

  /// Set print data for temple receipt (from PrintService logic), using only supported fields
  void setPrintDataFromTempleReceipt({
    required String serialNumber,
    required List<Map<String, dynamic>> receipts,
    required List<GetTemplemodel> temples,
    required int index,
  }) {
    final currentTemple = temples[index];
    final receiptDate = _formattedDate();
    final timeNow = _formattedTime();

    final formattedLines = _buildTempleReceiptPrintData(
      currentTemple: currentTemple,
      receipts: receipts,
      receiptNo: serialNumber,
      receiptDate: receiptDate,
      receiptTime: timeNow,
    );

    printData = {
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

    notifyListeners();
  }

  /// Print the current printData using PlutusSmart
  Future<void> printTempleReceipt() async {
    try {
      final printDataJson = jsonEncode(printData);

      Logger.info('🖨️ Binding to Plutus service...');
      final bindResult = await PlutusSmart.bindToService();

      if (bindResult == "SUCCESS" || bindResult == "BINDING SUCCESS.") {
        Logger.success("Service bound successfully.");
        final result = await PlutusSmart.startPrintJob(printDataJson);
        Logger.success("🧾 Print result: $result");
        addStatusMessage("Print Success: $result");
      } else {
        Logger.error("Binding failed: $bindResult");
        addStatusMessage("Binding failed: $bindResult");
      }
    } catch (e) {
      Logger.error("Exception during printing: "+e.toString());
      addStatusMessage("Exception during printing: "+e.toString());
    }
  }

  /// Helper: Build print data lines for temple receipt, using only supported fields
  List<Map<String, dynamic>> _buildTempleReceiptPrintData({
    required GetTemplemodel currentTemple,
    required List<Map<String, dynamic>> receipts,
    required String receiptNo,
    required String receiptDate,
    required String receiptTime,
  }) {
    int totalAmount = 0;

    final List<Map<String, dynamic>> lines = [
      _printLine(currentTemple.templeName),
      _printLine(currentTemple.address),
      _printLine("Phone: "+currentTemple.phoneNumber),
      _dividerLine(),
      _leftLine("Date: $receiptDate    Time: $receiptTime"),
      _leftLine("Receipt No: $receiptNo"),
      _dividerLine(),
      _leftLine("Sl Name   Star   Vazhi   Qty Amt"),
      _dividerLine(),
    ];

    for (int i = 0; i < receipts.length; i++) {
      final item = receipts[i];
      final name = (item['personName'] ?? '').toString();
      final star = (item['personStar'] ?? '').toString();
      final vazhipadu = (item['offerName'] ?? '').toString();
      final qty = int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;
      final rate = int.tryParse(item['rate']?.toString() ?? '0') ?? 0;
      final amt = qty * rate;
      totalAmount += amt;

      final row =
          '${(i + 1).toString().padRight(2)} '
          '${_clip(name, 6)} '
          '${_clip(star, 5)} '
          '${_clip(vazhipadu, 6)} '
          '${qty.toString().padLeft(2)} '
          '${'₹$amt'.padLeft(5)}';

      lines.add(_leftLine(row));
    }

    lines.add(_dividerLine());
    lines.add(_printLine("Total: ₹$totalAmount"));
    return lines;
  }

  // Only supported fields, PrinterWidth=24, IsCenterAligned as int (1/0)
  Map<String, dynamic> _printLine(String data) {
    return {
      "PrintDataType": "0",
      "PrinterWidth": 24,
      "IsCenterAligned": 1, // 1 for true
      "DataToPrint": data,
      "ImagePath": "0",
      "ImageData": "0",
    };
  }

  Map<String, dynamic> _leftLine(String data) {
    return {
      "PrintDataType": "0",
      "PrinterWidth": 24,
      "IsCenterAligned": 0, // 0 for false
      "DataToPrint": data,
      "ImagePath": "0",
      "ImageData": "0",
    };
  }

  Map<String, dynamic> _dividerLine() {
    return _leftLine("-" * 24);
  }

  String _clip(String text, int width) {
    return text.length > width ? text.substring(0, width) : text.padRight(width);
  }

  String _formattedDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}';
  }

  String _formattedTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}