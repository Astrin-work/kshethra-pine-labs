import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/god_widget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/star_dialodbox_widget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/vazhipaddu_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

class BookingFormWidget extends StatelessWidget {
  final double? crossAxisSpace;
  final double? mainAxisSpace;
  final int? crossAixisCount;

  const BookingFormWidget({
    super.key,
    this.crossAxisSpace,
    this.mainAxisSpace,
    this.crossAixisCount,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<BookingViewmodel>(
      builder:
          (context, bookingViewmodel, child) => SizedBox(
            child: Column(
              children: [
                25.kH,
                TextField(
                  controller: bookingViewmodel.bookingNameController,
                  textAlign: TextAlign.center,
                  style: styles.blackRegular15,
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                25.kH,
                MaterialButton(
                  minWidth: SizeConfig.screenWidth,
                  height: 55,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => ResponsiveLayout(
                            pinelabDevice: StarDialogBox(),
                            mediumDevice: StarDialogBox(
                              borderRadius: 25,
                              mainAxisSpace: 30,
                              crossAxisSpace: 45,
                            ),
                            semiMediumDevice: StarDialogBox(
                              borderRadius: 25,
                              mainAxisSpace: 30,
                              crossAxisSpace: 45,
                              axisCount: 3,
                            ),
                            semiLargeDevice: StarDialogBox(
                              borderRadius: 30,
                              mainAxisSpace: 30,
                              crossAxisSpace: 45,
                              axisCount: 3,
                            ),
                            largeDevice: StarDialogBox(
                              borderRadius: 35,
                              mainAxisSpace: 30,
                              crossAxisSpace: 45,
                              axisCount: 4,
                            ),
                          ),
                    );
                  },

                  child: Text(
                    bookingViewmodel.selectedStar,
                    style: styles.blackRegular15,
                  ),
                ),
                15.kH,
                GodWidget(),
                Padding(
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    bottom: SizeConfig.screenWidth * 0.2,
                  ),
                  child: VazhipadduWidget(
                    crossAixisCount: crossAixisCount,
                    crossAxisSpace: crossAxisSpace,
                    mainAxisSpace: mainAxisSpace, screeName: 'bookingPage',
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
