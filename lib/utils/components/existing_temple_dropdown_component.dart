// import 'package:flutter/material.dart';
// import 'package:kshethra_mini/model/demo_model/temple_model.dart';
// import 'package:kshethra_mini/utils/app_color.dart';
// import 'package:kshethra_mini/utils/app_styles.dart';
// import 'package:kshethra_mini/utils/components/size_config.dart';
// import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
// import 'package:provider/provider.dart';
//
// class ExistingTempleDropdownComponent extends StatelessWidget {
//   const ExistingTempleDropdownComponent({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     AppStyles styles = AppStyles();
//     return SizedBox(
//       child: Consumer<HomePageViewmodel>(
//         builder:
//             (context, homepageViewmodel, child) => Stack(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     homepageViewmodel.toggleTempleDropdownVissible();
//                   },
//                   child: Container(
//                     width: 300,
//                     height: 55,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: kBlack),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Center(
//                       child: Text(
//                         homepageViewmodel.selectedTemple,
//                         style: styles.blackRegular15,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: homepageViewmodel.isTempleDropdownVissible,
//                   child: Container(
//                     width: 300,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: kScaffoldColor,
//                       border: Border.all(color: kBlack),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children:
//                             templeList.map((item) {
//                               return InkWell(
//                                 onTap:
//                                     () => homepageViewmodel
//                                         .templeDropDownOnchange(item.temple),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Center(
//                                     child: Text(
//                                       item.temple,
//                                       style: styles.blackRegular15,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//       ),
//     );
//   }
// }
