import 'package:flutter/material.dart';
import 'package:kshethra_mini/view/widgets/donation_page_widgets/donation_dialogbox_widget.dart';

class DonationViewmodel extends ChangeNotifier{
  TextEditingController donationAmountController = TextEditingController();

   void showDonationDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => DonationDialogWidget());
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


}