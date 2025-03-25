import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/star_dialodbox_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

class AdvancedBookingConfirmForm extends StatelessWidget {
  final Map<String, dynamic> selectedVazhipaadu;
  const AdvancedBookingConfirmForm({
    super.key,
    required this.selectedVazhipaadu,
  });

  @override
  Widget build(BuildContext context) {
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
                      validator: Validation.nameValidation,
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
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) => Validation.phoneValidation(value),
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
                          child: Text(
                            "Number of Days for Repeat",
                            style: styles.blackRegular15,
                            textAlign: TextAlign.center,
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
          ),
    );
  }
}
