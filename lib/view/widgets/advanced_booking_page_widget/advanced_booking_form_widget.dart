import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/god_widget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/vazhipaddu_widget.dart';

import '../../../view_model/booking_viewmodel.dart';

class AdvancedBookingFormWidget extends StatelessWidget {
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final int? crossAxisCount;

  const AdvancedBookingFormWidget({
    super.key,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    final selectedCategoryIndex =
        BookingViewmodel().selectedAdvancedBookingCategoryIndex;
    return Column(
      children: [
        20.kH,
        GodWidget(),
        VazhipadduWidget(
          crossAxisCount: crossAxisCount ?? 3,
          crossAxisSpacing: crossAxisSpacing ?? 15,
          mainAxisSpacing: mainAxisSpacing ?? 15,
          screeName: 'advancedBookingPage',
          selectedCategoryIndex: selectedCategoryIndex,
        ),
      ],
    );
  }
}
