import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/home_page_widgets/option_selector_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../api_services/api_service.dart';
import '../../../model/api models/get_donation_model.dart';
import '../build_text_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final fromLang = "en";
    return Consumer2<HomePageViewmodel, BookingViewmodel>(
      builder: (context, homepageViewmodel, bookingViewmodel, child) {
        final templeList = bookingViewmodel.templeList;
        final String welcomeText = templeList.isNotEmpty
            ? " ${templeList.last.templeName}"
            : "Welcome";
        return SizedBox(
          width: SizeConfig.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 10,),
              BuildTextWidget(
                text: 'Welcome',
                color: Colors.black,
                size: 24,
                fontWeight: FontWeight.w400,
                maxLines: 2,
                textAlign: TextAlign.center,
                // style: AppStyles().blackRegular22,
                fromLang: fromLang,
              ),
              BuildTextWidget(
                text: welcomeText,
                color: Colors.black,
                size: 22,
                fontWeight: FontWeight.w400,
                maxLines: 2,
                textAlign: TextAlign.center,
                // style: AppStyles().blackRegular18,
                fromLang: fromLang,
              ),
              SizedBox(height: 16,),
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
                      size: 14,
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
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
                    ),
                    onTap: () {
                      homepageViewmodel.preBookingPageNavigate(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 25,),
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
                      size: 14,
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () async {
                      try {
                        print("-------calling API----------");
                        List<Getdonationmodel> donationList =
                        await ApiService().getDonation();
                        print('Received ${donationList.length} items');

                        for (var item in donationList) {
                          print('AcctHeadId: ${item.acctHeadId}');
                          print('AccName: ${item.acctHeadName}');
                          print('-----------------------');
                          print('AccTime: ${item.entryTime}');
                          print('AccStatus: ${item.status}');
                        }

                        homepageViewmodel.donationPageNavigate(context);
                      } catch (e) {
                        print('Error while fetching donations: $e');
                      }
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
                      size: 14,
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      homepageViewmodel.eHundiPageNavigate(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.003),
              SizedBox(
                height: SizeConfig.screenHeight * 0.070,
                child: Image.asset(Assets.icons.astrinsLogo.path),
              ),
            ],
          ),
        );
      },
    );
  }

}

