import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/star_model.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

class StarDialogBox extends StatelessWidget {
  final double? mainAxisSpace;
  final double? crossAxisSpace;
  final double? borderRadius;
  final int? axisCount;
  const StarDialogBox({
    super.key,
    this.mainAxisSpace,
    this.crossAxisSpace,
    this.borderRadius,
    this.axisCount,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return AlertDialog(
      backgroundColor: kWhite,
      title: Consumer<BookingViewmodel>(
        builder:
            (context, bookingViewmodel, child) => SizedBox(
              height: SizeConfig.screenHeight * 0.7,
              width: SizeConfig.screenWidth * 0.7,
              child: Column(
                children: [
                  Text("Select your Star", style: styles.blackRegular18),
                  15.kH,
                  Expanded(
                    child: GridView.builder(
                      itemCount: stars.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: mainAxisSpace ?? 15,
                        crossAxisSpacing: crossAxisSpace ?? 10,
                        childAspectRatio: 1.85,
                        crossAxisCount: axisCount ?? 2,
                      ),
                      itemBuilder:
                          (context, index) => InkWell(
                            onTap: () {
                              bookingViewmodel.setStar(
                                stars[index].star ?? "",
                                context,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(
                                    Assets.images.homeBackground.path,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 2.5,
                                  bottom: 2.5,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(
                                      borderRadius ?? 15,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      stars[index].star ?? "",
                                      style: styles.blackRegular13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
