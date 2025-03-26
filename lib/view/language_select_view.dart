import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class LanguageSelectView extends StatelessWidget {
  const LanguageSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Consumer<HomePageViewmodel>(
        builder:
            (context, homepageViewmodel, child) => Column(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    image: DecorationImage(
                      image: AssetImage(Assets.images.lordSivaBgWithLogo.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                LanguageBox(),
              ],
            ),
      ),
    );
  }
}

class LanguageBox extends StatelessWidget {
  const LanguageBox({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      //width: SizeConfig.screenWidth*.5,
      height: SizeConfig.screenHeight * 0.6,
      child: ResponsiveLayout(
        pinelabDevice: SmallDeviceWidget(),
        mediumDevice: LargeDeviceWidget(),
        largeDevice: LargeDeviceWidget(),
      ),
    );
  }
}

class SmallDeviceWidget extends StatelessWidget {
  const SmallDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Select your language", style: styles.blackRegular22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LangWidget(lang: "ആ", disc: "മലയാളം"),
            20.kW,
            LangWidget(lang: "EN", disc: "English"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LangWidget(lang: "ஆ", disc: "தமிழ்"),
            20.kW,
            LangWidget(lang: "ಆ", disc: "ಕನ್ನಡ"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LangWidget(lang: "ఆ", disc: "తెలుగు"),
            20.kW,
            LangWidget(lang: "आ", disc: "हिंदी"),
          ],
        ),
      ],
    );
  }
}

class LargeDeviceWidget extends StatelessWidget {
  const LargeDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //  20.kH,
        Text("Select your language", style: styles.blackRegular22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LangWidget(lang: "EN", disc: "English"),

            LangWidget(lang: "മ", disc: "മലയാളം"),

            LangWidget(lang: "ஆ", disc: "தமிழ்"),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LangWidget(lang: "ಆ", disc: "ಕನ್ನಡ"),

            LangWidget(lang: "ఆ", disc: "తెలుగు"),

            LangWidget(lang: "आ", disc: "हिंदी"),
          ],
        ),
      ],
    );
  }
}

class LangWidget extends StatelessWidget {
  final String lang;
  final String disc;
  const LangWidget({super.key, required this.lang, required this.disc});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<HomePageViewmodel>(
      builder:
          (context, homepageViewmodel, child) => InkWell(
            onTap: () {
              homepageViewmodel.homePageNavigate(context);
            },
            child: Container(
              height: 80,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.langBackground.path),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(lang, style: styles.blackRegular22),
                  Text(disc, style: styles.blackRegular18),
                ],
              ),
            ),
          ),
    );
  }
}
