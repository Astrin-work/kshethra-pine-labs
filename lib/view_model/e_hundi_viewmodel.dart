import 'package:flutter/material.dart';
import 'package:kshethra_mini/view/widgets/e_hundi_page_widgets/e_hundi_dialogbox_widget.dart';

class EHundiViewmodel extends ChangeNotifier {
  TextEditingController eHundiAmountController = TextEditingController();

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

  void clearHundiAmount() {
    eHundiAmountController.clear();
  }

  void showEhundiDonationDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => EHundiDialogWidget());
  }
}
