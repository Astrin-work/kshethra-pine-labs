// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:kshethra_mini/utils/app_styles.dart';
// import 'package:kshethra_mini/utils/asset/assets.gen.dart';
// import 'package:kshethra_mini/utils/components/size_config.dart';
// import 'package:kshethra_mini/view/widgets/home_page_widgets/option_selector_widget.dart';
// import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
// import 'package:provider/provider.dart';
// import '../build_text_widget.dart';
//
// class AdminHomeWidget extends StatelessWidget {
//   const AdminHomeWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     AppStyles styles = AppStyles();
//     SizeConfig().init(context);
//
//     final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;
//
//     return Consumer<HomePageViewmodel>(
//       builder:
//           (context, homepageViewmodel, child) => SizedBox(
//             height: SizeConfig.screenHeight * 0.6,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 BuildTextWidget(
//                   text: "Welcome".tr(),
//                   color: Colors.black,
//                   size: 20,
//                   fontWeight: FontWeight.w500,
//                   maxLines: 2,
//                   textAlign: TextAlign.center,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     OptionSelectorWidget(
//                       icon: SizedBox(
//                         height: 50,
//                         child: Image.asset(Assets.icons.add_prathishtta.path),
//                       ),
//                       titleWidget: BuildTextWidget(
//                         text: 'Add Prathishtta'.tr(),
//                         color: Colors.black,
//                         size: 16,
//                         fontWeight: FontWeight.w500,
//                         maxLines: 2,
//                         textAlign: TextAlign.center,
//                       ),
//                       onTap: () {
//                         homepageViewmodel.navigateSuperAdminAddPrathisttaView(
//                           context,
//                         );
//                       },
//                     ),
//                     OptionSelectorWidget(
//                       icon: SizedBox(
//                         height: 45,
//                         child: Image.asset(Assets.icons.add_vazhipaddu.path),
//                       ),
//                       titleWidget: BuildTextWidget(
//                         text: 'Add Vazhipaddu'.tr(),
//                         color: Colors.black,
//                         size: 16,
//                         fontWeight: FontWeight.w500,
//                         maxLines: 2,
//                         textAlign: TextAlign.center,
//                       ),
//                       // onTap: () {
//                       //   homepageViewmodel.preBookingPageNavigate(context);
//                       // },
//                       onTap: () {
//                         homepageViewmodel.navigateSuperAdminAddVazhipadduView(
//                           context,
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     OptionSelectorWidget(
//                       icon: SizedBox(
//                         height: 50,
//                         child: Image.asset(Assets.icons.donation.path),
//                       ),
//                       titleWidget: BuildTextWidget(
//                         text: 'Add Donation',
//                         color: Colors.black,
//                         size: 16,
//                         fontWeight: FontWeight.w500,
//                         maxLines: 2,
//                         textAlign: TextAlign.center,
//                         toLang: currentLang,
//                       ),
//                       // onTap: () {
//                       //   homepageViewmodel.donationPageNavigate(context);
//                       // },
//                       onTap: () {
//                         homepageViewmodel.navigateSuperAdminAddDonationView(
//                           context,
//                         );
//                       },
//                     ),
//                     OptionSelectorWidget(
//                       icon: SizedBox(
//                         height: 44,
//                         child: Image.asset(Assets.icons.view_and_edite.path),
//                       ),
//                       titleWidget: BuildTextWidget(
//                         text: 'View & Edit Vazhipaddu'.tr(),
//                         color: Colors.black,
//                         size: 16,
//                         fontWeight: FontWeight.w500,
//                         maxLines: 2,
//                         textAlign: TextAlign.center,
//                       ),
//                       onTap: () {
//                         homepageViewmodel.eHundiPageNavigate(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//     );
//   }
// }
