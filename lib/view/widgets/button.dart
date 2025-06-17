
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../print_service/print_service.dart';
import '../../services/plutus_smart.dart';
import '../../utils/logger.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {

  // final printDataJson = jsonEncode( {
  //   "Header": {
  //     "ApplicationId": "f0d097be4df3441196d1e37cb2c98875",
  //     "UserId": "123456",
  //     "MethodId": "1002",
  //     "VersionNo": "1.0",
  //   },
  //   "Detail": {
  //     "PrintRefNo": "RECEIPT123456",
  //     "SavePrintData": false,
  //     "Data": [
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "Merchant Name",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "123 Main Street",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "City, State, ZIP",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "Receipt Number: RECEIPT12345",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "Date: 2024-10-27 10:30 AM",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "------------------------",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": false,
  //         "DataToPrint": "Item 1: INR 10.00",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": false,
  //         "DataToPrint": "Item 2: INR 20.00",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "------------------------",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": false,
  //         "DataToPrint": "Total: INR 30.00",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "------------------------",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       },
  //       {
  //         "PrintDataType": "3",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "RECEIPT12345",
  //         "ImagePath": "",
  //         "ImageData": ""
  //       },
  //       {
  //         "PrintDataType": "4",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "https://example.com/receipt/RECEIPT12345",
  //         "ImagePath": "",
  //         "ImageData": ""
  //       },
  //       {
  //         "PrintDataType": "0",
  //         "PrinterWidth": 24,
  //         "IsCenterAligned": true,
  //         "DataToPrint": "Thank You!",
  //         "ImagePath": "0",
  //         "ImageData": "0"
  //       }
  //     ]
  //   },
  // });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bindService();
    });

    return Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(onPressed: () async {
            // print("ENTERED FUNTION");
            // final result = await PlutusSmart.startPrintJob(printDataJson);
            // print(result);
            await PrintService.printReceipt(
              serialNumber: "1234", receipts: [],
            );
          }, child: Text("Print"),),
        ),
      ],
    ));
  }

  Future<void> _bindService() async {

    Logger.info('BINDING STARTED.');

    try {
      final result = await PlutusSmart.bindToService();
      Logger.info('Binding result: $result');

      if (result == "SUCCESS" || result == "BINDING SUCCESS.") {
        Logger.success("BINDING SUCCESS.");
      } else if (result == "FAILED") {
        Logger.error("BINDING FAILED. ${result.toString()}");
      } else {
        Logger.error("BINDING UNKNOWN RESULT. ${result.toString()}");
      }
    } catch (e) {
      Logger.error("BINDING EXCEPTION. ${e.toString()}");
    }
  }
}
