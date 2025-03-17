import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/booking_model.dart';
import 'package:kshethra_mini/model/star_model.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/back_button_component.dart';
import 'package:kshethra_mini/utils/components/responsive_layout.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: BookingFloatButtonWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(styles: styles),
            ResponsiveLayout(
              pinelabDevice: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: BookingFormWidget(),
              ),
              mediumDevice: BookingFormWidget(),
              largeDevice: BookingFormWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.styles});

  final AppStyles styles;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.2,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        image: DecorationImage(
          image: AssetImage(Assets.images.homeBackground.path),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          BackButtonComponent(),
          Text("Booking", style: styles.whiteRegular20),
        ],
      ),
    );
  }
}

class BookingFormWidget extends StatelessWidget {
  const BookingFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<HomePageViewmodel>(
      builder:
          (context, homepageViewmodel, child) => SizedBox(
            //     height: SizeConfig.screenHeight * 0.8,
            child: Column(
              children: [
                25.kH,
                TextField(
                  controller: homepageViewmodel.bookingNameController,
                  textAlign: TextAlign.center,
                  style: styles.blackRegular15,
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                25.kH,
                MaterialButton(
                  minWidth: SizeConfig.screenWidth,
                  height: 55,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () => homepageViewmodel.showStarDialog(context),

                  child: Text(
                    homepageViewmodel.selectedStar,
                    style: styles.blackRegular15,
                  ),
                ),
                15.kH,
                SizedBox(
                  height: 140,
                  width: SizeConfig.screenWidth,
                  child: GodWidget(
                    styles: styles,
                    homepageViewmodel: homepageViewmodel,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    bottom: SizeConfig.screenWidth * 0.2,
                  ),
                  child: VazhipadduWidget(homepageViewmodel: homepageViewmodel),
                ),
              ],
            ),
          ),
    );
  }
}

class GodWidget extends StatelessWidget {
  final HomePageViewmodel homepageViewmodel;
  const GodWidget({
    super.key,
    required this.styles,
    required this.homepageViewmodel,
  });

  final AppStyles styles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: bList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  homepageViewmodel.setGod(bList[index]);
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:
                            homepageViewmodel.selectedGod == bList[index]
                                ? kPrimaryColor
                                : kTransparent,
                        blurRadius: 5,
                        spreadRadius: 5,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(bList[index].godImg ?? ""),
                    ),
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  bList[index].god ?? "",
                  style: styles.blackRegular15,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class VazhipadduWidget extends StatelessWidget {
  final HomePageViewmodel homepageViewmodel;
  const VazhipadduWidget({super.key, required this.homepageViewmodel});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount:
          homepageViewmodel.selectedGod.vazhippad == null
              ? 0
              : homepageViewmodel.selectedGod.vazhippad!.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 30,
        crossAxisSpacing: 40,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            homepageViewmodel.showVazhipadduDialogBox(
              context,
              homepageViewmodel.selectedGod.vazhippad![index],
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(Assets.images.homeBackground.path),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${homepageViewmodel.selectedGod.vazhippad![index]["vazhi"]}",
                        style: styles.blackRegular15,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "₹ ${homepageViewmodel.selectedGod.vazhippad![index]["prize"]}",
                        style: styles.blackRegular15,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class VazhipadduDialogBoxWidget extends StatelessWidget {
  final Map<String, dynamic> selectedVazhippadu;
  const VazhipadduDialogBoxWidget({
    super.key,
    required this.selectedVazhippadu,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return AlertDialog(
      title: Consumer<HomePageViewmodel>(
        builder:
            (context, homepageViewmodel, child) => Column(
              children: [
                Text(selectedVazhippadu["vazhi"], style: styles.blackSemi18),
                10.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        homepageViewmodel.removeNoOfBookingVazhipaddu(
                          selectedVazhippadu["prize"],
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(360),
                          boxShadow: [
                            BoxShadow(
                              color: kGrey4,
                              blurRadius: 2,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(Icons.remove),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: kBlack),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "${homepageViewmodel.noOfBookingVazhipaddu}",
                          style: styles.blackRegular15,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        homepageViewmodel.addNoOfBookingVazhipaddu(
                          selectedVazhippadu["prize"],
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(360),
                          boxShadow: [
                            BoxShadow(
                              color: kGrey4,
                              blurRadius: 2,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
                10.kH,
                Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    border: Border.all(color: kBlack),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "₹ ${homepageViewmodel.amtOfBookingVazhipaddu}",
                      style: styles.blackRegular15,
                    ),
                  ),
                ),
                15.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      minWidth: 101,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: kWhite,
                      child: Text("Continue", style: styles.blackRegular15),
                    ),
                    MaterialButton(
                      minWidth: 101,
                      onPressed: () {
                        homepageViewmodel.popFunction(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: kWhite,
                      child: Text("Cancel", style: styles.blackRegular15),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}

class StarDialogBox extends StatelessWidget {
  const StarDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return AlertDialog(
      backgroundColor: kWhite,
      title: Consumer<HomePageViewmodel>(
        builder:
            (context, homepageViewmodel, child) => SizedBox(
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
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.85,
                        crossAxisCount: 2,
                      ),
                      itemBuilder:
                          (context, index) => InkWell(
                            onTap: () {
                              homepageViewmodel.setStar(
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
                                    borderRadius: BorderRadius.circular(15),
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

class BookingFloatButtonWidget extends StatelessWidget {
  const BookingFloatButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Consumer<HomePageViewmodel>(
      builder:
          (context, homepageViewmodel, child) => Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: SizeConfig.screenWidth * 0.135,
                  width: SizeConfig.screenWidth * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(Assets.images.homeBackground.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text("PAY", style: styles.whiteRegular20),
                  ),
                ),
                InkWell(
                  onTap: homepageViewmodel.bookingAddNewDevottee,
                  child: Container(
                    height: SizeConfig.screenWidth * 0.135,
                    width: SizeConfig.screenWidth * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(Assets.images.homeBackground.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kWhite,
                        ),
                        child: Icon(Icons.person_add, color: kDullPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
