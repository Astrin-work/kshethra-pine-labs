import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/api%20models/god_model.dart';
import 'package:kshethra_mini/model/api%20models/vazhipadu_model.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/home_page_widgets/option_selector_widget.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../api_services/api_service.dart';

import '../build_text_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // AppStyles styles = AppStyles();
    SizeConfig().init(context);

    // final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;


    return Consumer<HomePageViewmodel>(
      builder: (context, homepageViewmodel, child) => SizedBox(
        height: SizeConfig.screenHeight * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BuildTextWidget(
              text: "Welcome".tr(),
              color: Colors.black,
              size: 20,
              fontWeight: FontWeight.w500,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OptionSelectorWidget(
                  icon: SizedBox(
                    height: 52,
                    child: Image.asset(Assets.icons.pray.path),
                  ),
                  titleWidget: BuildTextWidget(
                    text: 'Vazhipaddu Booking'.tr(),
                    color: Colors.black,
                    size: 16,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    // toLang: currentLang,
                  ),
                  onTap: () async {
                    try {
                      print("-------calling API----------");
                      List<Godmodel> vazhipaduList = await ApiService().getDevatha();

                      print('Received ${vazhipaduList.length} items');

                      for (var item in vazhipaduList) {
                        print('DevathaId: ${item.devathaId}');
                        print('DevathaName: ${item.devathaName}');
                        print('DevathaCost: ${item.vazhipadus[0].offerId}');
                        print('offerName: ${item.vazhipadus[0].offerName}');
                        print('Cost: ${item.vazhipadus[0].cost}');

                        print('-----------------------');
                      }
                    } catch (e) {
                      print('Error fetching devatha: $e');
                    }
                    homepageViewmodel.bookingPageNavigate(context);
                  },

                ),
                OptionSelectorWidget(
                  icon: SizedBox(
                    height: 45,
                    child: Image.asset(Assets.icons.preBooking.path),
                  ),
                  titleWidget: BuildTextWidget(
                    text: 'Advance Booking'.tr(),
                    color: Colors.black,
                    size: 16,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    // toLang: currentLang,
                  ),
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
                  titleWidget: BuildTextWidget(
                    text: 'Donations'.tr(),
                    color: Colors.black,
                    size: 16,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    // toLang: currentLang,
                  ),
                  onTap: () {
                    homepageViewmodel.donationPageNavigate(context);
                  },
                ),
                OptionSelectorWidget(
                  icon: SizedBox(
                    height: 50,
                    child: Image.asset(Assets.icons.eHundi.path),
                  ),
                  titleWidget: BuildTextWidget(
                    text: 'E- Bhandaram'.tr(),
                    color: Colors.black,
                    size: 16,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    // toLang: currentLang,
                  ),
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
