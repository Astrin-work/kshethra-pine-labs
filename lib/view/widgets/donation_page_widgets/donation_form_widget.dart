import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/donation_model.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view_model/donation_viewmodel.dart';
import 'package:provider/provider.dart';

class DonationFormWidget extends StatelessWidget {
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final int? crossAxisCount;
  const DonationFormWidget({
    super.key,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<DonationViewmodel>(
      builder:
          (context, donationViewmodel, child) => SizedBox(
            // height: SizeConfig.screenHeight * 0.8,
            child: Form(
              key: donationViewmodel.donationFormKey,
              child: Column(
                children: [
                  25.kH,
                  TextFormField(
                    autofocus: true,
                    validator: Validation.nameValidation,
                    controller: donationViewmodel.donationNameController,
                    textAlign: TextAlign.center,
                    style: styles.blackRegular15,
                    decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  25.kH,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: Validation.phoneValidation,
                    controller: donationViewmodel.donationPhnoController,
                    textAlign: TextAlign.center,
                    style: styles.blackRegular15,
                    decoration: InputDecoration(
                      hintText: "Phno",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  25.kH,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: donations.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: mainAxisSpacing,
                      crossAxisSpacing: crossAxisSpacing,
                      crossAxisCount: crossAxisCount ?? 2,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          donationViewmodel.showDonationDialog(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(
                                Assets.images.homeBackground.path,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: kWhite,
                              ),

                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    donations[index].donat ?? '',
                                    style: styles.blackRegular15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  15.kH,
                ],
              ),
            ),
          ),
    );
  }
}
