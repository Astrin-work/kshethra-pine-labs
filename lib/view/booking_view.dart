import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/booking_model.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/back_button_component.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [AppBarWidget(styles: styles), BookingFormWidget()],
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
                  onPressed: () {},
                  child: Text("Star", style: styles.blackRegular15),
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
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    //     bottom: 8,
                  ),
                  child: VazhipadduWidget(homepageViewmodel: homepageViewmodel),
                ),
              ],
            ),
          ),
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
        mainAxisSpacing: 15,
        crossAxisSpacing: 20,
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      homepageViewmodel.selectedGod.vazhippad![index]["vazhi"],
                      style: styles.blackRegular15,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
