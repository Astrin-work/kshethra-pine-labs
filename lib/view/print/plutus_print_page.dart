import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlutusPrintPage extends StatelessWidget {
  static const platform = MethodChannel('plutus_smart_channel');

  void _printFromDevice() async {
    try {
      final result = await platform.invokeMethod('printReceipt');
      print('Printing result: $result');
    } on PlatformException catch (e) {
      print('Failed to print: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plutus Print Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: _printFromDevice,
          child: Text('Print Receipt'),
        ),
      ),
    );
  }
}
