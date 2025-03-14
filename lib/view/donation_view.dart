import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/donation_model.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/back_button_component.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';

class DonationView extends StatelessWidget {
  const DonationView({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          child: Column(
            children: [
              Container(
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
                    Text("Donation", style: styles.whiteRegular20),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: DonationFormWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonationFormWidget extends StatelessWidget {
  const DonationFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return SizedBox(
      height: SizeConfig.screenHeight * 0.8,
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
          TextField(
            style: styles.blackRegular15,
            decoration: InputDecoration(
              hintText: "Phno",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              itemCount: donations.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Container(child: Text(donations[index].donat ?? ''));
              },
            ),
          ),
        ],
      ),
    );
  }
}
