import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;
  static double safeBlockHorizontal = 0;
  static double safeBlockVertical = 0;
  static double bottomInset = 0;


  void init(BuildContext context) {
    final mediaQueryContext = MediaQuery.of(context);

    screenWidth = mediaQueryContext.size.width;
    screenHeight = mediaQueryContext.size.height;
    bottomInset = mediaQueryContext.viewInsets.bottom;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    final safeAreaHorizontal =
        mediaQueryContext.padding.left + mediaQueryContext.padding.right;
    final safeAreaVertical =
        mediaQueryContext.padding.top + mediaQueryContext.padding.bottom;

    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;
  }

  static double widthPercentage(double percentage) {
    return blockSizeHorizontal * percentage;
  }

  static double heightPercentage(double percentage) {
    return blockSizeVertical * percentage;
  }

  static double safeWidthPercentage(double percentage) {
    return safeBlockHorizontal * percentage;
  }

  static double safeHeightPercentage(double percentage) {
    return safeBlockVertical * percentage;
  }
}

extension IntExtension on int? {
  int validate({int value = 0}) {
    return this ?? value;
  }

  Widget get kH => SizedBox(
        height: this?.toDouble(),
      );
  Widget get kW => SizedBox(
        width: this?.toDouble(),
      );
}