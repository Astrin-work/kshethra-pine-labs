import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/qr_code_component.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view_model/e_hundi_viewmodel.dart';
import 'package:provider/provider.dart';

class EHundiDialogWidget extends StatelessWidget {
  const EHundiDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return AlertDialog(
      title: Consumer<EHundiViewmodel>(
        builder:
            (context, eHundiViewmodel, child) => Column(
              children: [
                Form(
                  key: eHundiViewmodel.eHundiKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator:
                        (value) => Validation.numberValidation(
                          value,
                          "Enter a amount",
                          "Enter valid amount",
                        ),
                    controller: eHundiViewmodel.eHundiAmountController,
                    textAlign: TextAlign.center,
                    style: styles.blackRegular13,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: eHundiViewmodel.clearHundiAmount,
                        icon: Icon(Icons.close),
                      ),
                      hintText: "Enter the Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
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
                        side: BorderSide(color: kDullPrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("Pay"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        eHundiViewmodel.popFunction(context);
                        eHundiViewmodel.clearHundiAmount();
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: kDullPrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
