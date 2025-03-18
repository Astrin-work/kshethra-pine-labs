import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/qr_code_component.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/payment_complete_screen.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingPreviewView extends StatelessWidget {
  const BookingPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatButtonWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [AppBarWidget(title: "Booking"), PreViewWidget()],
        ),
      ),
    );
  }
}

class PreViewWidget extends StatelessWidget {
  const PreViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<HomePageViewmodel>(
      builder: (context, homepageViewmodel, child) {
        final vazhipaduList = homepageViewmodel.vazhipaduBookingList;
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
                        Text(
                          vazhipaduList[index].star,
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
                                        Text(poojaList[inde]["vazhipadu"]),
                                        Text(poojaList[inde]["godName"]),
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
                                        homepageViewmodel.vazhipaduDelete(
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

class FloatButtonWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const FloatButtonWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<HomePageViewmodel>(
      builder:
          (context, homepageViewmodel, child) => Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    //  homepageViewmodel.navigateBookingPreviewView(context);
                  },
                  child: Container(
                    height: height ?? SizeConfig.screenWidth * 0.135,
                    width: width ?? SizeConfig.screenWidth * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(Assets.images.homeBackground.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "₹ ${homepageViewmodel.totalVazhipaduAmt}",
                        style: styles.whiteRegular20,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    homepageViewmodel.qrBooking(context);
                  },
                  child: Container(
                    height: height ?? SizeConfig.screenWidth * 0.135,
                    width: width ?? SizeConfig.screenWidth * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(Assets.images.homeBackground.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kWhite,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: kDullPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class QrCodeComponentt extends StatelessWidget {
  final String amount;
  final String paymentLink;
  const QrCodeComponentt({
    super.key,
    required this.amount,
    required this.paymentLink,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return SizedBox(
      height: SizeConfig.screenHeight * 0.7,
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Amount : ₹ $amount", style: styles.blackRegular22),
          Text("Scan this QR Code to Pay", style: styles.blackRegular18),
          SizedBox(
            child: QrImageView(
              data: paymentLink,
              version: QrVersions.auto,
              size: 300.0,
            ),
          ),
          Text("demotemple@okicici", style: styles.blackRegular13),
          MaterialButton(
            child: Text("data"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentCompleteScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
