import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/existing_temple_dropdown_component.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class SuperAdminAddDonationView extends StatelessWidget {
  const SuperAdminAddDonationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<HomePageViewmodel>(
        builder:
            (context, homepageViewmodel, child) => FloatingActionButton(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(360),
              ),
              onPressed: () {
                homepageViewmodel.addDonationFloatButton(context);
              },
              child: Icon(Icons.check),
            ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(title: "Add Donation"),
            AddDonationFormWidget(),
          ],
        ),
      ),
    );
  }
}

class AddDonationFormWidget extends StatelessWidget {
  const AddDonationFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppStyles styles = AppStyles();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        25.kH,
        ExistingTempleDropdownComponent(),
        25.kH,
        Text("Add Donation :", style: styles.blackRegular15),
        10.kH,
        Consumer<HomePageViewmodel>(
          builder:
              (context, homepageViewmodel, child) => SizedBox(
                width: 300,
                child: Form(
                  key: homepageViewmodel.addDonationKey,
                  child: TextFormField(
                    validator: (value) => Validation.emptyValidation(value, "Enter a donation"),
                    controller: homepageViewmodel.addDonationNameController,
                    style: styles.blackRegular15,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Donation",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ],
    );
  }
}
