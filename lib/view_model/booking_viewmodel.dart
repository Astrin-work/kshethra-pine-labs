import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/booking_model.dart';
import 'package:kshethra_mini/model/user_booking_model.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/components/qr_code_component.dart';
import 'package:kshethra_mini/utils/components/snack_bar_widget.dart';
import 'package:kshethra_mini/view/advance_booking_preview_view.dart';
import 'package:kshethra_mini/view/advanced_booking_confirm_view.dart';
import 'package:kshethra_mini/view/booking_preview_view.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/vazhipaddu_dialogbox_widget.dart';
import 'package:kshethra_mini/utils/components/choose_payment_method_Widget.dart';

import '../view/widgets/advanced_booking_page_widget/advanced_vazhipaddu_dialog_BoxWidget.dart';
import '../view/widgets/payment_method_screen.dart';

class BookingViewmodel extends ChangeNotifier {
  bool _isExistedDevotee = false;
  bool get isExistedDevotee => _isExistedDevotee;
  bool _isPostalAdded = false;
  bool _prasadamSelected = false;
  bool get prasadamSelected => _prasadamSelected;
  String _selectedMethod = 'Cash';
  List<UserBookingModel> _vazhipaduBookingList = [];
  List<UserBookingModel> get vazhipaduBookingList => _vazhipaduBookingList;

  int _noOfBookingVazhipaddu = 1;
  int get noOfBookingVazhipaddu => _noOfBookingVazhipaddu;

  int _advBookingAmt = 0;
  int get advBookingAmt => _advBookingAmt;

  int _totalAdvBookingAmt = 0;
  int get totalAdvBookingAmt => _totalAdvBookingAmt;

  int _totalVazhipaduAmt = 0;
  int get totalVazhipaduAmt => _totalVazhipaduAmt;

  int _advBookingSavedAmt = 0;
  int get advBookingSavedAmt => _advBookingSavedAmt;

  int _amtOfBookingVazhipaddu = 0;
  int get amtOfBookingVazhipaddu => _amtOfBookingVazhipaddu;





  BookingModel _selectedGod = bList[0];
  BookingModel get selectedGod => _selectedGod;

  final bookingKey = GlobalKey<FormState>();
  final advBookingKey = GlobalKey<FormState>();


  TextEditingController bookingNameController = TextEditingController();

  TextEditingController bookingPhnoController = TextEditingController();

  TextEditingController bookingRepController = TextEditingController();

  TextEditingController bookingAddressController = TextEditingController();

  String _selectedStar = "Star".tr();
  String get selectedStar => _selectedStar;

  String _selectedRepMethod = "Once";
  String get selectedRepMethod => _selectedRepMethod;

  String _selectedWeeklyDay = "Sun";
  String get selectedWeeklyDay => _selectedWeeklyDay;

  String _advBookOption = "";
  String get advBookOption => _advBookOption;

  String _selectedDate = "Date".tr();
  String get selectedDate => _selectedDate;


  String _postalOption = '';
  String get postalOption => _postalOption;

  int _repeatDays = 1;
  int get repeatDays => _repeatDays;


  set repeatDays(int value) {
    _repeatDays = value;
    _updatePostalAmount();
    _recalculateTotalAmount();
    notifyListeners();
  }

  double _postalAmount = 0.0;
  double get postalAmount => _postalAmount;


  double _totalAmount = 0.0;
  double get totalAmount => _totalAmount;


  void _updatePostalAmount() {
    if (_postalOption == 'Postal') {
      _postalAmount = 5.0 * _repeatDays;
    } else if (_postalOption == 'Speed Post') {
      _postalAmount = 45.0 * _repeatDays;
    } else {
      _postalAmount = 0.0;
    }
  }

  void togglePrasadam(bool value) {
    _prasadamSelected = value;
    if (!_prasadamSelected) {
      _postalOption = '';
      _postalAmount = 0.0;

      if (_isPostalAdded) {
        _totalVazhipaduAmt -= _postalAmount.toInt();
        _isPostalAdded = false;
      }
    }
    notifyListeners();
  }

  void updateRepeatDays(int days) {
    _repeatDays = days;
    notifyListeners();
  }



  void selectPostalOption(String option) {

    if (_isPostalAdded) {
      _totalVazhipaduAmt -= _postalAmount.toInt();
      _isPostalAdded = false;
    }

    _postalOption = option;

    if (_postalOption.isEmpty) {
      _postalAmount = 0.0;
    } else {
      _updatePostalAmount();
      _totalVazhipaduAmt += _postalAmount.toInt();
      _isPostalAdded = true;
    }

    _recalculateTotalAmount();

    print("Selected Postal Option: $_postalOption");
    print("Repeat Days: $_repeatDays");
    print("Postal Amount: ₹$_postalAmount");
    print("Total Vazhipaadu Amount (with postal): ₹$_totalVazhipaduAmt");

    notifyListeners();
  }


  void _recalculateTotalAmount() {
    _totalAmount = _totalVazhipaduAmt + _postalAmount;
  }

  void setBookingPage() {
    _advBookOption = "";
    _advBookingSavedAmt = 0;
    _totalAdvBookingAmt = 0;
    _selectedGod = bList[0];
    _selectedStar = "Star".tr();
    _selectedDate = "Date".tr();
    bookingAddressController.clear();
    bookingNameController.clear();
    _isExistedDevotee = false;
    _vazhipaduBookingList = [];
    _totalVazhipaduAmt = 0;
    bookingPhnoController.clear();
  }

  void clearBookingControllers() {
    bookingNameController.clear();
    bookingPhnoController.clear();
    bookingRepController.clear();
    bookingAddressController.clear();
  }

  void popFunction(BuildContext context) {
    Navigator.pop(context);
  }

  String setQrAmount(String amount) {
    String value = "upi://pay?pa=6282488785@superyes&am=$amount&cu=INR";
    return value;
  }

  void backtoHomePage(BuildContext context, int noOfPage) {
    for (int i = 1; i <= noOfPage; i++) {
      popFunction(context);
    }
  }

  // void navigateBookingPreviewView(BuildContext context) {
  //   if (_totalVazhipaduAmt != 0) {
  //     _selectedGod = bList[0];
  //     _selectedStar = "Star".tr();
  //     bookingNameController.clear();
  //     _isExistedDevotee = false;
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => BookingPreviewView(page: 'booking',),
  //
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBarWidget(
  //         msg: "Please select a Vazhippadu",
  //         color: kGrey,
  //       ).build(context),
  //     );
  //   }
  //   notifyListeners();
  // }


  void navigateBookingPreviewView(BuildContext context) {
    if (_totalVazhipaduAmt != 0) {
      _selectedGod = bList[0];
      _selectedStar = "Star".tr();
      bookingNameController.clear();
      _isExistedDevotee = false;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingPreviewView(
            page: 'booking',
            selectedRepMethod: selectedRepMethod, // 👈 from ViewModel
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Please select a Vazhippadu",
          color: kGrey,
        ).build(context),
      );
    }

    notifyListeners();
  }


  void naviagteAdvBookingPreview(BuildContext context) {
    _totalAdvBookingAmt = _advBookingSavedAmt + _totalAdvBookingAmt;

    if (_totalVazhipaduAmt == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Payment request denied!",
          color: kRed,
        ).build(context),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AdvancedBookingPreviewView(
          totalAmount: _totalVazhipaduAmt,
          selectedRepMethod: selectedRepMethod, // 👈 Add this
        ),
      ),
    );

    print("------------totalAmount------------");
    print(_totalVazhipaduAmt);

    notifyListeners();
  }


  // void setAdvBookOption(String value) {
  //   value == "date".tr()
  //       ? _selectedStar = "Star".tr()
  //       : _selectedDate = "Date".tr();
  //   _advBookOption = value;
  //   notifyListeners();
  // }

  void setAdvBookOption(String value) {
    _advBookOption = value;
    notifyListeners();
  }

  void selectBookingDate(BuildContext context) async {
    DateTime? value = await showDatePicker(
      context: context,
      firstDate: getTomorrow(),
      lastDate: getOneYear(),
    );
    if (value != null) {
      _selectedDate = formatDateTime(value);
    }
    notifyListeners();
  }

  String formatDateTime(DateTime dateTime) {
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String year = dateTime.year.toString();
    return '$day/$month/$year';
  }

  DateTime getTomorrow() {
    return DateTime.now().add(Duration(days: 1));
  }

  DateTime getOneYear() {
    return DateTime.now().add(Duration(days: 365));
  }

  void navigateAdvancedBookingConfirm(
      BuildContext context,
      Map<String, dynamic> selectedVazhipaadu,
      BookingViewmodel bookingViewmodel,
      ) {
    _selectedRepMethod = "Once";
    _selectedWeeklyDay = "Sun";
    bookingRepController.text = "1";

    int unitPrice = selectedVazhipaadu["prize"] ?? 0;
    int quantity = bookingViewmodel.noOfBookingVazhipaddu;

    _totalVazhipaduAmt = _advBookingSavedAmt + (quantity * unitPrice);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => AdvancedBookingConfirmView(
          selectedVazhipaadu: selectedVazhipaadu,
          totalAmount: _totalVazhipaduAmt,

        ),
      ),
    );
    print("-----------amount------------");
    print(_totalVazhipaduAmt);
  }



  void bookingRepOnchange(
      String value,
      Map<String, dynamic> selectedVazhipaadu,
      Map<String, double> postalRates,
      double amount,
      ) {
    int? repCount = int.tryParse(value.trim());

    if (repCount == null || repCount <= 0) {
      _repeatDays = 1;
      _totalVazhipaduAmt = _advBookingSavedAmt;
      notifyListeners();
      return;
    }

    _repeatDays = repCount;
    print("Number of repeat days: $_repeatDays");

    int unitPrice = selectedVazhipaadu["prize"] ?? 0;
    int quantity = noOfBookingVazhipaddu;
    int baseAmount = unitPrice * quantity;

    _totalVazhipaduAmt = baseAmount * _repeatDays;

    print("---------------------- Total Calculation -------------------");
    print("Unit Price: ₹$unitPrice");
    print("Quantity: $quantity");
    print("Repeat Days: $_repeatDays");
    print("Base Amount: ₹$baseAmount");
    print("Total Vazhipaadu Amount (without postal): ₹$_totalVazhipaduAmt");

    if (_postalOption.isNotEmpty) {
      _updatePostalAmount();
      _totalVazhipaduAmt += _postalAmount.toInt();
      _isPostalAdded = true;
    }

    print("Total Postal Amount: ₹$_postalAmount");
    print("Final Total Vazhipaadu Amount (with postal): ₹$_totalVazhipaduAmt");

    notifyListeners();
  }





  void advBookingAddVazhipadu(
      Map<String, dynamic> selectedVazhipaadu,
      BuildContext context,
      ) {
    bool valid = advBookingKey.currentState?.validate() ?? false;
    if (!valid) {
      return;
    }
    if (_advBookOption == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Select one option from Star or Date",
          color: kGrey,
        ).build(context),
      );
      return;
    }

    _advBookingSavedAmt = _totalVazhipaduAmt;
    setVazhipaduAdvBookingList(selectedVazhipaadu, context);
    bookingAddNewDevottee();
    popFunction(context);
  }

  void setGod(BookingModel value) {
    _selectedGod = value;
    notifyListeners();
  }

  void showVazhipadduDialogBox(
      BuildContext context,
      Map<String, dynamic> selectedVazhipaadu,
      ) {
    bool valid = bookingKey.currentState?.validate() ?? false;
    if (!valid) return;

    _noOfBookingVazhipaddu = 1;
    int x = selectedVazhipaadu["prize"];
    _amtOfBookingVazhipaddu = 1 * x;
    if (_selectedStar != "Star") {
      showDialog(
        context: context,
        builder:
            (context) => VazhipadduDialogBoxWidget(
          selectedVazhippadu: selectedVazhipaadu,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(msg: "Select your star", color: kGrey).build(context),
      );
    }
    notifyListeners();
  }

  void showAdvancedVazhipadduDialogBox(
      BuildContext context,
      Map<String, dynamic> selectedVazhipadu,
      ) {
    _noOfBookingVazhipaddu = 1;
    _amtOfBookingVazhipaddu = selectedVazhipadu["prize"];

    showDialog(
      context: context,
      builder: (context) {
        return AdvancedVazhipadduDialogBoxwidget(
          selectedVazhippadu: selectedVazhipadu,
        );
      },
    );

    notifyListeners();
  }

  void resetDialogState() {
    _noOfBookingVazhipaddu = 1;
    _amtOfBookingVazhipaddu = 0;
  }

  void addNoOfBookingVazhipaddu(int ammount) {
    _noOfBookingVazhipaddu++;
    _amtOfBookingVazhipaddu = _noOfBookingVazhipaddu * ammount;
    notifyListeners();
  }

  void removeNoOfBookingVazhipaddu(int ammount) {
    if (_noOfBookingVazhipaddu > 1) {
      _noOfBookingVazhipaddu--;
      _amtOfBookingVazhipaddu = _noOfBookingVazhipaddu * ammount;
    }
    notifyListeners();
  }

  void setStar(String star, BuildContext context) {
    _selectedStar = star.tr();
    popFunction(context);
    notifyListeners();
  }

  void bookingAddNewDevottee() {
    bookingNameController.clear();
    bookingPhnoController.clear();
    _selectedStar = "Star".tr();
    _isExistedDevotee = false;
    notifyListeners();
  }

  void setVazhipaduBookingList(
      Map<String, dynamic> selectedVazhipaadu,
      BuildContext context,
      ) {
    _vazhipaduBookingList.add(
      UserBookingModel(
        name: bookingNameController.text.trim(),
        star: _selectedStar.tr(),
        vazhiPad: [
          {
            "godName": selectedGod.god ?? "",
            "vazhipadu": selectedVazhipaadu["vazhi"],
            "prize": selectedVazhipaadu["prize"],
            "rep": _noOfBookingVazhipaddu,
            "tPrize": _amtOfBookingVazhipaddu,
          },
        ],
      ),
    );
    _totalVazhipaduAmt += calculateBookingTotalAmt();
    log(_totalVazhipaduAmt.toString(), name: "New Devotee");
    _isExistedDevotee = true;

    popFunction(context);
    notifyListeners();
  }

  void setVazhipaduAdvBookingList(
      Map<String, dynamic> selectedVazhipaadu,
      BuildContext context,
      ) {

    bool valid = advBookingKey.currentState?.validate() ?? false;
    if (!valid) {
      return;
    }


    if (_advBookOption.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Select one option from Star or Date",
          color: kGrey,
        ).build(context),
      );
      return;
    }


    int repetitions = int.tryParse(bookingRepController.text.trim()) ?? 0;


    if (repetitions == 0 && bookingRepController.text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Please enter a valid number for repetitions",
          color: kGrey,
        ).build(context),
      );
      return;
    }

    _advBookingAmt = selectedVazhipaadu["prize"] * repetitions;

    _vazhipaduBookingList.add(
      UserBookingModel(
        name: bookingNameController.text.trim(),
        phno: bookingPhnoController.text.trim(),
        star: _selectedStar.tr(),
        date: _selectedDate,
        repMethode: _selectedRepMethod,
        day: _selectedRepMethod == "Weekly" ? _selectedWeeklyDay : '',
        option: _advBookOption == "star".tr() ? _selectedStar : _selectedDate,
        vazhiPad: [
          {
            "godName": selectedGod.god ?? "",
            "vazhipadu": selectedVazhipaadu["vazhi"] ?? "",
            "prize": selectedVazhipaadu["prize"] ?? 0,
            "rep": bookingRepController.text.trim(),
            "tPrize": _advBookingAmt,
          },
        ],
      ),
    );


    _totalAdvBookingAmt += _advBookingAmt;


    log(_totalAdvBookingAmt.toString(), name: "adv booking");


    popFunction(context);
    naviagteAdvBookingPreview(context);


    notifyListeners();
  }

  int calculateBookingTotalAmt() {
    UserBookingModel value = _vazhipaduBookingList.last;

    int total = 0;
    total += value.vazhiPad.last["tPrize"] as int;

    return total;
  }

  void addVazhipaddToExisting(
      Map<String, dynamic> selectedVazhipaadu,
      BuildContext context,
      ) {
    _vazhipaduBookingList.last.vazhiPad.add({
      "godName": selectedGod.god ?? "",
      "vazhipadu": selectedVazhipaadu["vazhi"],
      "prize": selectedVazhipaadu["prize"],
      "rep": _noOfBookingVazhipaddu,
      "tPrize": _amtOfBookingVazhipaddu,
    });

    // UserBookingModel value = _vazhipaduBookingList.last;

    _totalVazhipaduAmt += calculateBookingTotalAmt();

    log(_totalVazhipaduAmt.toString(), name: "Existing Devotee");
    popFunction(context);
    notifyListeners();
  }

  void setAdvBookingAmt() {}

  void vazhipaduDelete(int indexOfVazhipad, int indexOfPooja) {
    int amt =
    _vazhipaduBookingList[indexOfVazhipad].vazhiPad[indexOfPooja]["tPrize"];
    log(amt.toString());
    _totalVazhipaduAmt -= amt;
    _vazhipaduBookingList[indexOfVazhipad].vazhiPad.removeAt(indexOfPooja);
    if (_vazhipaduBookingList[indexOfVazhipad].vazhiPad.isEmpty ||
        _vazhipaduBookingList[indexOfVazhipad].vazhiPad == []) {
      _vazhipaduBookingList.removeAt(indexOfVazhipad);
    }

    notifyListeners();
  }

  void advBookingDeleteVazhipadd(int indexOfVazhipad, int indexOfPooja) {
    int amt =
    _vazhipaduBookingList[indexOfVazhipad].vazhiPad[indexOfPooja]["tPrize"];
    vazhipaduDelete(indexOfVazhipad, indexOfPooja);

    _totalAdvBookingAmt -= amt;
    notifyListeners();
  }

  void bookingPreviewSecondFloatButton(
      BuildContext context,
      int? amount,
      int noOfScreens,
      String title,
      ) {
    if (totalVazhipaduAmt == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Payment request denied !",
          color: kRed,
        ).build(context),
      );
      return;
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder:
    //         (context) => QrScannerComponent(
    //       amount: amount != null ? "$amount" : "$totalVazhipaduAmt",
    //       noOfScreen: noOfScreens,
    //       title: title,
    //     ),
    //   ),
    // );
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) =>PaymentMethodScreen()));
    notifyListeners();
  }
  void navigateToQrScanner({
    required BuildContext context,
    required String amount,
    required int noOfScreens,
    required String title,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QrScannerComponent(
          amount: amount != null ? "$amount" : "$totalVazhipaduAmt",
          noOfScreen: noOfScreens,
          title: title,
        ),
      ),
    );
  }



  // void switchSelectedRepMethod(String value) {
  //   _selectedRepMethod = value;
  //   notifyListeners();
  // }
  void switchSelectedRepMethod(String method) {
    _selectedRepMethod = method;
    notifyListeners();
  }
  bool toggleSelectedRepMethod(String method) {
    return _selectedRepMethod == method;
  }
  // bool toggleSelectedRepMethod(String value) {
  //   return _selectedRepMethod == value;
  // }

  void switchSelectedWeeklyDay(String value) {
    _selectedWeeklyDay = value;
    notifyListeners();
  }

  bool toggleSelectedWeeklyDay(String value) {
    if (_selectedWeeklyDay == value) {
      return true;
    } else {
      return false;
    }
  }
}


