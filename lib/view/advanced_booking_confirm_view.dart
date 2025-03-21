import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/advanced_booking_page_widget/advance_booking_confirm_form.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/booking_float_button_widget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/star_dialodbox_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class AdvancedBookingConfirmView extends StatelessWidget {
  final Map<String, dynamic> selectedVazhipaadu;
  const AdvancedBookingConfirmView({
    super.key,
    required this.selectedVazhipaadu,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<BookingViewmodel>(
      builder:
          (context, bookingViewmodel, child) => Scaffold(
            floatingActionButton: ResponsiveLayout(
              pinelabDevice: BookingFloatButtonWidget(
                payOnTap: () {
                  bookingViewmodel.popFunction(context);

                  bookingViewmodel.setVazhipaduAdvBookingList(
                    selectedVazhipaadu,
                    context,
                  );
                  bookingViewmodel.naviagteAdvBookingPreview(context);
                },
                addOnTap: () {
                  bookingViewmodel.bookingAddNewDevottee();
                  bookingViewmodel.popFunction(context);
                  bookingViewmodel.advBookingAddVazhipadu(
                    selectedVazhipaadu,
                    context,
                  );
                },
              ),
              mediumDevice: BookingFloatButtonWidget(
                height: 65,
                payOnTap: () {
                  bookingViewmodel.popFunction(context);

                  bookingViewmodel.setVazhipaduAdvBookingList(
                    selectedVazhipaadu,
                    context,
                  );
                  bookingViewmodel.naviagteAdvBookingPreview(context);
                },
                addOnTap: () {
                  bookingViewmodel.bookingAddNewDevottee();
                  bookingViewmodel.popFunction(context);
                  bookingViewmodel.advBookingAddVazhipadu(
                    selectedVazhipaadu,
                    context,
                  );
                },
              ),
              largeDevice: BookingFloatButtonWidget(
                height: 75,
                payOnTap: () {
                  bookingViewmodel.popFunction(context);

                  bookingViewmodel.setVazhipaduAdvBookingList(
                    selectedVazhipaadu,
                    context,
                  );
                  bookingViewmodel.naviagteAdvBookingPreview(context);
                },
                addOnTap: () {
                  bookingViewmodel.bookingAddNewDevottee();
                  bookingViewmodel.popFunction(context);
                  bookingViewmodel.advBookingAddVazhipadu(
                    selectedVazhipaadu,
                    context,
                  );
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AppBarWidget(title: selectedVazhipaadu["vazhi"]),

                  ResponsiveLayout(
                    pinelabDevice: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: AdvancedBookingConfirmForm(
                        selectedVazhipaadu: selectedVazhipaadu,
                      ),
                    ),
                    mediumDevice: Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.125,
                        right: SizeConfig.screenWidth * 0.125,
                      ),
                      child: AdvancedBookingConfirmForm(
                        selectedVazhipaadu: selectedVazhipaadu,
                      ),
                    ),
                    semiMediumDevice: Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.125,
                        right: SizeConfig.screenWidth * 0.125,
                      ),
                      child: AdvancedBookingConfirmForm(
                        selectedVazhipaadu: selectedVazhipaadu,
                      ),
                    ),
                    largeDevice: Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.125,
                        right: SizeConfig.screenWidth * 0.125,
                      ),
                      child: AdvancedBookingConfirmForm(
                        selectedVazhipaadu: selectedVazhipaadu,
                      ),
                    ),
                  ),

                  125.kH,
                ],
              ),
            ),
          ),
    );
  }
}
