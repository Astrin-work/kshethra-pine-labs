import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/float_button_widget.dart';
import 'package:kshethra_mini/view/widgets/build_text_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';
import '../utils/app_color.dart';
import '../utils/app_styles.dart';
import '../utils/components/size_config.dart';

class AdvancedBookingPreviewView extends StatelessWidget {
  final String selectedRepMethod;
  final List<String> selectedDays;
  final int totalAmount;

  const AdvancedBookingPreviewView({
    super.key,
    required this.selectedRepMethod,
    required this.selectedDays,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ResponsiveLayout(
        pinelabDevice: FloatButtonWidget(
          amount: totalAmount,
          title: 'Advanced Booking',
          noOfScreens: 4,
        ),
        mediumDevice: FloatButtonWidget(
          height: 65,
          amount: totalAmount,
          title: 'Advanced Booking',
          noOfScreens: 4,
        ),
        largeDevice: FloatButtonWidget(
          height: 75,
          amount: totalAmount,
          title: 'Advanced Booking',
          noOfScreens: 4,
        ),
      ),
      body: Column(
        children: [
          AppBarWidget(title: "Advanced Booking"),
          AdvPreViewWidget(
            page: 'advanced booking',
            selectedRepMethod: selectedRepMethod,
            selectedDays: selectedDays,
            tottalAmount:totalAmount
          ),
        ],
      ),
    );
  }
}

class AdvPreViewWidget extends StatelessWidget {
  final String page;
  final String selectedRepMethod;
  final List<String> selectedDays;
  final int tottalAmount;

  const AdvPreViewWidget({
    super.key,
    required this.page,
    required this.selectedRepMethod,
    required this.selectedDays,
    required this.tottalAmount,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);

    return Consumer<BookingViewmodel>(
      builder: (context, bookingViewmodel, child) {
        final vazhipaduList = bookingViewmodel.vazhipaduBookingList;

        return SizedBox(
          height: SizeConfig.screenHeight * 0.8,
          width: SizeConfig.screenWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: vazhipaduList.length,
                    itemBuilder: (context, index) {
                      final poojaList = vazhipaduList[index].vazhiPad;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kLightPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                vazhipaduList[index].name.toString(),
                                style: styles.blackRegular15,
                              ),
                              Text(
                                vazhipaduList[index].star.toString(),
                                style: styles.blackRegular15,
                              ),
                              Text(
                                page == "booking"
                                    ? vazhipaduList[index].star ?? ""
                                    : vazhipaduList[index].option ?? "",
                                style: styles.blackRegular13,
                              ),
                              SizedBox(
                                height: 130,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: poojaList.length,
                                    itemBuilder: (context, poojaIndex) {
                                      final item = poojaList[poojaIndex];
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    BuildTextWidget(
                                                      text: item["vazhipadu"].toString().tr(),
                                                      size: 14,
                                                      color: kBlack,
                                                    ),
                                                    BuildTextWidget(
                                                      text: item["godName"].toString().tr(),
                                                      size: 14,
                                                      color: kBlack,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                                Text(
                                                  "₹ ${tottalAmount}",
                                                  style: styles.blackRegular13,
                                                ),
                                              const SizedBox(width: 10),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: kRed,
                                                ),
                                                onPressed: () {
                                                  if (page == "booking") {
                                                    bookingViewmodel.vazhipaduDelete(index, poojaIndex);
                                                  } else {
                                                    bookingViewmodel.advBookingDeleteVazhipadd(index, poojaIndex);
                                                  }
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  bookingViewmodel.popFunction(context);
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              BuildTextWidget(
                                                text: "Repeat Method: $selectedRepMethod",
                                                size: 14,
                                                color: kBlack,
                                              ),
                                              const SizedBox(width: 10),
                                              if (selectedRepMethod != "Once")
                                                Text(
                                                  "${bookingViewmodel.repeatDays} times",
                                                  style: TextStyle(fontSize: 14, color: kBlack),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              BuildTextWidget(
                                                text: "Total Postal Charges: ₹${bookingViewmodel.postalAmount}",
                                                size: 14,
                                                color: kBlack,
                                              ),
                                            ],
                                          ),
                                          if (selectedRepMethod != "Once" && selectedDays.isNotEmpty)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 6),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Wrap(
                                                  spacing: 8.0,
                                                  children: selectedDays
                                                      .map((day) => Chip(
                                                    label: Text(day),
                                                    backgroundColor: kLightPrimaryColor.withOpacity(0.8),
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
