import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/build_text_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../view_model/home_page_viewmodel.dart';

class VazhipadduWidget extends StatelessWidget {
  final double? crossAxisSpace;
  final double? mainAxisSpace;
  final int? crossAixisCount;
  final String screeName;
  const VazhipadduWidget({
    super.key,
    this.crossAxisSpace,
    this.mainAxisSpace,
    this.crossAixisCount,
    required this.screeName,
  });

  @override
  Widget build(BuildContext context) {
    final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<BookingViewmodel>(
      builder:
          (context, bookingViewmodel, child) => GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                bookingViewmodel.selectedGod.vazhippad == null
                    ? 0
                    : bookingViewmodel.selectedGod.vazhippad!.length,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: mainAxisSpace ?? 30,
              crossAxisSpacing: crossAxisSpace ?? 40,
              crossAxisCount: crossAixisCount ?? 2,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (screeName == "bookingPage") {
                    print('------pressed1--------');
                    bookingViewmodel.showVazhipadduDialogBox(
                      context,
                      bookingViewmodel.selectedGod.vazhippad![index],
                    );
                  } else {
                    print('------pressed2--------');
                    bookingViewmodel.showAdvancedVazhipadduDialogBox(
                      context,
                      bookingViewmodel.selectedGod.vazhippad![index],
                    );
                  }
                },

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(Assets.images.homeBackground.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // BuildTextWidget(
                            //   text:
                            //       "${bookingViewmodel.selectedGod.vazhippad![index]["vazhi"]}",
                            //   toLang: currentLang,
                            //   textAlign: TextAlign.center,
                            // ),
                            Text(
                              bookingViewmodel
                                          .selectedGod
                                          .vazhippad![index]["vazhi"] !=
                                      null
                                  ? bookingViewmodel
                                      .selectedGod
                                      .vazhippad![index]["vazhi"]
                                      .toString()
                                      .tr()
                                  : "",
                              style: styles.blackRegular15,
                              textAlign: TextAlign.center,
                            ),
                            BuildTextWidget(
                              text:
                                  "${bookingViewmodel.selectedGod.vazhippad![index]["prize"]}",
                              toLang: currentLang,
                              textAlign: TextAlign.center,
                            ),
                            // Text(
                            //   "${bookingViewmodel.selectedGod.vazhippad![index]["vazhi"]}",
                            //   style: styles.blackRegular15,
                            //   textAlign: TextAlign.center,
                            // ),
                            // Text(
                            //   "₹ ${bookingViewmodel.selectedGod.vazhippad![index]["prize"]}",
                            //   style: styles.blackRegular15,
                            //   textAlign: TextAlign.center,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
