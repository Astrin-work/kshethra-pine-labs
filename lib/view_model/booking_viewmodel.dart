import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/booking_model.dart';
import 'package:kshethra_mini/model/user_booking_model.dart';
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

  int _totalVazhipaduAmt = 0;
  int get totalVazhipaduAmt => _totalVazhipaduAmt;

  int _amtOfBookingVazhipaddu = 0;
  int get amtOfBookingVazhipaddu => _amtOfBookingVazhipaddu;

  BookingModel _selectedGod = bList[0];
  BookingModel get selectedGod => _selectedGod;

  TextEditingController bookingNameController = TextEditingController();

  TextEditingController bookingPhnoController = TextEditingController();

  String _selectedStar = "Star";
  String get selectedStar => _selectedStar;

  String _advBookOption = "";
  String get advBookOption => _advBookOption;

  String _selectedDate = "Date";
  String get selectedDate => _selectedDate;

  void setBookingPage() {
    _selectedGod = bList[0];
    _selectedStar = "Star";
    _selectedDate = "Date";
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
    _selectedGod = bList[0];
    _selectedStar = "Star";
    bookingNameController.clear();
    _isExistedDevotee = false;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingPreviewView()),
    );
  }

  void setAdvBookOption(String value) {
    value == "date" ? _selectedStar = "Star" : _selectedDate = "Date";
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

  void setGod(BookingModel value) {
    _selectedGod = value;
    notifyListeners();
  }

  void showVazhipadduDialogBox(
    BuildContext context,
    Map<String, dynamic> selectedVazhipaadu,
  ) {
    _noOfBookingVazhipaddu = 1;
    int x = selectedVazhipaadu["prize"];
    _amtOfBookingVazhipaddu = 1 * x;
    showDialog(
      context: context,
      builder:
          (context) =>
              VazhipadduDialogBoxWidget(selectedVazhippadu: selectedVazhipaadu),
    );
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
    _selectedStar = "Star";
    _isExistedDevotee = false;
    notifyListeners();
  }

  void setVazhipaduBookingList(
    Map<String, dynamic> selectedVazhipaadu,
    BuildContext context,
  ) {
    // log(_amtOfBookingVazhipaddu.toString());
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

    // UserBookingModel value = _vazhipaduBookingList.last;

    _totalVazhipaduAmt += calculateBookingTotalAmt();
    log(_totalVazhipaduAmt.toString(), name: "New Devotee");
    _isExistedDevotee = true;

    popFunction(context);
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
}
