import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/payment_complete_screen.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScannerComponent extends StatelessWidget {
  final String amount;
  final int noOfScreen;
  final String title;
  const QrScannerComponent({super.key, required this.amount, required this.noOfScreen, required this.title});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Scaffold(
      body: Consumer<HomePageViewmodel>(
        builder:
            (context, homepageViewmodel, child) => Column(
              children: [
                AppBarWidget(title: title),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.8,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Amount ₹ $amount", style: styles.blackRegular22),
                      Text(
                        "Scan this QR Code to pay",
                        style: styles.blackRegular18,
                      ),
                      QrImageView(
                        size: 300,
                        data: homepageViewmodel.setQrAmount(amount),
                      ),
                      Text("demotemple@okicici", style: styles.blackRegular13),
                      MaterialButton(
                        child: Text("data"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      PaymentCompleteScreen(amount: amount, noOfScreen: noOfScreen,),
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
