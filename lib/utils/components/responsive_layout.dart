import 'dart:developer';

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget pinelabDevice;
  final Widget mediumDevice;
  final Widget largeDevice;
  final Widget? semiMediumDevice;
  const ResponsiveLayout({
    super.key,
    required this.pinelabDevice,
    required this.mediumDevice,
    required this.largeDevice,
    this.semiMediumDevice,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        log(constraints.maxWidth.toString(), name: "Max Width");
        if (constraints.maxWidth < 450) {
          log("Pinelab Device");
          return pinelabDevice;
        } else if (constraints.maxWidth > 450 && constraints.maxWidth < 649) {
          log("Medium Device");
          return mediumDevice;
        } else if (constraints.maxWidth > 648 && constraints.maxWidth < 800) {
          log("Semi Meduim Device");

          return semiMediumDevice ?? mediumDevice;
        } else {
          log("Large Device");
          return largeDevice;
        }
      },
    );
  }
}
