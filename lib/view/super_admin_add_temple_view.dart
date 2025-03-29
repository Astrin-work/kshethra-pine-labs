import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/utils/validation.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class SuperAdminAddTempleView extends StatelessWidget {
  const SuperAdminAddTempleView({super.key});

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
                homepageViewmodel.addTempleFloatButton(context);
              },
              child: Icon(Icons.check),
            ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [AppBarWidget(title: "Add Temple"), AddTempleWidget()],
        ),
      ),
    );
  }
}

class AddTempleWidget extends StatelessWidget {
  const AddTempleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppStyles styles = AppStyles();
    return Consumer<HomePageViewmodel>(
      builder:
          (context, homepageViewmodel, child) => Form(
            key: homepageViewmodel.addTempleFormKey,
            child: Column(
              children: [
                25.kH,
                TextFieldWidget(
                  autoFocus: true,
                  title: "Name of the temple :",
                  hint: "Temple",
                  controller: homepageViewmodel.addTempleName,
                ),
                TextFieldWidget(
                  title: "Username for admin :",
                  hint: "Uname admin",
                  controller: homepageViewmodel.addTempleAdminUname,
                ),
                TextFieldWidget(
                  title: "Password for admin :",
                  hint: "Admin password",
                  controller: homepageViewmodel.addTempleAdminPass,
                ),
                TextFieldWidget(
                  title: "Username for devotee  :",
                  hint: "Uname devotee ",
                  controller: homepageViewmodel.addTempleDevoteeUname,
                ),
                TextFieldWidget(
                  title: "Password for devotee  :",
                  hint: "devotee  password",
                  controller: homepageViewmodel.addTempleDevoteePass,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.number,
                  validator: (value) => Validation.phoneValidation(value),
                  title: "Phone number of the temple :",
                  hint: "Phno",
                  controller: homepageViewmodel.addTemplePhno,
                ),
                TextFieldWidget(
                  title: "Address of the temple :",
                  hint: "Address",
                  maxLines: 4,
                  controller: homepageViewmodel.addTempleAddress,
                ),
              ],
            ),
          ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final TextInputType? keyboardType;
  final String title;
  final String hint;
  final int? maxLines;
  final bool? autoFocus;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    required this.title,
    required this.hint,
    this.maxLines,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.autoFocus,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppStyles styles = AppStyles();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: styles.blackRegular15),
        10.kH,
        SizedBox(
          width: 300,
          child: TextFormField(
            autofocus: autoFocus ?? false,
            keyboardType: keyboardType,
            validator:
                validator ??
                (value) => Validation.emptyValidation(value, "Enter a value"),
            controller: controller,
            maxLines: maxLines ?? 1,
            style: styles.blackRegular15,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        25.kH,
      ],
    );
  }
}
