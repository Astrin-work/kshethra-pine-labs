import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view/widgets/build_text_widget.dart';
import 'package:kshethra_mini/view_model/donation_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../view_model/home_page_viewmodel.dart';

class DonationDialogWidget extends StatelessWidget {
  const DonationDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return AlertDialog(
      title: Consumer<DonationViewmodel>(
        builder:
            (context, donationViewmodel, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuildTextWidget(
                  text: "Enter the amount to Donate",
                  textAlign: TextAlign.center,
                  size: 20,
                  color: kBlack,
                  toLang: currentLang,
                ),
                // Text(
                //   textAlign: TextAlign.center,
                //   "Enter the amount to Donate",
                //   style: styles.blackRegular18,
                // ),
                10.kH,
                Form(
                  key: donationViewmodel.donationKey,
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    validator:
                        (value) => Validation.numberValidation(
                          value,
                          "Enter a amount",
                          "Invalid amount",
                        ),
                    controller: donationViewmodel.donationAmountController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: donationViewmodel.clearDonationAmount,
                        icon: Icon(Icons.close),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                10.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        donationViewmodel.navigateScannerPage(context);
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: kDullPrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:BuildTextWidget(
                        text: "pay",
                        color: kBlack,
                        toLang: currentLang,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        donationViewmodel.popFunction(context);
                        donationViewmodel.clearDonationAmount();
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: kDullPrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:BuildTextWidget(
                        text: "Cancel",
                        color: kBlack,
                        toLang: currentLang,
                      ),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
