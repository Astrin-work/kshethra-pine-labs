import 'package:flutter/cupertino.dart';
import 'package:kshethra_mini/view/widgets/laguage_select_widgets/small_device_widget.dart';

import '../../../utils/components/responsive_layout.dart';
import '../../../utils/components/size_config.dart';
import 'large_device_widget.dart';

class LanguageBox extends StatelessWidget {
  const LanguageBox({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      height: SizeConfig.screenHeight * 0.6,
      child: ResponsiveLayout(
        pinelabDevice: SmallDeviceWidget(),
        mediumDevice: LargeDeviceWidget(),
        largeDevice: LargeDeviceWidget(),
      ),
    );
  }
}