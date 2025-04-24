import 'package:flutter/cupertino.dart';

import '../../../utils/app_styles.dart';
import '../../../utils/components/size_config.dart';
import '../../language_select_view.dart';
import 'lang_widget.dart';

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