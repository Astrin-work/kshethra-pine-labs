import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/god_widget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/vazhipaddu_widget.dart';
class AdvancedBookingFormWidget extends StatelessWidget {
  const AdvancedBookingFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
    
        child: Column(
          children: [
            20.kH,
            GodWidget(),
            20.kH,
            Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15,
                bottom: SizeConfig.screenWidth * 0.2,
              ),
              child: VazhipadduWidget(screeName: 'advancedBookingPage'),
            ),
          ],
        ),
      ),
    );
  }
}
