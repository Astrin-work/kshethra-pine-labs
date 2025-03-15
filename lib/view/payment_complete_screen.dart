import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PaymentCompleteScreen extends StatelessWidget {
  const PaymentCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Scaffold(
      body: Consumer<HomePageViewmodel>(
        builder:
            (context, homepageViewmodel, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Amount : ₹ ${homepageViewmodel.donationAmountController.text}",
                  style: styles.blackRegular22,
                ),
                Lottie.asset(Assets.gifs.paymentSuccess),
                Text(
                  "Your payment was sucessfull",
                  style: styles.blackRegular18,
                ),
                Text("Thank You !", style: styles.primBold22),
                25.kH,
                MaterialButton(
                  onPressed: () {
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomeView()),
                    //   (Route<dynamic> route) => false,
                    // );
                    homepageViewmodel.backtoHomePage(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minWidth: SizeConfig.screenWidth * .05,
                  color: kPrimaryColor,
                  child: Text("Back to Home", style: styles.blackRegular15),
                ),
              ],
            ),
      ),
    );
  }
}
