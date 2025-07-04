import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/god_widget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/star_dialodbox_widget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/vazhipaddu_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../view_model/home_page_viewmodel.dart';

class BookingFormWidget extends StatelessWidget {
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final int? crossAxisCount;

  const BookingFormWidget({
    super.key,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    final selectedCategoryIndex =
        BookingViewmodel().selectedAdvancedBookingCategoryIndex;

    return Consumer<BookingViewmodel>(
      builder: (context, bookingViewmodel, child) => Column(
        children: [
          25.kH,

          Form(
            key: bookingViewmodel.bookingKey,
            child: SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                child: TextFormField(
                  autofocus: true,
                  validator: Validation.nameValidation,
                  controller: bookingViewmodel.bookingNameController,
                  textAlign: TextAlign.center,
                  style: styles.blackRegular15,
                  decoration: InputDecoration(
                    hintText: 'Name'.tr(),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ),

          15.kH,
          MaterialButton(
            minWidth: SizeConfig.screenWidth,
            height: 45,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ResponsiveLayout(
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
          const GodWidget(),
          Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15,
              bottom: SizeConfig.screenWidth * 0.2,
            ),
            child: VazhipadduWidget(
              crossAxisCount: crossAxisCount ?? 3,
              crossAxisSpacing: crossAxisSpacing ?? 15,
              mainAxisSpacing: mainAxisSpacing ?? 15,
              screeName: 'bookingPage',
              selectedCategoryIndex: selectedCategoryIndex,
            ),
          ),
        ],
      ),
    );
  }
}
