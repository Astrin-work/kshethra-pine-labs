import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/components/qr_code_component.dart';
import 'package:kshethra_mini/utils/components/snack_bar_widget.dart';
import 'package:kshethra_mini/view/widgets/donation_page_widgets/donation_dialogbox_widget.dart';

import '../api_services/api_service.dart';

class DonationViewmodel extends ChangeNotifier {
  TextEditingController donationAmountController = TextEditingController();
  TextEditingController donationNameController = TextEditingController();
  TextEditingController donationPhnoController = TextEditingController();

  final donationFormKey = GlobalKey<FormState>();

  final donationKey = GlobalKey<FormState>();

  void clearController() {
    donationAmountController.clear();
    donationNameController.clear();
  }

  void showDonationDialog(
    BuildContext context,
    String name,
    String phone,
    String acctHeadName,
  ) {
    bool valid = donationFormKey.currentState?.validate() ?? false;
    if (!valid) {
      return;
    }

    clearDonationAmount();

    showDialog(
      context: context,
      builder:
          (context) => DonationDialogWidget(
            name: name,
            phone: phone,
            acctHeadName: acctHeadName,
          ),
    );
  }

  void popFunction(BuildContext context) {
    Navigator.pop(context);
  }

  void backtoHomePage(BuildContext context, int noOfPage) {
    for (int i = 1; i <= noOfPage; i++) {
      popFunction(context);
    }
  }

  String setQrAmount(String amount) {
    String value = "upi://pay?pa=6282488785@superyes&am=$amount&cu=INR";

    return value;
  }

  void clearDonationAmount() {
    donationAmountController.clear();
  }

  void navigateScannerPage(BuildContext context) {
    bool valid = donationKey.currentState?.validate() ?? false;
    if (!valid) {
      return;
    }
    if (donationAmountController.text.trim() == "0") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(msg: "Enter a Valid amount", color: kRed).build(context),
      );
      return;
    }
    popFunction(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => QrScannerComponent(
              amount: donationAmountController.text.trim(),
              noOfScreen: 3,
              title: 'Donation',
            ),
      ),
    );
  }

  Future<bool> postDonation(BuildContext context) async {
    final donationData = {
      "name": donationNameController.text.trim(),
      "phoneNumber": donationPhnoController.text.trim(),
      "acctHeadName": donationNameController.text.trim(),
      "amount": donationAmountController.text.trim(),
      "paymentType": "UPI",
      "transactionId": "txn_${DateTime.now().millisecondsSinceEpoch}",
      "bankId": "BANK001",
      "bankName": "Test Bank",
    };

    try {
      await ApiService().postDonationDetails(donationData);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Donation posted successfully!")));
      return true;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to post donation: $e")));
      return false;
    }
  }



}
