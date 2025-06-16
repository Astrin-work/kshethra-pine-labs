import 'package:flutter/material.dart';
import 'package:kshethra_mini/view_model/donation_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:kshethra_mini/utils/components/choose_payment_method_widget.dart';
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
    final total =
        bookingViewmodel.combinedTotalAmount + bookingViewmodel.postalAmount;
    return Scaffold(
      body: Column(
        children: [
          const AppBarWidget(title: "Select Payment Method"),
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
      floatingActionButton: FloatButtonWidget(
        amount: int.tryParse(widget.amount ?? '0') ?? 0,
        height: 60,
        title: 'Confirm',
        noOfScreens: 1,
        payOnTap: () {
          switch (_selectedMethod) {
            case 'UPI':
              final donationViewmodel = Provider.of<DonationViewmodel>(
                context,
                listen: false,
              );
              final amount =
                  donationViewmodel.donationAmountController.text.trim();
              DonationViewmodel().navigateToQrScanner(context, amount);
              break;
            case 'Cash':
              final donationViewmodel = Provider.of<DonationViewmodel>(context, listen: false);
              final amount = donationViewmodel.donationAmountController.text.trim();

              donationViewmodel.navigateToCashPayment(
                context,
                amount: amount,
                name: widget.name ?? '',
                phone: widget.phone ?? '',
                acctHeadName: widget.acctHeadName ?? '',
              );
              break;

            case 'Card':
              DonationViewmodel().navigateCardScreen(context);
              break;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Unsupported payment method')),
              );
          }
        },
      ),
    );
  }
}
