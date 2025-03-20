import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/dialog_box_widget.dart';
import 'package:kshethra_mini/view/booking_view.dart';
import 'package:kshethra_mini/view/donation_view.dart';
import 'package:kshethra_mini/view/e_hundi_view.dart';
import 'package:kshethra_mini/view/home_view.dart';
import 'package:kshethra_mini/view/advance_booking.dart';
import 'package:kshethra_mini/view/super_admin_home_view.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePageViewmodel extends ChangeNotifier {
  void homePageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeView()),
    );
  }

  void bookingPageNavigate(BuildContext context) {
    context.read<BookingViewmodel>().setBookingPage();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingView()),
    );
  }

  void preBookingPageNavigate(BuildContext context) {
    context.read<BookingViewmodel>().setBookingPage();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdvanceBooking()),
    );
  }

  void donationPageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DonationView()),
    );
  }

  void eHundiPageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EHundiView()),
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

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => DialogBoxWidget(
            title: 'Do you want to Logout ?',
            fButton: 'Logout',
            fOnTap: () {},
            sButton: 'Cancel',
            sOnTap: () => popFunction(context),
          ),
    );
  }

  void navigateSuperAdminHomeView(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SuperAdminHomeView()));
  }
}
