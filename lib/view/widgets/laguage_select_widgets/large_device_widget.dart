import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For Locale
import '../../../utils/app_styles.dart';
import '../../../utils/components/size_config.dart';
import 'lang_widget.dart';

class LargeDeviceWidget extends StatelessWidget {
  const LargeDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Select your language", style: styles.blackRegular22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LangWidget(lang: "EN", disc: "English", locale: Locale('en')),
            LangWidget(lang: "മ", disc: "മലയാളം", locale: Locale('ml')),
            LangWidget(lang: "ஆ", disc: "தமிழ்", locale: Locale('ta')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LangWidget(lang: "ಆ", disc: "ಕನ್ನಡ", locale: Locale('kn')),
            LangWidget(lang: "ఆ", disc: "తెలుగు", locale: Locale('te')),
            LangWidget(lang: "आ", disc: "हिंदी", locale: Locale('hi')),
          ],
        ),
      ],
    );
  }
}
