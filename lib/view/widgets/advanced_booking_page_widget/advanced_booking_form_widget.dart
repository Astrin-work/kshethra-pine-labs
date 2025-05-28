import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/god_widget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/vazhipaddu_widget.dart';

class AdvancedBookingFormWidget extends StatelessWidget {
  final double? crossAxisSpace;
  final double? mainAxisSpace;
  final int? crossAixisCount;

  const AdvancedBookingFormWidget({
    super.key,
    this.crossAxisSpace,
    this.mainAxisSpace,
    this.crossAixisCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          20.kH,
          // GodWidget(),
          20.kH,
          Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15,
              bottom: 10,
              // bottom: SizeConfig.screenWidth * 0.2,
            ),
            child: VazhipadduWidget(
              crossAixisCount: crossAixisCount,
              crossAxisSpace: crossAxisSpace,
              mainAxisSpace: mainAxisSpace,
              screeName: 'advancedBookingPage',
            ),
          ),
        ],
      ),
    );
  }
}
