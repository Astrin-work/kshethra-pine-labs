import 'package:flutter/material.dart';
import 'package:kshethra_mini/view/widgets/e_hundi_page_widgets/choose_payment_method_e_hundi_widget.dart';
import 'package:kshethra_mini/view_model/donation_viewmodel.dart';
import 'package:kshethra_mini/view_model/e_hundi_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import '../booking_page_widget/float_button_widget.dart';

class PaymentMethodScreenEHundi extends StatefulWidget {
  final String? amount;
  final String? name;
  final String? phone;
  final String? acctHeadName;
  const PaymentMethodScreenEHundi({
    super.key,
    this.amount,
    this.name,
    this.phone,
    this.acctHeadName,
  });

  @override
  State<PaymentMethodScreenEHundi> createState() =>
      _PaymentMethodScreenState();
}
class _PaymentMethodScreenState extends State<PaymentMethodScreenEHundi> {
  String _selectedMethod = 'Cash';

  void _onMethodSelected(String method) {
    setState(() {
      _selectedMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingViewmodel = Provider.of<BookingViewmodel>(
      context,
      listen: false,
    );

    return Scaffold(
      body: Column(
        children: [
          const AppBarWidget(title: "Select Payment Method"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ChoosePaymentMethodEHundiWidget(
                selectedMethod: _selectedMethod,
                onMethodSelected: _onMethodSelected,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatButtonWidget(
        amount: int.tryParse(widget.amount ?? '0') ?? 0,
        height: 60,
        title: 'Confirm',
        noOfScreens: 1,
        payOnTap: () {
          final donationViewmodel = Provider.of<DonationViewmodel>(
            context,
            listen: false,
          );
          final amount = widget.amount ?? '0';
          final name = widget.name ?? '';
          final phone = widget.phone ?? '';
          switch (_selectedMethod) {
            case 'UPI':
              print("Navigating to UPI QR Scanner with:");
              print("Amount: $amount, Name: $name, Phone: $phone");

              EHundiViewmodel().navigateToQrScanner(
                context,
                amount,
                name: name,
                phone: phone,
              );
              break;

            case 'Card':
              print("Navigating to Card Payment");
              donationViewmodel.navigateCardScreen(
                context,
                amount: amount,
                name: name,
                phone: phone,
              );
              break;

            default:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Unsupported payment method')),
              );
          }
        },
      ),
    );
  }
}
