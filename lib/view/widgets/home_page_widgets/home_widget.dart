import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/home_page_widgets/option_selector_widget.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<HomePageViewmodel>(
      builder: (context, homepageViewmodel, child) => SizedBox(
        height: SizeConfig.screenHeight * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("welcome".tr(), style: styles.blackRegular22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OptionSelectorWidget(
                  icon: SizedBox(
                    height: 52,
                    child: Image.asset(Assets.icons.pray.path),
                  ),
                  title: 'booking'.tr(),
                  onTap: () {
                    homepageViewmodel.bookingPageNavigate(context);
                  },
                ),
                OptionSelectorWidget(
                  icon: SizedBox(
                    height: 45,
                    child: Image.asset(Assets.icons.preBooking.path),
                  ),
                  title: 'advance_booking'.tr(),
                  onTap: () {
                    homepageViewmodel.preBookingPageNavigate(context);
                  },
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OptionSelectorWidget(
                  icon: SizedBox(
                    height: 50,
                    child: Image.asset(Assets.icons.donation.path),
                  ),
                  title: 'donation'.tr(),
                  onTap: () {
                    homepageViewmodel.donationPageNavigate(context);
                  },
                ),
                OptionSelectorWidget(
                  icon: SizedBox(
                    height: 50,
                    child: Image.asset(Assets.icons.eHundi.path),
                  ),
                  title: 'e_hundi'.tr(),
                  onTap: () {
                    homepageViewmodel.eHundiPageNavigate(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
