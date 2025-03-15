import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/back_button_component.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.4,
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
            child: BackButtonComponent(),
          ),
          HomeWidget(),
        ],
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<HomePageViewmodel>(
      builder:
          (context, homepageViewmodel, child) => SizedBox(
            height: SizeConfig.screenHeight * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Welcome", style: styles.blackRegular22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OptionSelectorWidget(
                      icon: SizedBox(
                        height: 52,
                        child: Image.asset(Assets.icons.pray.path),
                      ),
                      title: 'BOOKING',
                      onTap: () {
                        homepageViewmodel.bookingPageNavigate(context);
                      },
                    ),
                    OptionSelectorWidget(
                      icon: SizedBox(
                        height: 45,
                        child: Image.asset(Assets.icons.preBooking.path),
                      ),
                      title: 'ADVANCE BOOKING',
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
                      title: 'DONATION',
                      onTap: () {
                        homepageViewmodel.donationPageNavigate(context);
                      },
                    ),
                    OptionSelectorWidget(
                      icon: SizedBox(
                        height: 50,
                        child: Image.asset(Assets.icons.eHundi.path),
                      ),
                      title: 'E-HUNDI',
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

class OptionSelectorWidget extends StatelessWidget {
  final void Function()? onTap;
  final Widget icon;
  final String title;
  const OptionSelectorWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(Assets.images.langBackground.path),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            5.kW,
            Text(
              textAlign: TextAlign.center,
              title,
              style: styles.blackRegular18,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
