// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:kshethra_mini/model/demo_model/donation_model.dart';
// import 'package:kshethra_mini/utils/app_color.dart';
// import 'package:kshethra_mini/utils/app_styles.dart';
// import 'package:kshethra_mini/utils/asset/assets.gen.dart';
// import 'package:kshethra_mini/utils/components/size_config.dart';
// import 'package:kshethra_mini/utils/validation.dart';
// import 'package:kshethra_mini/view_model/donation_viewmodel.dart';
// import 'package:provider/provider.dart';
//
// class DonationFormWidget extends StatelessWidget {
//   final double crossAxisSpacing;
//   final double mainAxisSpacing;
//   final int? crossAxisCount;
//   const DonationFormWidget({
//     super.key,
//     required this.crossAxisSpacing,
//     required this.mainAxisSpacing,
//     this.crossAxisCount,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     AppStyles styles = AppStyles();
//     SizeConfig().init(context);
//     return Consumer<DonationViewmodel>(
//       builder:
//           (context,  donationViewmodel, child) => SizedBox(
//             // height: SizeConfig.screenHeight * 0.8,
//             child: Form(
//               key: donationViewmodel.donationFormKey,canPop: true,
//               child: Column(
//                 children: [
//                   25.kH,
//                   TextFormField(
//                     autofocus: true,
//                     validator: Validation.nameValidation,
//                     controller: donationViewmodel.donationNameController,
//                     textAlign: TextAlign.center,
//                     style: styles.blackRegular15,
//                     decoration: InputDecoration(
//                       hintText: "Name".tr(),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   ),
//                   25.kH,
//                   TextFormField(
//                     keyboardType: TextInputType.number,
//                     validator: Validation.phoneValidation,
//                     controller: donationViewmodel.donationPhnoController,
//                     textAlign: TextAlign.center,
//                     style: styles.blackRegular15,
//                     maxLength: 10,
//                     // inputFormatters: [
//                     //   FilteringTextInputFormatter.digitsOnly, // Allow only digits
//                     //   LengthLimitingTextInputFormatter(10),   // Max 10 digits
//                     // ],
//                     decoration: InputDecoration(
//                       hintText: "Phone".tr(),
//                       counterText: "",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   ),
//
//                   25.kH,
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: donations.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       mainAxisSpacing: mainAxisSpacing,
//                       crossAxisSpacing: crossAxisSpacing,
//                       crossAxisCount: crossAxisCount ?? 2,
//                     ),
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//                           donationViewmodel.showDonationDialog(context);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 Assets.images.homeBackground.path,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: kWhite,
//                               ),
//
//                               child: Center(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     donations[index].donatKey!.isNotEmpty
//                                         ? donations[index].donatKey!.tr()
//                                         : '', // if empty, show nothing
//                                   )
//
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   15.kH,
//                 ],
//               ),
//             ),
//           ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/demo_model/donation_model.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/asset/assets.gen.dart';
import '../../../utils/components/size_config.dart';
import '../../../utils/validation.dart';
import '../../../view_model/donation_viewmodel.dart';

class DonationFormWidget extends StatefulWidget {
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final int? crossAxisCount;

  const DonationFormWidget({
    super.key,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    this.crossAxisCount,
  });

  @override
  State<DonationFormWidget> createState() => _DonationFormWidgetState();
}

class _DonationFormWidgetState extends State<DonationFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);

    return Consumer<DonationViewmodel>(
      builder: (context, donationViewmodel, child) => SizedBox(
        child: Form(
          key: _formKey,
          canPop: true,
          child: Column(
            children: [
              25.kH,
              TextFormField(
                autofocus: true,
                controller: _nameController,
                validator: Validation.nameValidation,
                textAlign: TextAlign.center,
                style: styles.blackRegular15,
                decoration: InputDecoration(
                  hintText: "Name".tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              25.kH,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _phoneController,
                validator: Validation.phoneValidation,
                textAlign: TextAlign.center,
                style: styles.blackRegular15,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: "Phone".tr(),
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              25.kH,
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: donations.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: widget.mainAxisSpacing,
                  crossAxisSpacing: widget.crossAxisSpacing,
                  crossAxisCount: widget.crossAxisCount ?? 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      donationViewmodel.showDonationDialog(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(
                            Assets.images.homeBackground.path,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kWhite,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                donations[index].donatKey!.isNotEmpty
                                    ? donations[index].donatKey!.tr()
                                    : '',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              15.kH,
            ],
          ),
        ),
      ),
    );
  }
}
