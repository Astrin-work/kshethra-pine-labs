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
  final int totalAmount;
  final String selectedRepMethod;

  const AdvancedBookingPreviewView({
    super.key,
    required this.totalAmount,
    required this.selectedRepMethod,
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
          // 👇 Pass it here
          AdvPreViewWidget(
            page: 'advanced booking',
            totalAmount: totalAmount,
            selectedRepMethod: selectedRepMethod,
          ),
        ],
      ),
    );
  }
}


class AdvPreViewWidget extends StatelessWidget {
  final String page;
  final int totalAmount;
  final String selectedRepMethod;

  const AdvPreViewWidget({
    super.key,
    required this.page,
    required this.totalAmount,
    required this.selectedRepMethod,
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kLightPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Text(
                                vazhipaduList[index].name,
                                style: styles.blackRegular15,
                              ),
                              Text(
                                page == "booking"
                                    ? vazhipaduList[index].star ?? ""
                                    : vazhipaduList[index].option ?? "",
                                style: styles.blackRegular13,
                              ),
                              Container(
                                color: kWhite,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                  vazhipaduList[index].vazhiPad.length,
                                  itemBuilder: (context, poojaIndex) {
                                    final poojaList =
                                        vazhipaduList[index].vazhiPad;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2.0,
                                        horizontal: 5.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              BuildTextWidget(
                                                text: poojaList[poojaIndex]
                                                ["vazhipadu"]
                                                    .toString()
                                                    .tr(),
                                                size: 14,
                                                color: kBlack,
                                              ),
                                              BuildTextWidget(
                                                text: poojaList[poojaIndex]
                                                ["godName"]
                                                    .toString()
                                                    .tr(),
                                                size: 14,
                                                color: kBlack,
                                              ),

                                            ],
                                          ),
                                          10.kW,
                                          SizedBox(
                                            width: 50,
                                            child: Text(
                                              "₹ ${poojaList[poojaIndex]["tPrize"]}",
                                            ),
                                          ),
                                          IconButton(
                                            color: kRed,
                                            onPressed: () {
                                              if (page == "booking") {
                                                bookingViewmodel.vazhipaduDelete(
                                                  index,
                                                  poojaIndex,
                                                );
                                              } else {
                                                bookingViewmodel.advBookingDeleteVazhipadd(
                                                  index,
                                                  poojaIndex,
                                                );
                                              }
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              bookingViewmodel.popFunction(
                                                context,
                                              );
                                            },
                                          ),
                                          BuildTextWidget(
                                            text: " $selectedRepMethod",
                                            size: 14,
                                            color: kBlack,
                                          ),
                                        ],
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

