import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/booking_model.dart';
import 'package:kshethra_mini/model/user_booking_model.dart';
import 'package:kshethra_mini/view/booking_view.dart';
import 'package:kshethra_mini/view/donation_view.dart';
import 'package:kshethra_mini/view/e_hundi_view.dart';
import 'package:kshethra_mini/view/home_view.dart';
import 'package:kshethra_mini/view/language_select_view.dart';
import 'package:kshethra_mini/view/pre_booking.dart';
import 'package:kshethra_mini/view/qr_payment_view.dart';

class HomePageViewmodel extends ChangeNotifier {
  bool _isPassVissible = false;
  bool get isPassVissible => _isPassVissible;

  List<UserBookingModel>_vazhipaduBookingList = [];
   List<UserBookingModel>get vazhipaduBookingList => _vazhipaduBookingList; 

  int _noOfBookingVazhipaddu = 1;
  int get noOfBookingVazhipaddu => _noOfBookingVazhipaddu;

  int _amtOfBookingVazhipaddu = 0;
  int get amtOfBookingVazhipaddu => _amtOfBookingVazhipaddu;

  BookingModel _selectedGod = bList[0];
  BookingModel get selectedGod => _selectedGod;

  TextEditingController donationAmountController = TextEditingController();
  TextEditingController bookingNameController = TextEditingController();


  String _donationAmount = "0";
  String get donationAmount => _donationAmount;

  String _selectedStar = "Star";
  String get selectedStar => _selectedStar;

  void tooglePass() {
    _isPassVissible = !_isPassVissible;
    notifyListeners();
  }

  void selectLanguagePageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LanguageSelectView()),
    );
  }

  void homePageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeView()),
    );
  }

  void bookingPageNavigate(BuildContext context) {
    _selectedGod = bList[0];
    _selectedStar = "Star"; 
    _vazhipaduBookingList = [];
    bookingNameController.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingView()),
    );
  }

  void preBookingPageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreBooking()),
    );
  }

  void donationPageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DonationView()),
    );
    clearDonationAmount();
  }

  void eHundiPageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EHundiView()),
    );
  }

  void showDonationDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => DonationDialogWidget());
  }

  void popFunction(BuildContext context) {
    Navigator.pop(context);
  }

  void backtoHomePage(BuildContext context) {
    popFunction(context);
    popFunction(context);
    popFunction(context);
  }

  void navigateQrPayment(BuildContext context) {
    setQrAmount(donationAmountController.text);
    popFunction(context);
    showDialog(context: context, builder: (context) => QrPaymentView());
  }

  void setQrAmount(String amount) {
    _donationAmount = "upi://pay?pa=6282488785@superyes&am=$amount&cu=INR";
  }

  void clearDonationAmount() {
    donationAmountController.clear();
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

  void showStarDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => StarDialogBox());
  }

  void setStar(String star,BuildContext context) {
    _selectedStar = star;
    popFunction(context);
    notifyListeners();
  }

  void bookingAddNewDevottee(){
    bookingNameController.clear();
    _selectedStar = "Star";
    notifyListeners();
  }


  void setVazhipaduBookingList(Map<String, dynamic> selectedVazhipaadu){

    _vazhipaduBookingList.add(UserBookingModel(
      name:bookingNameController.text.trim(), star: _selectedStar, vazhiPad: [
        {
          "godName":selectedGod.god??"",
          "vazhipadu":selectedVazhipaadu["vazhi"],
          "prize":selectedVazhipaadu["prize"],
          "rep": _noOfBookingVazhipaddu,
          "tPrize":_amtOfBookingVazhipaddu
        }
      ],
    )); 
  }




}
