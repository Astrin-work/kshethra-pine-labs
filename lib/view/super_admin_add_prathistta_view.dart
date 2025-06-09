// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:kshethra_mini/utils/app_color.dart';
// import 'package:kshethra_mini/utils/app_styles.dart';
// import 'package:kshethra_mini/utils/asset/assets.gen.dart';
// import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
// import 'package:kshethra_mini/utils/components/existing_temple_dropdown_component.dart';
// import 'package:kshethra_mini/utils/components/responsive_layout.dart';
// import 'package:kshethra_mini/utils/components/size_config.dart';
// import 'package:kshethra_mini/utils/validation.dart';
// import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
// import 'package:provider/provider.dart';
//
// class SuperAdminAddPrathisttaView extends StatelessWidget {
//   const SuperAdminAddPrathisttaView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       floatingActionButton: Consumer<HomePageViewmodel>(
//         builder:
//             (context, homepageViewmodel, child) => FloatingActionButton(
//               backgroundColor: kPrimaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(360),
//               ),
//               onPressed: () {
//                 homepageViewmodel.addGodFloatButton(context);
//               },
//               child: Icon(Icons.check, size: 32),
//             ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             AppBarWidget(title: "Add Prathishtta".tr()),
//             35.kH,
//             ResponsiveLayout(
//               pinelabDevice: Padding(
//                 padding: const EdgeInsets.only(left: 15.0, right: 15),
//                 child: AddWidget(),
//               ),
//               mediumDevice: Padding(
//                 padding: EdgeInsets.only(
//                   left: SizeConfig.screenWidth * 0.15,
//                   right: SizeConfig.screenWidth * 0.15,
//                 ),
//                 child: AddWidget(),
//               ),
//               largeDevice: Padding(
//                 padding: EdgeInsets.only(
//                   left: SizeConfig.screenWidth * 0.25,
//                   right: SizeConfig.screenWidth * 0.25,
//                 ),
//                 child: AddWidget(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class AddWidget extends StatelessWidget {
//   const AddWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     AppStyles styles = AppStyles();
//     return Consumer<HomePageViewmodel>(
//       builder:
//           (context, homepageViewmodel, child) => Column(
//             children: [
//               CircleAvatar(
//                 radius: 100,
//                 backgroundImage:
//                     homepageViewmodel.addGodImage != null
//                         ? MemoryImage(homepageViewmodel.addGodImage!)
//                         : AssetImage(Assets.icons.plusIcon.path),
//                 child: Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     Positioned(
//                       right: 19,
//                       child: CircleAvatar(
//                         backgroundColor: kPrimaryColor,
//                         child: IconButton(
//                           color: kWhite,
//                           onPressed: () {
//                             homepageViewmodel.showAddPrsthishttaFirstDialog(
//                               context,
//                             );
//                           },
//                           icon: Icon(Icons.edit, color: kBlack10),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               25.kH,
//               ExistingTempleDropdownComponent(),
//               25.kH,
//               SizedBox(
//                 width: 300,
//                 child: Form(
//                   key: homepageViewmodel.addPrathishttaKey,
//                   child: TextFormField(
//                     validator:
//                         (value) => Validation.emptyValidation(
//                           value,
//                           "Enter prathishtta name",
//                         ),
//                     controller: homepageViewmodel.addPrathishttaNameController,
//                     textAlign: TextAlign.center,
//                     style: styles.blackRegular15,
//                     decoration: InputDecoration(
//                       hintText: "Name of prathishtta".tr(),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//     );
//   }
// }
//
// class CameraAndGalleryBottomSheet extends StatelessWidget {
//   final void Function() cameraButton;
//   final Function() galleryButton;
//   const CameraAndGalleryBottomSheet({
//     super.key,
//     required this.cameraButton,
//     required this.galleryButton,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     AppStyles styles = AppStyles();
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: 15.0,
//         bottom: 25,
//         left: 20,
//         right: 20,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Add Photo", style: styles.blackRegular15),
//           17.kH,
//           Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   cameraButton();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: kGrey4,
//                     borderRadius: BorderRadius.circular(360),
//                   ),
//                   height: 60,
//                   width: 60,
//                   child: Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Assets.icons.cameraIcon.image(),
//                   ),
//                 ),
//               ),
//               25.kW,
//               InkWell(
//                 onTap: () {
//                   galleryButton();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: kGrey4,
//                     borderRadius: BorderRadius.circular(360),
//                   ),
//                   height: 60,
//                   width: 60,
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Assets.icons.imageIcon.image(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
