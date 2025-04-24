import 'package:flutter/cupertino.dart';

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