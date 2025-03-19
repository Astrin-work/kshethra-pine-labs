import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
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
    return Scaffold(
      body: Consumer<BookingViewmodel>(
        builder:
            (context, bookingViewmodel, child) => SingleChildScrollView(
              child: Column(
                children: [
                  AppBarWidget(title: selectedVazhipaadu["vazhi"]),
                  AdvancedBookingConfirmForm(),
                ],
              ),
            ),
      ),
    );
  }
}

class AdvancedBookingConfirmForm extends StatelessWidget {
  const AdvancedBookingConfirmForm({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<BookingViewmodel>(
      builder:
          (context, bookingViewmodel, child) => SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
              child: Column(
                children: [
                  TextField(
                    controller: bookingViewmodel.bookingNameController,
                    textAlign: TextAlign.center,
                    style: styles.blackRegular15,
                    decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  25.kH,
                  TextField(
                    controller: bookingViewmodel.bookingPhnoController,
                    textAlign: TextAlign.center,
                    style: styles.blackRegular15,
                    decoration: InputDecoration(
                      hintText: "Phno",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  25.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          bookingViewmodel.setAdvBookOption("star");
                          showDialog(
                            context: context,
                            builder:
                                (context) => ResponsiveLayout(
                                  pinelabDevice: StarDialogBox(),
                                  mediumDevice: StarDialogBox(
                                    borderRadius: 25,
                                    mainAxisSpace: 30,
                                    crossAxisSpace: 45,
                                  ),
                                  semiMediumDevice: StarDialogBox(
                                    borderRadius: 25,
                                    mainAxisSpace: 30,
                                    crossAxisSpace: 45,
                                    axisCount: 3,
                                  ),
                                  semiLargeDevice: StarDialogBox(
                                    borderRadius: 30,
                                    mainAxisSpace: 30,
                                    crossAxisSpace: 45,
                                    axisCount: 3,
                                  ),
                                  largeDevice: StarDialogBox(
                                    borderRadius: 35,
                                    mainAxisSpace: 30,
                                    crossAxisSpace: 45,
                                    axisCount: 4,
                                  ),
                                ),
                          );
                        },
                        child: Container(
                          height: 125,
                          width: 125,
                          decoration:
                              bookingViewmodel.advBookOption == "star"
                                  ? BoxDecoration(
                                    color: kDullPrimaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  )
                                  : BoxDecoration(
                                    color: kScaffoldColor,
                                    border: Border.all(color: kBlack, width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                          child: Center(
                            child: Text(
                              bookingViewmodel.selectedStar,
                              style:
                                  bookingViewmodel.advBookOption == "star"
                                      ? styles.whiteSemi15
                                      : styles.blackSemi15,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          bookingViewmodel.setAdvBookOption("date");
                          bookingViewmodel.selectBookingDate(context);
                        },
                        child: Container(
                          height: 125,
                          width: 125,
                          decoration:
                              bookingViewmodel.advBookOption == "date"
                                  ? BoxDecoration(
                                    color: kDullPrimaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  )
                                  : BoxDecoration(
                                    color: kScaffoldColor,
                                    border: Border.all(color: kBlack, width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                          child: Center(
                            child: Text(
                              bookingViewmodel.selectedDate,
                              style:
                                  bookingViewmodel.advBookOption == "date"
                                      ? styles.whiteSemi15
                                      : styles.blackSemi15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  25.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.4,
                        child: Text(
                          "Number of Days for Repeat",
                          style: styles.blackRegular15,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(":", style: styles.blackSemi18),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.3,
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: styles.blackRegular15,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  25.kH,
                  TextField(
                    maxLines: 4,
                    style: styles.blackRegular15,
                    decoration: InputDecoration(
                      hintText: "Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
