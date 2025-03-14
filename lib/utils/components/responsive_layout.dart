import 'dart:developer';

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget pinelabDevice;
  final Widget mediumDevice;
  final Widget largeDevice; 
  const ResponsiveLayout({super.key, required this.pinelabDevice, required this.mediumDevice, required this.largeDevice});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      log(constraints.maxWidth.toString(),name: "Max Width");
      if(constraints.maxWidth<450){
        log("Pinelab Device");
        return pinelabDevice;
      }else if(constraints.maxWidth>450&&constraints.maxWidth<800)
      {
        log("Medium Device");

        return mediumDevice;
      }
      else{
        log("Large Device");

        return largeDevice;
        
      }
    });
  }
}