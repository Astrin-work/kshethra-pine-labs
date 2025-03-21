import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
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
    return Column(
      children: [
        25.kH,
        TextFieldWidget(title: "Name of the temple :", hint: "Temple"),
        TextFieldWidget(title: "Username for admin :", hint: "Uname admin"),
        TextFieldWidget(title: "Password for admin :", hint: "Admin password"),
        TextFieldWidget(
          title: "Username for devotee  :",
          hint: "Uname devotee ",
        ),
        TextFieldWidget(
          title: "Password for devotee  :",
          hint: "devotee  password",
        ),
        TextFieldWidget(title: "Phone number of the temple :", hint: "Phno"),
        TextFieldWidget(
          title: "Address of the temple :",
          hint: "Address",
          maxLines: 4,
        ),
      ],
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String title;
  final String hint;
  final int? maxLines;

  const TextFieldWidget({
    super.key,
    required this.title,
    required this.hint,
    this.maxLines,
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
          child: TextField(
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
