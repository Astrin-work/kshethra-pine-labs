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

  const AdvancedBookingPreviewView({super.key, required this.totalAmount});

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
          AdvPreViewWidget(page: 'advanced booking', totalAmount: totalAmount),
        ],
      ),
    );
  }
}

class AdvPreViewWidget extends StatelessWidget {
  final String page;
  final int totalAmount;

  const AdvPreViewWidget({
    super.key,
    required this.page,
    required this.totalAmount,
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
                                  itemCount: vazhipaduList[index].vazhiPad.length,
                                  itemBuilder: (context, inde) {
                                    final poojaList = vazhipaduList[index].vazhiPad;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              BuildTextWidget(
                                                text: poojaList[inde]["vazhipadu"].toString().tr(),
                                                size: 14,
                                                color: kBlack,
                                              ),
                                              BuildTextWidget(
                                                text: poojaList[inde]["godName"].toString().tr(),
                                                size: 14,
                                                color: kBlack,
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            "(${bookingViewmodel.noOfBookingVazhipaddu} Day${bookingViewmodel.noOfBookingVazhipaddu == 1 ? '' : 's'})",
                                            style: styles.blackRegular13,

                                          ),
                                          25.kW,
                                          Text(
                                            "${"*"}",
                                            style: styles.blackRegular15,

                                          ),
                                          25.kW,
                                          SizedBox(
                                            width: 60,
                                            child: Text("₹ ${poojaList[inde]["tPrize"]}"),
                                          ),
                                          10.kW,
                                          IconButton(
                                            color: kRed,
                                            onPressed: () {
                                              if (page == "booking") {
                                                bookingViewmodel.vazhipaduDelete(index, inde);
                                              } else {
                                                bookingViewmodel.advBookingDeleteVazhipadd(index, inde);
                                              }
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              bookingViewmodel.popFunction(context);
                                            },
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

