import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/back_button_component.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/payment_complete_screen.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPaymentView extends StatelessWidget {
  const QrPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Scaffold(
      body: Consumer<HomePageViewmodel>(
        builder:
            (context, homepageViewmodel, child) => Column(
              children: [
                Container(
                  height: SizeConfig.screenHeight * 0.2,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    image: DecorationImage(
                      image: AssetImage(Assets.images.homeBackground.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      BackButtonComponent(),
                      Text("Donation", style: styles.whiteRegular20),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.7,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Amount : ₹ ${homepageViewmodel.donationAmountController.text}",
                        style: styles.blackRegular22,
                      ),
                      Text(
                        "Scan this QR Code to Pay",
                        style: styles.blackRegular18,
                      ),
                      SizedBox(
                        child: QrImageView(
                          data: homepageViewmodel.donationAmount,
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
                ),
              ],
            ),
      ),
    );
  }
}
