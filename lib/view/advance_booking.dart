import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/advanced_booking_page_widget/advanced_booking_form_widget.dart';

class AdvanceBooking extends StatelessWidget {
  const AdvanceBooking({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(title: "Advanced Booking"),
            AdvancedBookingFormWidget(),
          ],
        ),
      ),
    );
  }
}
