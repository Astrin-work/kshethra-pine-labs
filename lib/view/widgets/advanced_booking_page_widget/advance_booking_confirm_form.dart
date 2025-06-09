import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view/widgets/advanced_booking_page_widget/rep_check_box_widget.dart';
import 'package:kshethra_mini/view/widgets/advanced_booking_page_widget/weeklywidget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/star_dialodbox_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../model/api models/god_model.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';

class AdvancedBookingConfirmForm extends StatefulWidget {
  final Vazhipadus selectedVazhipaadu;

  const AdvancedBookingConfirmForm({
    super.key,
    required this.selectedVazhipaadu,
  });

  @override
  State<AdvancedBookingConfirmForm> createState() => _AdvancedBookingConfirmFormState();
}

class _AdvancedBookingConfirmFormState extends State<AdvancedBookingConfirmForm> {
  final TextEditingController _nameController = TextEditingController(text: "Anurag mc");
  final TextEditingController _phoneController = TextEditingController(text: "7510431565");
  final TextEditingController _repDaysController = TextEditingController(text: "1");
  final TextEditingController _addressController = TextEditingController(text: "mannam chira (H) vellamunda po");
  final TextEditingController _pinCodeController = TextEditingController(text: "670731");

  final Map<String, double> postalRates = {"Postal": 5.0, "Speed Post": 45.0};

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _repDaysController.dispose();
    _addressController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);

    return Consumer<BookingViewmodel>(
      builder: (context, bookingViewmodel, child) {
        return Padding(
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                25.kH,
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: Validation.phoneValidation,
                  controller: _phoneController,
                  textAlign: TextAlign.center,
                  style: styles.blackRegular15,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: "Phone".tr(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                25.kH,

                /// Star and Date selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        bookingViewmodel.setAdvBookOption("star".tr());
                        showDialog(
                          context: context,
                          builder: (context) => ResponsiveLayout(
                            pinelabDevice: StarDialogBox(),
                            mediumDevice: StarDialogBox(borderRadius: 25, mainAxisSpace: 30, crossAxisSpace: 45),
                            semiMediumDevice: StarDialogBox(borderRadius: 25, mainAxisSpace: 30, crossAxisSpace: 45, axisCount: 3),
                            semiLargeDevice: StarDialogBox(borderRadius: 30, mainAxisSpace: 30, crossAxisSpace: 45, axisCount: 3),
                            largeDevice: StarDialogBox(borderRadius: 35, mainAxisSpace: 30, crossAxisSpace: 45, axisCount: 4),
                          ),
                        );
                      },
                      child: Container(
                        height: 55,
                        width: 125,
                        decoration: BoxDecoration(
                          color: bookingViewmodel.selectedStar.isNotEmpty ? kDullPrimaryColor : kScaffoldColor,
                          border: bookingViewmodel.selectedStar.isEmpty ? Border.all(color: kBlack) : null,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            bookingViewmodel.selectedStar.isNotEmpty ? bookingViewmodel.selectedStar : "Star",
                            style: bookingViewmodel.selectedStar.isNotEmpty ? styles.whiteSemi15 : styles.blackSemi15,
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
                        decoration: BoxDecoration(
                          color: bookingViewmodel.selectedDate.isNotEmpty ? kDullPrimaryColor : kScaffoldColor,
                          border: bookingViewmodel.selectedDate.isEmpty ? Border.all(color: kBlack) : null,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            bookingViewmodel.selectedDate.isNotEmpty ? bookingViewmodel.selectedDate : "Date",
                            style: bookingViewmodel.selectedDate.isNotEmpty ? styles.whiteSemi15 : styles.blackSemi15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                25.kH,

                const RepCheckBoxWidget(),
                if (bookingViewmodel.selectedRepMethod == "Weekly") const WeeklyWidget(),
                25.kH,

                /// Repeat days
                if (bookingViewmodel.selectedRepMethod != "Once")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Number of Days for Repeat".tr(), style: styles.blackRegular15),
                        Text(":", style: styles.blackSemi18),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) => Validation.numberValidation(value, "Count", "Enter valid days"),
                            controller: _repDaysController,
                            onChanged: (value) {
                              bookingViewmodel.bookingRepOnchange(value, widget.selectedVazhipaadu, postalRates, 0.0);
                            },
                            textAlign: TextAlign.center,
                            style: styles.blackRegular15,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                15.kH,

                // /// Prasadam checkbox
                // CheckboxListTile(
                //   contentPadding: EdgeInsets.zero,
                //   title: Text("Prasadam".tr(), style: styles.blackRegular15),
                //   value: bookingViewmodel.prasadamSelected,
                //   onChanged: (value) {
                //     bookingViewmodel.togglePrasadam(value!);
                //     if (!value) {
                //       // Reset postal options and reduce amount
                //       if (bookingViewmodel.postalAmount > 0) {
                //         bookingViewmodel.reducePostalAmountFromTotal();
                //       }
                //       bookingViewmodel.selectPostalOption("");
                //       bookingViewmodel.setPostalAmount(0.0);
                //     }
                //   },
                // ),

                /// Postal options
                if (bookingViewmodel.prasadamSelected)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Postel Option".tr(), style: styles.blackRegular15),
                      20.kH,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: postalRates.keys.map((option) {
                            final isSelected = bookingViewmodel.postalOption == option;
                            return Row(
                              children: [
                                Radio<String>(
                                  value: option,
                                  groupValue: bookingViewmodel.postalOption,
                                  onChanged: (value) {
                                    if (value != null) {
                                      bookingViewmodel.selectPostalOption(value);
                                      // bookingViewmodel.setPostalAmount(postalRates[value] ?? 0.0);
                                    }
                                  },
                                  activeColor: kPrimaryColor,
                                ),
                                Text(option, style: styles.blackRegular15),
                                if (isSelected)
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.grey.shade400),
                                    ),
                                    child: Text("₹${bookingViewmodel.postalAmount.toStringAsFixed(2)}", style: styles.blackRegular13),
                                  ),
                                SizedBox(width: 20),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),

                10.kH,

                /// Address field
                TextFormField(
                  validator: (value) => Validation.emptyValidation(value, "Enter your address"),
                  controller: _addressController,
                  maxLines: 4,
                  style: styles.blackRegular15,
                  decoration: InputDecoration(
                    hintText: "Address".tr(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),

                10.kH,

                /// Pincode
                if (bookingViewmodel.prasadamSelected)
                  TextFormField(
                    validator: (value) => Validation.emptyValidation(value, "Enter your Pincode"),
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    controller: _pinCodeController,
                    maxLines: 1,
                    style: styles.blackRegular15,
                    decoration: InputDecoration(
                      hintText: "Pincode".tr(),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
