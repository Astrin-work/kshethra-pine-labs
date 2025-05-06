import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_styles.dart';
import '../../../view_model/booking_viewmodel.dart';

class WeeklyWidget extends StatelessWidget {
  const WeeklyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    return Consumer<BookingViewmodel>(
      builder:
          (context, bookingViewmodel, child) => SizedBox(
        child: Column(
          children: [
            5.kH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Text("Sun", style: styles.blackRegular13),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedWeeklyDay(
                          "Sun",
                        ),
                        onChanged: (v) {
                          bookingViewmodel.switchSelectedWeeklyDay("Sun");
                        },
                        activeColor: kDullPrimaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text("Mon", style: styles.blackRegular13),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedWeeklyDay(
                          "Mon",
                        ),
                        onChanged: (v) {
                          bookingViewmodel.switchSelectedWeeklyDay("Mon");
                        },
                        activeColor: kDullPrimaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text("Tue", style: styles.blackRegular13),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedWeeklyDay(
                          "Tue",
                        ),
                        onChanged: (v) {
                          bookingViewmodel.switchSelectedWeeklyDay("Tue");
                        },
                        activeColor: kDullPrimaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text("Wed", style: styles.blackRegular13),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedWeeklyDay(
                          "Wed",
                        ),
                        onChanged: (v) {
                          bookingViewmodel.switchSelectedWeeklyDay("Wed");
                        },
                        activeColor: kDullPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Text("Thu", style: styles.blackRegular13),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedWeeklyDay(
                          "Thu",
                        ),
                        onChanged: (v) {
                          bookingViewmodel.switchSelectedWeeklyDay("Thu");
                        },
                        activeColor: kDullPrimaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text("Fri", style: styles.blackRegular13),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedWeeklyDay(
                          "Fri",
                        ),
                        onChanged: (v) {
                          bookingViewmodel.switchSelectedWeeklyDay("Fri");
                        },
                        activeColor: kDullPrimaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text("Sat", style: styles.blackRegular13),
                      Checkbox(
                        value: bookingViewmodel.toggleSelectedWeeklyDay(
                          "Sat",
                        ),
                        onChanged: (v) {
                          bookingViewmodel.switchSelectedWeeklyDay("Sat");
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