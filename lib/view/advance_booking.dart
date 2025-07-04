import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/advanced_booking_page_widget/advanced_booking_form_widget.dart';
import '../utils/components/responsive_layout.dart';

class AdvanceBooking extends StatelessWidget {
  const AdvanceBooking({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(title: "Advance Booking".tr()),
            ResponsiveLayout(
              pinelabDevice: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: AdvancedBookingFormWidget(),
              ),
              mediumDevice: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.125,
                ),
                child: AdvancedBookingFormWidget(
                  crossAxisSpacing: SizeConfig.screenWidth * 0.15,
                  mainAxisSpacing: SizeConfig.screenWidth * 0.1,
                ),
              ),
              semiMediumDevice: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.125,
                ),
                child: AdvancedBookingFormWidget(
                  crossAxisCount: 3,
                  crossAxisSpacing: SizeConfig.screenWidth * 0.05,
                  mainAxisSpacing: SizeConfig.screenWidth * 0.05,
                ),
              ),
              largeDevice: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.125,
                ),
                child: AdvancedBookingFormWidget(
                  crossAxisCount: 4,
                  crossAxisSpacing: SizeConfig.screenWidth * 0.015,
                  mainAxisSpacing: SizeConfig.screenWidth * 0.015,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
