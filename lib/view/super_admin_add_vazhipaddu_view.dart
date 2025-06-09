// import 'package:flutter/material.dart';
// import 'package:kshethra_mini/model/demo_model/e_hundi_model.dart';
// import 'package:kshethra_mini/utils/app_color.dart';
// import 'package:kshethra_mini/utils/app_styles.dart';
// import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
// import 'package:kshethra_mini/utils/components/existing_temple_dropdown_component.dart';
// import 'package:kshethra_mini/utils/components/size_config.dart';
// import 'package:kshethra_mini/utils/validation.dart';
// import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
// import 'package:provider/provider.dart';
//
// class SuperAdminAddVazhipadduView extends StatelessWidget {
//   const SuperAdminAddVazhipadduView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: Consumer<HomePageViewmodel>(
//         builder:
//             (context, homepageViewmodel, child) => FloatingActionButton(
//               backgroundColor: kPrimaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(360),
//               ),
//               onPressed: () {
//                 homepageViewmodel.addVazhipaddFloatButton(context);
//               },
//               child: Icon(Icons.check),
//             ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             AppBarWidget(title: "Add Vazhipaddu"),
//             AddVazhipadduWidget(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class AddVazhipadduWidget extends StatelessWidget {
//   const AddVazhipadduWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     AppStyles styles = AppStyles();
//     return Consumer<HomePageViewmodel>(
//       builder:
//           (context, homepageViewmodel, child) => Padding(
//             padding: const EdgeInsets.only(left: 15.0, right: 15),
//             child: Form(
//               key: homepageViewmodel.addVazhippaduKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   25.kH,
//                   ExistingTempleDropdownComponent(),
//                   25.kH,
//                   Text("Select Prathishtta :", style: styles.blackRegular15),
//                   10.kH,
//                   DropDownWidget(),
//                   25.kH,
//                   Text("Name of Vazhipaddu :", style: styles.blackRegular15),
//                   10.kH,
//                   SizedBox(
//                     width: 300,
//                     child: TextFormField(
//                       validator:
//                           (value) => Validation.emptyValidation(
//                             value,
//                             "Enter a vazhippadu",
//                           ),
//                       controller: homepageViewmodel.addVazhippaduNameController,
//                       style: styles.blackRegular15,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         hintText: "Add Vazhipaddu",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                   ),
//                   25.kH,
//                   Text("Prize of Vazhipaddu :", style: styles.blackRegular15),
//                   10.kH,
//                   SizedBox(
//                     width: 300,
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       validator:
//                           (value) => Validation.numberValidation(
//                             value,
//                             "Enter the prize of vazhipaddu",
//                             "Enter a valid prize",
//                           ),
//                       controller:
//                           homepageViewmodel.addVazhippaduPrizeController,
//                       style: styles.blackRegular15,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         hintText: "₹ Prize",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }
// }
//
// class DropDownWidget extends StatelessWidget {
//   const DropDownWidget({super.key});
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
//                     homepageViewmodel.toggleIsDropdownVissible();
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
//                         homepageViewmodel.selectedPrathishtta,
//                         style: styles.blackRegular15,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: homepageViewmodel.isDropdownVissible,
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
//                             hundiList.map((item) {
//                               return InkWell(
//                                 onTap:
//                                     () => homepageViewmodel
//                                         .addPoojaDropDownOnchange(
//                                           item.god ?? "",
//                                         ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Center(
//                                     child: Text(
//                                       item.god ?? "",
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
