import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/view/booking_preview_view.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

class AdvanceBookingPreviewView extends StatelessWidget {
  const AdvanceBookingPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<BookingViewmodel>(
        builder:
            (context, bookingViewmodel, child) =>
                FloatButtonWidget(amount: bookingViewmodel.totalAdvBookingAmt, title: 'Advanced Booking', noOfScreens: 4,),
      ),
      body: Column(
        children: [AppBarWidget(title: "Advanced Booking"), PreViewWidget()],
      ),
    );
  }
}
