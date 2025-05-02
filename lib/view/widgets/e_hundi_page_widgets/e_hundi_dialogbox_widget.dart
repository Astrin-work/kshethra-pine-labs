import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view_model/e_hundi_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../view_model/booking_viewmodel.dart';
import '../booking_page_widget/star_dialodbox_widget.dart';

class EHundiDialogWidget extends StatelessWidget {
  const EHundiDialogWidget({super.key});


  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);

    return AlertDialog(
      content: Consumer<EHundiViewmodel>(
        builder:
            (context, eHundiViewmodel, child) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: eHundiViewmodel.eHundiKey,
                      child: Column(
                        children: [
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            validator:
                                (value) => Validation.numberValidation(
                                  value,
                                  "Enter an amount",
                                  "Enter a valid amount",
                                ),
                            controller: eHundiViewmodel.eHundiAmountController,
                            textAlign: TextAlign.center,
                            style: styles.blackRegular13,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: eHundiViewmodel.clearHundiAmount,
                                icon: Icon(Icons.close),
                              ),
                              hintText: "Enter the Amount".tr(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          10.kH,
                          TextFormField(
                            controller: eHundiViewmodel.eHundiNameController,
                            style: styles.blackRegular13,
                            decoration: InputDecoration(
                              hintText: "Enter your Name (optional)".tr(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          10.kH,
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => StarDialogBox(),
                              );
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                hintText: "Select Star (optional)",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 12,
                                ),
                              ),
                              child: Consumer<BookingViewmodel>(
                                builder:
                                    (context, bookingViewmodel, child) => Text(
                                      bookingViewmodel.selectedStar ?? "",
                                      style: styles.blackRegular13,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    15.kH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            eHundiViewmodel.navigateScannerPage(context);
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: kDullPrimaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text("Pay".tr()),
                        ),
                        MaterialButton(
                          onPressed: () {
                            eHundiViewmodel.popFunction(context);
                            eHundiViewmodel.clearHundiAmount();
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: kDullPrimaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text("Cancel".tr()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
