import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/components/qr_code_component.dart';
import 'package:kshethra_mini/utils/components/snack_bar_widget.dart';
import 'package:kshethra_mini/view/widgets/e_hundi_page_widgets/e_hundi_dialogbox_widget.dart';

class EHundiViewmodel extends ChangeNotifier {
  TextEditingController eHundiAmountController = TextEditingController();
  TextEditingController eHundiNameController = TextEditingController();
  final TextEditingController eHundiPhoneController = TextEditingController();


  final eHundiKey = GlobalKey<FormState>();

  void clearHundiAmount() {
   eHundiAmountController.clear();
   eHundiNameController.clear();
   eHundiPhoneController.clear();
    notifyListeners();
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


  void showEhundiDonationDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => EHundiDialogWidget());
  }

  void navigateScannerPage(BuildContext context) {
    bool valid = eHundiKey.currentState?.validate() ?? false;
    if (!valid) {
      return;
    }
    if (eHundiAmountController.text.trim() == "0") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Payment request denied",
          color: kRed,
        ).build(context),
      );
      return;
    }
    popFunction(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QrScannerComponent(
          amount: eHundiAmountController.text.trim(),
          noOfScreen: 3,
          title: 'E-Hundi',
        ),
      ),
    );
  }
}

