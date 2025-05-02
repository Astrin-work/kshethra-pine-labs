import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/donation_page_widgets/donation_form_widget.dart';

class DonationView extends StatelessWidget {
  const DonationView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(title: "Donations".tr()),
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
    );
  }
}




