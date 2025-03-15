import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/donation_model.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/back_button_component.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class DonationView extends StatelessWidget {
  const DonationView({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          child: Column(
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
              ResponsiveLayout(
                pinelabDevice: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: DonationFormWidget(
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 35,
                  ),
                ),
                mediumDevice: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.1,
                    right: SizeConfig.screenWidth * 0.1,
                  ),
                  child: DonationFormWidget(
                    crossAxisSpacing: SizeConfig.screenWidth * 0.25,
                    mainAxisSpacing: 25,
                  ),
                ),
                largeDevice: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.1,
                    right: SizeConfig.screenWidth * 0.1,
                  ),
                  child: DonationFormWidget(
                    crossAxisCount: 3,
                    crossAxisSpacing: SizeConfig.screenWidth * 0.15,
                    mainAxisSpacing: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    return Consumer<HomePageViewmodel>(
      builder:
          (context, homepageViewmodel, child) => SizedBox(
            height: SizeConfig.screenHeight * 0.8,
            child: Column(
              children: [
                25.kH,
                TextField(
                  style: styles.blackRegular15,
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                25.kH,
                TextField(
                  style: styles.blackRegular15,
                  decoration: InputDecoration(
                    hintText: "Phno",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                25.kH,
                Expanded(
                  child: GridView.builder(
                    itemCount: donations.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: mainAxisSpacing,
                      crossAxisSpacing: crossAxisSpacing,
                      crossAxisCount: crossAxisCount ?? 2,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          homepageViewmodel.showDonationDialog(context);
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
                ),
              ],
            ),
          ),
    );
  }
}

class DonationDialogWidget extends StatelessWidget {
  const DonationDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return AlertDialog(
      title: Consumer<HomePageViewmodel>(
        builder:
            (context, homepageViewmodel, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Enter the amount to Donate",
                  style: styles.blackRegular18,
                ),
                10.kH,
                TextField(
                  controller: homepageViewmodel.donationAmountController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: homepageViewmodel.clearDonationAmount,
                      icon: Icon(Icons.close),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                10.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        homepageViewmodel.navigateQrPayment(context);
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: kDullPrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("Pay"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        homepageViewmodel.popFunction(context);
                        homepageViewmodel.clearDonationAmount();
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: kDullPrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
