import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
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

class BookingViewmodel extends ChangeNotifier {
  bool _isExistedDevotee = false;
  bool get isExistedDevotee => _isExistedDevotee;

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

  void navigateBookingPreviewView(BuildContext context) {
    if (_totalVazhipaduAmt != 0) {
      _selectedGod = bList[0];
      _selectedStar = "Star".tr();
      bookingNameController.clear();
      _isExistedDevotee = false;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingPreviewView(page: 'booking'),
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
    //  _totalVazhipaduAmt = _advBookingSavedAmt;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdvanceBookingPreviewView()),
    );
  }

  void setAdvBookOption(String value) {
    value == "date" ? _selectedStar = "Star".tr() : _selectedDate = "Date".tr();
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
  ) {
    _selectedRepMethod = "Once";
    _selectedWeeklyDay = "Sun";
    bookingRepController.text = "1";
    int x = selectedVazhipaadu["prize"];

    _totalVazhipaduAmt = _advBookingSavedAmt + (1 * x);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AdvancedBookingConfirmView(
              selectedVazhipaadu: selectedVazhipaadu,
            ),
      ),
    );
  }

  void bookingRepOnchange(
    String value,
    Map<String, dynamic> selectedVazhipaadu,
  ) {
    bool valid = advBookingKey.currentState?.validate() ?? false;
    if (!valid) {
      return;
    }
    int x = selectedVazhipaadu["prize"];

    if (value.trim() != "") {
      int rep = int.parse(value.trim());
      _totalVazhipaduAmt = _advBookingSavedAmt + (rep * x);
    } else {
      _totalVazhipaduAmt = _advBookingSavedAmt;
    }
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
    _selectedStar = star;
    popFunction(context);
    notifyListeners();
  }

  void bookingAddNewDevottee() {
    bookingNameController.clear();
    bookingPhnoController.clear();
    _selectedStar = "Star";
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
        star: _selectedStar,
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

    if (_advBookOption == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Select one option from Star or Date",
          color: kGrey,
        ).build(context),
      );
      return;
    }

    _advBookingAmt =
        selectedVazhipaadu["prize"] *
        int.parse(bookingRepController.text.trim());
    _vazhipaduBookingList.add(
      UserBookingModel(
        name: bookingNameController.text.trim(),
        phno: bookingPhnoController.text.trim(),
        star: _selectedStar,
        date: _selectedDate,
        repMethode: _selectedRepMethod,
        day: _selectedRepMethod == "Weekly" ? _selectedWeeklyDay : '',
        option: advBookOption == "star" ? _selectedStar : _selectedDate,
        vazhiPad: [
          {
            "godName": selectedGod.god ?? "",
            "vazhipadu": selectedVazhipaadu["vazhi"],
            "prize": selectedVazhipaadu["prize"],
            "rep": bookingRepController.text.trim(),
            "tPrize": _advBookingAmt,
          },
        ],
      ),
    );

    _totalAdvBookingAmt += _advBookingAmt;
    // _totalVazhipaduAmt = _advBookingSavedAmt;
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => QrScannerComponent(
              amount: amount != null ? "$amount" : "$totalVazhipaduAmt",
              noOfScreen: noOfScreens,
              title: title,
            ),
      ),
    );
    notifyListeners();
  }

  void switchSelectedRepMethod(String value) {
    _selectedRepMethod = value;
    notifyListeners();
  }

  bool toggleSelectedRepMethod(String value) {
    if (_selectedRepMethod == value) {
      return true;
    } else {
      return false;
    }
  }

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
