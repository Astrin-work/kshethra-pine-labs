import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class SuperAdminHomeView extends StatelessWidget {
  const SuperAdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(title: "Super Admin Page"),
          35.kH,
          ResponsiveLayout(
            pinelabDevice: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: SuperAdminWidget(),
            ),
            mediumDevice: Padding(
              padding: const EdgeInsets.only(left: 45.0, right: 45),
              child: SuperAdminWidget(),
            ),
            largeDevice: Padding(
              padding: const EdgeInsets.only(left: 65, right: 65),
              child: SuperAdminWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class SuperAdminWidget extends StatelessWidget {
  const SuperAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      child: Consumer<HomePageViewmodel>(
        builder:
            (context, homepageViewmodel, child) => Column(
              children: [
                OptionBoxWidget(
                  title: 'Add Temple',
                  onTap: () {
                    homepageViewmodel.navigateSuperAdminAddTempleView(
                      context,
                    );
                  },
                ),
                20.kH,
                OptionBoxWidget(
                  title: 'Add Prathishtta',
                  onTap: () {
                    homepageViewmodel.navigateSuperAdminAddPrathisttaView(
                      context,
                    );
                  },
                ),
                20.kH,
                OptionBoxWidget(
                  title: 'Add VazhiPaddu',
                  onTap: () {
                    homepageViewmodel.navigateSuperAdminAddVazhipadduView(
                      context,
                    );
                  },
                ),
                20.kH,
                OptionBoxWidget(
                  title: 'Add Donation',
                  onTap: () {
                    homepageViewmodel.navigateSuperAdminAddDonationView(
                      context,
                    );
                  },
                ),
              ],
            ),
      ),
    );
  }
}

class OptionBoxWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const OptionBoxWidget({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppStyles styles = AppStyles();
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kScaffoldColor,
          boxShadow: [
            BoxShadow(
              color: kGrey9,
              offset: Offset(0, 4),
              blurRadius: 3,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(child: Text(title, style: styles.blackRegular18)),
      ),
    );
  }
}
