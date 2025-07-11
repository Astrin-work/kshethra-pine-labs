import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
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

    return Consumer<BookingViewmodel>(
      builder: (context, bookingViewmodel, child) {
        final selectedCategoryIndex =
            bookingViewmodel.selectedAdvancedBookingCategoryIndex;

        return Form(
          key: bookingViewmodel.bookingKey,
          child: Column(
            children: [
              25.kH,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50,
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
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: kDullPrimaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 50,
                          child: MaterialButton(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            onPressed: () async {
                              await showDialog(
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
                              bookingViewmodel.validateStar();
                            },
                            child: Text(
                              bookingViewmodel.selectedStar,
                              style: styles.blackRegular15,
                            ),
                          ),
                        ),
                        if (bookingViewmodel.starError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              bookingViewmodel.starError!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              15.kH,
              const GodWidget(),
              VazhipadduWidget(
                crossAxisCount: crossAxisCount ?? 3,
                crossAxisSpacing: crossAxisSpacing ?? 15,
                mainAxisSpacing: mainAxisSpacing ?? 15,
                screeName: 'bookingPage',
                selectedCategoryIndex: selectedCategoryIndex,
              ),
            ],
          ),
        );

      },
    );
  }
}
