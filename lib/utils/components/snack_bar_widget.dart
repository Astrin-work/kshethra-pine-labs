import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';

class SnackBarWidget extends StatelessWidget {
  final String msg;
  final Color color;
  const SnackBarWidget({super.key, required this.msg, required this.color});

  @override
  SnackBar build(BuildContext context) {
    AppStyles styles = AppStyles();
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(msg, style: styles.whiteRegular15),
      duration: Duration(seconds: 2),
      backgroundColor: color,
    );
  }
}
