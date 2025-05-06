import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_styles.dart';
import '../../../view_model/booking_viewmodel.dart';

class RepCheckBoxWidget extends StatelessWidget {
  const RepCheckBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    return Consumer<BookingViewmodel>(
      builder:
          (context, bookingViewmodel, child) => SizedBox(
        // color: kGreen,
        width: 250,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Text("Once".tr(), style: styles.blackRegular15),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedRepMethod(
                          "Once".tr(),
                        ),
                        onChanged: (value) {
                          bookingViewmodel.switchSelectedRepMethod(
                            "Once".tr(),
                          );
                        },

                        activeColor: kDullPrimaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text("Weekly".tr(), style: styles.blackRegular15),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedRepMethod(
                          "Weekly".tr(),
                        ),
                        onChanged: (value) {
                          bookingViewmodel.switchSelectedRepMethod(
                            "Weekly".tr(),
                          );
                        },

                        activeColor: kDullPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Text("Daily".tr(), style: styles.blackRegular15),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedRepMethod(
                          "Daily".tr(),
                        ),
                        onChanged: (value) {
                          bookingViewmodel.switchSelectedRepMethod(
                            "Daily".tr(),
                          );
                        },

                        activeColor: kDullPrimaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text("Monthly".tr(), style: styles.blackRegular15),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedRepMethod(
                          "Monthly".tr(),
                        ),
                        onChanged: (value) {
                          bookingViewmodel.switchSelectedRepMethod(
                            "Monthly".tr(),
                          );
                        },

                        activeColor: kDullPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}