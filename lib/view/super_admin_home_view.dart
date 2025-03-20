import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';

class SuperAdminHomeView extends StatelessWidget {
  const SuperAdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppStyles styles = AppStyles();
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(title: "Super Admin Page"),
          35.kH,
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: SuperAdminWidget(),
          ),
        ],
      ),
    );
  }
}

class SuperAdminWidget extends StatelessWidget {
  const SuperAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppStyles styles = AppStyles();
    return SizedBox(
      child: Column(
        children: [
          OptionBoxWidget(title: 'Add Prathistta', onTap: () {}),
          20.kH,
          OptionBoxWidget(title: 'Add VazhiPaddu', onTap: () {}),
          20.kH,
          OptionBoxWidget(title: 'Add Sambhavana', onTap: () {}),
        ],
      ),
    );
  }
}

class OptionBoxWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const OptionBoxWidget({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppStyles styles = AppStyles();
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kScaffoldColor,
          boxShadow: [
            BoxShadow(
              color: kGrey9,
              offset: Offset(0, 4),
              blurRadius: 3,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(child: Text(title, style: styles.blackRegular18)),
      ),
    );
  }
}
