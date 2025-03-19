import 'dart:developer';

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget pinelabDevice;
  final Widget mediumDevice;
  final Widget largeDevice;
  final Widget? semiMediumDevice;
  final Widget? semiLargeDevice;
  const ResponsiveLayout({
    super.key,
    required this.pinelabDevice,
    required this.mediumDevice,
    required this.largeDevice,
    this.semiMediumDevice,
    this.semiLargeDevice,
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
        } else if (constraints.maxWidth > 799 && constraints.maxWidth < 1100) {
          log("Semi Meduim Device");

          return semiLargeDevice ?? largeDevice;
        } else {
          log("Large Device");
          return largeDevice;
        }
      },
    );
  }
}
