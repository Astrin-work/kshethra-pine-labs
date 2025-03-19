import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/booking_model.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

class GodWidget extends StatelessWidget {
  const GodWidget({super.key});

  @override
  Widget build(BuildContext context) {
     AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return SizedBox(
       height: 140,
      width: SizeConfig.screenWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<BookingViewmodel>(
              builder:
                  (context, bookingViewmodel, child) => Column(
                    children: [
                      InkWell(
                        onTap: () {
                          bookingViewmodel.setGod(bList[index]);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color:
                                    bookingViewmodel.selectedGod == bList[index]
                                        ? kPrimaryColor
                                        : kTransparent,
                                blurRadius: 5,
                                spreadRadius: 5,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(bList[index].godImg ?? ""),
                            ),
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          bList[index].god ?? "",
                          style: styles.blackRegular15,
                        ),
                      ),
                    ],
                  ),
            ),
          );
        },
      ),
    );
  }
}
