import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/e_hundi_model.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/build_text_widget.dart';
import 'package:kshethra_mini/view_model/e_hundi_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../view_model/home_page_viewmodel.dart';

class GodListWidget extends StatelessWidget {
  final double? crossAxisSpace;
  final double? mainAxisSpace;
  final int? axisCount;
  const GodListWidget({
    super.key,
    this.crossAxisSpace,
    this.mainAxisSpace,
    this.axisCount,
  });

  @override
  Widget build(BuildContext context) {
    final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<EHundiViewmodel>(
      builder:
          (context, eHundiViewmodel, child) => GridView.builder(
            itemCount: hundiList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: axisCount ?? 2,
              crossAxisSpacing: crossAxisSpace ?? 30,
              mainAxisSpacing: mainAxisSpace ?? 25,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  eHundiViewmodel.showEhundiDonationDialog(context);
                  eHundiViewmodel.clearHundiAmount();
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                color: kPrimaryColor,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(hundiList[index].godImg ?? ""),
                            ),
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      10.kH,
                      BuildTextWidget(
                        text: hundiList[index].god ?? "",
                        color: kBlack,
                        toLang: currentLang,
                        // toLang: currentLang,
                      ),
                      // Text(
                      //   hundiList[index].god ?? "",
                      //   style: styles.blackRegular15,
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
