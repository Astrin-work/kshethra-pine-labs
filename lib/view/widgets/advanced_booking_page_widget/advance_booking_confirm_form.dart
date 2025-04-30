import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/star_dialodbox_widget.dart';
import 'package:kshethra_mini/view/widgets/build_text_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../view_model/home_page_viewmodel.dart';

class AdvancedBookingConfirmForm extends StatelessWidget {
  final Map<String, dynamic> selectedVazhipaadu;
  const AdvancedBookingConfirmForm({
    super.key,
    required this.selectedVazhipaadu,
  });

  @override
  Widget build(BuildContext context) {
    final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<BookingViewmodel>(
      builder:
          (context, bookingViewmodel, child) => SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
              child: Form(
                key: bookingViewmodel.advBookingKey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      validator: Validation.nameValidation,
                      controller: bookingViewmodel.bookingNameController,
                      textAlign: TextAlign.center,
                      style: styles.blackRegular15,
                      decoration: InputDecoration(
                        hintText: "Name".tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    25.kH,
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) => Validation.phoneValidation(value),
                      controller: bookingViewmodel.bookingPhnoController,
                      textAlign: TextAlign.center,
                      style: styles.blackRegular15,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: "Phone".tr(),
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
                            bookingViewmodel.setAdvBookOption("star".tr());
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
                            height: 55,
                            width: 125,
                            decoration:
                                bookingViewmodel.advBookOption == "star"
                                    ? BoxDecoration(
                                      color: kDullPrimaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                    )
                                    : BoxDecoration(
                                      color: kScaffoldColor,
                                      border: Border.all(
                                        color: kBlack,
                                        width: 1,
                                      ),
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
                            height: 55,
                            width: 125,
                            decoration:
                                bookingViewmodel.advBookOption == "date"
                                    ? BoxDecoration(
                                      color: kDullPrimaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                    )
                                    : BoxDecoration(
                                      color: kScaffoldColor,
                                      border: Border.all(
                                        color: kBlack,
                                        width: 1,
                                      ),
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
                    RepCheckBoxWidget(),
                    Visibility(
                      visible: bookingViewmodel.selectedRepMethod == "Weekly",
                      child: WeeklyWidget(),
                    ),
                    25.kH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BuildTextWidget(
                                text: 'Number of Days for Repeat'.tr(),
                                size: 16,
                                color: kBlack,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),

                              // BuildTextWidget(
                              //   text: 'for Repeat',
                              //   size: 16,
                              //   color: kBlack,
                              //   textAlign: TextAlign.center,
                              //   toLang: currentLang,
                              // ),
                            ],
                          ),
                        ),
                        Text(":", style: styles.blackSemi18),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator:
                                (value) => Validation.numberValidation(
                                  value,
                                  "Enter days",
                                  "Enter valid days",
                                ),
                            controller: bookingViewmodel.bookingRepController,
                            onChanged: (value) {
                              bookingViewmodel.bookingRepOnchange(
                                value,
                                selectedVazhipaadu,
                              );
                            },
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
                    TextFormField(
                      validator:
                          (value) => Validation.emptyValidation(
                            value,
                            "Enter your address",
                          ),
                      controller: bookingViewmodel.bookingAddressController,
                      maxLines: 4,
                      style: styles.blackRegular15,
                      decoration: InputDecoration(
                        hintText: "Address".tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

class WeeklyWidget extends StatelessWidget {
  const WeeklyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;
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
                          // BuildTextWidget(text: "Sun",size: 13,color:kBlack,),
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

class RepCheckBoxWidget extends StatelessWidget {
  const RepCheckBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;
    AppStyles styles = AppStyles();
    return Consumer<BookingViewmodel>(
      builder:
          (context, bookingViewmodel, child) => SizedBox(
            // color: kGreen,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            BuildTextWidget(
                              text: 'Once',
                              color: kBlack,
                              size: 14,
                              toLang: currentLang,
                            ),
                            // Text("Once", style: styles.blackRegular15),
                            Checkbox(
                              value: bookingViewmodel.toggleSelectedRepMethod(
                                "Once".tr(),
                              ),
                              onChanged: (value) {
                                bookingViewmodel.switchSelectedRepMethod(
                                  "Once",
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
                                "Weekly",
                              ),
                              onChanged: (value) {
                                bookingViewmodel.switchSelectedRepMethod(
                                  "Weekly",
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
                            BuildTextWidget(
                              text: 'Daily',
                              color: kBlack,
                              size: 14,
                              toLang: currentLang,
                            ),
                            // Text("Daily", style: styles.blackRegular15),
                            Checkbox(
                              value: bookingViewmodel.toggleSelectedRepMethod(
                                "Daily",
                              ),
                              onChanged: (value) {
                                bookingViewmodel.switchSelectedRepMethod(
                                  "Daily",
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
                                "Monthly",
                              ),
                              onChanged: (value) {
                                bookingViewmodel.switchSelectedRepMethod(
                                  "Monthly",
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
          ),
    );
  }
}
