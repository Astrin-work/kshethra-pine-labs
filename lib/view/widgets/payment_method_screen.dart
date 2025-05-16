import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kshethra_mini/utils/components/choose_payment_method_widget.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import '../../utils/components/qr_code_component.dart';
import 'booking_page_widget/booking_float_button_widget.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = 'Cash';

  void _onMethodSelected(String method) {
    setState(() {
      _selectedMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get BookingViewmodel instance via Provider
    final bookingViewmodel = Provider.of<BookingViewmodel>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          const AppBarWidget(title: "Advanced Booking"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ChoosePaymentMethodWidget(
                selectedMethod: _selectedMethod,
                onMethodSelected: _onMethodSelected,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BookingFloatButtonWidget(
        height: 60,
        payOnTap: () {
          print('tapped');

          bookingViewmodel.navigateToQrScanner(
            context: context,
            amount: "",         // replace with actual amount
            noOfScreens: 1,     // replace with actual number of screens
            title: "",          // replace with actual title
          );
        },
      ),
    );
  }
}
