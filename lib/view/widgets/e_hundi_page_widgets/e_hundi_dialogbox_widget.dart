import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view_model/e_hundi_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../api_services/api_service.dart';
import '../../../utils/components/snack_bar_widget.dart';
import '../../../view_model/booking_viewmodel.dart';
import '../booking_page_widget/star_dialodbox_widget.dart';

class EHundiDialogWidget extends StatefulWidget {
  const EHundiDialogWidget({super.key});

  @override
  State<EHundiDialogWidget> createState() => _EHundiDialogWidgetState();
}

class _EHundiDialogWidgetState extends State<EHundiDialogWidget> {
  late TextEditingController _amountController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  Future<bool> postEbannaramiDonation(BuildContext context, int index) async {
    final eHundiViewModel = Provider.of<EHundiViewmodel>(
      context,
      listen: false,
    );
    final bookingViewModel = Provider.of<BookingViewmodel>(
      context,
      listen: false,
    );

    final data = {
      "devathaName": eHundiViewModel.gods[index].devathaName,
      "amount": _amountController.text.trim(),
      "personName": _nameController.text.trim(),
      "phoneNumber": _phoneController.text.trim(),
      "personStar": bookingViewModel.selectedStar,
      "paymentType": "lsk",
      "transactionId": "11221",
      "bankId": "131333",
      "bankName": "sbi"
    };

    try {
      await ApiService().postEHundiDetails(data);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarWidget(
            msg: "Donation posted successfully!",
            color: Colors.green,
          ).build(context),
        );
      }
      return true;
    } catch (e) {
      final errorMessage = e?.toString() ?? "Unknown error occurred";
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarWidget(
            msg: "Failed to post donation: $errorMessage",
            color: Colors.red,
          ).build(context),
        );
      }
      return false;
    }

  }

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<EHundiViewmodel>(context, listen: false);
    _amountController = viewModel.eHundiAmountController;
    _nameController = viewModel.eHundiNameController;
    _phoneController = viewModel.eHundiPhoneController;
  }

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
                            controller: _amountController,
                            textAlign: TextAlign.start,
                            style: styles.blackRegular13,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: eHundiViewmodel.clearHundiAmount,
                                icon: Icon(Icons.close),
                              ),
                              label: RichText(
                                text: TextSpan(
                                  text: 'Amount'.tr(),
                                  style: styles.blackRegular15,
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),

                          10.kH,
                          TextFormField(
                            controller: _nameController,
                            style: styles.blackRegular13,
                            decoration: InputDecoration(
                              hintText: "Enter your Name (optional)".tr(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          10.kH,
                          TextFormField(
                            controller: _phoneController,
                            style: styles.blackRegular13,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: InputDecoration(
                              hintText: "Phone".tr(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => const StarDialogBox(),
                              );
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                hintText: "Select Star (optional)",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
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
                          onPressed: () async {
                            final eHundiViewModel = Provider.of<EHundiViewmodel>(
                              context,
                              listen: false,
                            );
                            if (eHundiViewModel.eHundiKey.currentState?.validate() ?? false) {
                              final success = await postEbannaramiDonation(
                                context,
                                eHundiViewModel.selectedIndex,
                              );

                              if (success && context.mounted) {
                                eHundiViewModel.navigateScannerPage(context);
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: kDullPrimaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text("Pay".tr()),
                        ),

                        MaterialButton(
                          onPressed: () {
                            final viewModel = Provider.of<EHundiViewmodel>(
                              context,
                              listen: false,
                            );
                            viewModel.popFunction(context);
                            viewModel.clearHundiAmount();
                          },
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: kDullPrimaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text("Cancel".tr()),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
