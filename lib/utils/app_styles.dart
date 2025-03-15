import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';

class AppStyles {
  static final AppStyles _instance = AppStyles._internal();

  factory AppStyles() {
    return _instance;
  }

  AppStyles._internal();

  static TextStyle _baseTextStyle(
    Color color,
    double fontSize,
    FontWeight fontWeight,
  ) {
    return TextStyle(
      fontFamily: 'poppins',
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  TextStyle get primBold22 =>
      _baseTextStyle(kDullPrimaryColor, 27.0, FontWeight.w500);

  TextStyle get whiteRegular18 => _baseTextStyle(kWhite, 18.0, FontWeight.w300);
  TextStyle get whiteRegular20 => _baseTextStyle(kWhite, 25.0, FontWeight.w500);

  TextStyle get blackRegular13 => _baseTextStyle(kBlack, 13.0, FontWeight.w400);
  TextStyle get blackRegular15 => _baseTextStyle(kBlack, 15.0, FontWeight.w400);
  TextStyle get blackRegular18 => _baseTextStyle(kBlack, 18.0, FontWeight.w400);
  TextStyle get blackRegular22 => _baseTextStyle(kBlack, 22.0, FontWeight.w400);
}
