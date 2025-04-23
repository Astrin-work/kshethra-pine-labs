import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/e_hundi_model.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class SuperAdminGodListView extends StatelessWidget {
  const SuperAdminGodListView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ResponsiveLayout(
        pinelabDevice: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20,
            top: 15,
            bottom: 15,
          ),
          child: GodLIstWidget(),
        ),
        mediumDevice: Padding(
          padding: EdgeInsets.only(
            top: 35,
            bottom: 35,
            left: SizeConfig.screenWidth * 0.15,
            right: SizeConfig.screenWidth * 0.15,
          ),
          child: GodLIstWidget(
            mainAxisSpacing: SizeConfig.screenWidth * 0.05,
            crossAxisSpacing: SizeConfig.screenWidth * 0.05,
          ),
        ),
        largeDevice: Padding(
          padding: EdgeInsets.only(
            top: 45,
            bottom: 45,
            left: SizeConfig.screenWidth * 0.25,
            right: SizeConfig.screenWidth * 0.25,
          ),
          child: GodLIstWidget(
            mainAxisSpacing: SizeConfig.screenWidth * 0.05,
            crossAxisSpacing: SizeConfig.screenWidth * 0.05,
            crossAxisCount: 3,
          ),
        ),
      ),
    );
  }
}

class GodLIstWidget extends StatelessWidget {
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final int? crossAxisCount;

  const GodLIstWidget({
    super.key,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: mainAxisSpacing ?? 25,
        crossAxisSpacing: crossAxisSpacing ?? 30,
        crossAxisCount: crossAxisCount ?? 2,
      ),
      itemCount: hundiList.length,
      itemBuilder: (context, index) {
        return Consumer<HomePageViewmodel>(
          builder:
              (context, homepageViewmodel, child) => InkWell(
                onTap: () {
                  homepageViewmodel.stringImageToUint(hundiList[index].godImg!);
                  homepageViewmodel.popFunction(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(hundiList[index].godImg!),
                    ),
                  ),
                ),
              ),
        );
      },
    );
  }
}
