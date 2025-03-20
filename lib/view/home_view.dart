import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/back_button_component.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/home_page_widgets/home_widget.dart';
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
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonComponent(),
                  Consumer<HomePageViewmodel>(
                    builder:
                        (context, homePageViewmodel, child) => SizedBox(
                          child: Row(
                            children: [
                              IconButton(
                                iconSize: 30,
                                onPressed: () {
                                  homePageViewmodel.navigateSuperAdminHomeView(
                                    context,
                                  );
                                },
                                icon: Icon(Icons.settings),
                              ),
                              5.kW,
                              IconButton(
                                iconSize: 30,
                                onPressed: () {
                                  homePageViewmodel.showLogoutDialog(context);
                                },
                                icon: Icon(Icons.logout),
                              ),
                            ],
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ),
          HomeWidget(),
        ],
      ),
    );
  }
}
