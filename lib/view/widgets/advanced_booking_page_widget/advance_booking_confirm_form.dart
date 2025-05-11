import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view/widgets/advanced_booking_page_widget/rep_check_box_widget.dart';
import 'package:kshethra_mini/view/widgets/advanced_booking_page_widget/weeklywidget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/star_dialodbox_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

class AdvancedBookingConfirmForm extends StatefulWidget {
  final Map<String, dynamic> selectedVazhipaadu;

  const AdvancedBookingConfirmForm({
    super.key,
    required this.selectedVazhipaadu,
  });

  @override
  State<AdvancedBookingConfirmForm> createState() =>
      _AdvancedBookingConfirmFormState();
}

class _AdvancedBookingConfirmFormState
    extends State<AdvancedBookingConfirmForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _repDaysController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _repDaysController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);

    return Consumer<BookingViewmodel>(
      builder:
          (context, bookingViewmodel, child) => Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: bookingViewmodel.advBookingKey,
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    validator: Validation.nameValidation,
                    controller: _nameController,
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
                    controller: _phoneController,
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
                                    border: Border.all(color: kBlack, width: 1),
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
                          bookingViewmodel.setAdvBookOption("date".tr());
                          bookingViewmodel.selectBookingDate(context);
                        },
                        child: Container(
                          height: 55,
                          width: 125,
                          decoration:
                              bookingViewmodel.advBookOption == "date".tr()
                                  ? BoxDecoration(
                                    color: kDullPrimaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  )
                                  : BoxDecoration(
                                    color: kScaffoldColor,
                                    border: Border.all(color: kBlack, width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                          child: Center(
                            child: Text(
                              bookingViewmodel.selectedDate,
                              style:
                                  bookingViewmodel.advBookOption == "date".tr()
                                      ? styles.whiteSemi15
                                      : styles.blackSemi15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  25.kH,
                  const RepCheckBoxWidget(),
                  Visibility(
                    visible: bookingViewmodel.selectedRepMethod == "Weekly",
                    child: const WeeklyWidget(),
                  ),
                  25.kH,
                  // if (bookingViewmodel.selectedRepMethod != "Once")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Number of Days for Repeat".tr(),
                          style: styles.blackRegular15,
                          textAlign: TextAlign.center,
                        ),
                        Text(":", style: styles.blackSemi18),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) => Validation.numberValidation(
                              value,
                              "Count",
                              "Enter valid days",
                            ),
                            controller: _repDaysController,
                            onChanged: (value) {
                              bookingViewmodel.bookingRepOnchange(value, widget.selectedVazhipaadu);
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
                    controller: _addressController,
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
    );
  }
}
