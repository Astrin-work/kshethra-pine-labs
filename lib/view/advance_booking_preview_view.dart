import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/view/booking_preview_view.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/float_button_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

class AdvanceBookingPreviewView extends StatelessWidget {
  const AdvanceBookingPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<BookingViewmodel>(
        builder:
            (context, bookingViewmodel, child) => ResponsiveLayout(
              pinelabDevice: FloatButtonWidget(
                amount: bookingViewmodel.totalAdvBookingAmt,
                title: 'Advanced Booking',
                noOfScreens: 4,
              ),
              mediumDevice: FloatButtonWidget(
                height: 65,
                amount: bookingViewmodel.totalAdvBookingAmt,
                title: 'Advanced Booking',
                noOfScreens: 4,
              ),
              largeDevice: FloatButtonWidget(
                amount: bookingViewmodel.totalAdvBookingAmt,
                title: 'Advanced Booking',
                noOfScreens: 4,
                height: 75,
              ),
            ),
      ),
      body: Column(
        children: [
          AppBarWidget(title: "Advanced Booking"),
          PreViewWidget(page: 'advanced booking'),
        ],
      ),
    );
  }
}
