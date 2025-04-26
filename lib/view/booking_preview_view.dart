import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/float_button_widget.dart';
import 'package:kshethra_mini/view/widgets/build_text_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

import '../view_model/home_page_viewmodel.dart';

class BookingPreviewView extends StatelessWidget {
  final String page;
  const BookingPreviewView({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: ResponsiveLayout(
        pinelabDevice: FloatButtonWidget(title: 'Booking', noOfScreens: 4),
        mediumDevice: FloatButtonWidget(
          title: 'Booking',
          noOfScreens: 4,
          height: 65,
        ),
        largeDevice: FloatButtonWidget(
          title: 'Booking',
          noOfScreens: 4,
          height: 75,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [AppBarWidget(title: "Booking"), PreViewWidget(page: page)],
        ),
      ),
    );
  }
}

class PreViewWidget extends StatelessWidget {
  final String page;
  const PreViewWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<BookingViewmodel>(
      builder: (context, bookingViewmodel, child) {
        final vazhipaduList = bookingViewmodel.vazhipaduBookingList;
        return SizedBox(
          height: SizeConfig.screenHeight * 0.8,
          width: SizeConfig.screenWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: ListView.builder(
              itemCount: vazhipaduList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.0, top: 4.0),
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
                        page == "booking"
                            ? Text(
                              vazhipaduList[index].star ?? "",
                              style: styles.blackRegular13,
                            )
                            : Text(
                              vazhipaduList[index].option ?? "",
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
                                padding: const EdgeInsets.only(
                                  top: 2.0,
                                  bottom: 2,
                                  left: 5,
                                  right: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BuildTextWidget(
                                          text: poojaList[inde]["vazhipadu"],
                                          size: 14,
                                          color: kBlack,
                                          toLang: currentLang,
                                        ),
                                        BuildTextWidget(
                                          text: poojaList[inde]["godName"],
                                          size: 14,
                                          color: kBlack,
                                          toLang: currentLang,
                                        ),
                                        // Text(poojaList[inde]["vazhipadu"]),
                                        // Text(poojaList[inde]["godName"]),
                                      ],
                                    ),
                                    Spacer(),
                                    Text("(${poojaList[inde]["rep"]})"),
                                    25.kW,
                                    SizedBox(
                                      width: 60,
                                      //    color: kGreen,
                                      child: Text(
                                        "₹ ${poojaList[inde]["tPrize"]}",
                                      ),
                                    ),
                                    10.kW,
                                    IconButton(
                                      color: kRed,
                                      onPressed: () {
                                        page == "booking"
                                            ? bookingViewmodel.vazhipaduDelete(
                                              index,
                                              inde,
                                            )
                                            : bookingViewmodel
                                                .advBookingDeleteVazhipadd(
                                                  index,
                                                  inde,
                                                );
                                      },
                                      icon: Icon(Icons.delete),
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
        );
      },
    );
  }
}
