import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/float_button_widget.dart';
import 'package:kshethra_mini/view/widgets/build_text_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';
import '../utils/app_color.dart';
import '../utils/app_styles.dart';
import '../utils/components/responsive_layout.dart';
import '../utils/components/size_config.dart';

class AdvancedBookingPreviewView extends StatelessWidget {
  final String selectedRepMethod;
  final List<String> selectedDays;
  final int totalAmount;

  const AdvancedBookingPreviewView({
    super.key,
    required this.selectedRepMethod,
    required this.selectedDays,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final bookingViewmodel = Provider.of<BookingViewmodel>(context, listen: false);
    final total = bookingViewmodel.totalBookingAmount;
    return Scaffold(
      floatingActionButton: ResponsiveLayout(
        pinelabDevice: FloatButtonWidget(
          amount: total,
          title: 'Advanced Booking',
          noOfScreens: 4,
        ),
        mediumDevice: FloatButtonWidget(
          height: 65,
          amount: total,
          title: 'Advanced Booking',
          noOfScreens: 4,
        ),
        largeDevice: FloatButtonWidget(
          height: 75,
          amount: total,
          title: 'Advanced Booking',
          noOfScreens: 4,
        ),
      ),

      body: Column(
        children: [
          const AppBarWidget(title: "Advanced Booking"),
          AdvPreViewWidget(
            page: 'advanced booking',
            selectedRepMethod: selectedRepMethod,
            selectedDays: selectedDays,
            // totalAmount: totalAmount,
          ),
        ],
      ),
    );
  }
}

class AdvPreViewWidget extends StatelessWidget {
  final String page;
  final String selectedRepMethod;
  final List<String> selectedDays;
  // final int totalAmount;

  const AdvPreViewWidget({
    super.key,
    required this.page,
    required this.selectedRepMethod,
    required this.selectedDays,
    // required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {

    AppStyles styles = AppStyles();
    SizeConfig().init(context);

    return Consumer<BookingViewmodel>(
      builder: (context, bookingViewmodel, child) {
        final bookings = bookingViewmodel.vazhipaduBookingList;

        return SizedBox(
          height: SizeConfig.screenHeight * 0.8,
          width: SizeConfig.screenWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kLightPrimaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          booking.name.toString(),
                          style: styles.blackRegular15,
                        ),
                        Text(
                          bookings[index].star.toString(),
                          style: styles.blackRegular15,
                        ),
                        // Text(
                        //   page == "booking" ? (booking.star ?? "") : (booking.option ?? ""),
                        //   style: styles.blackRegular13,
                        // ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  BuildTextWidget(
                                    text: booking.vazhipadu!.tr(),
                                    size: 14,
                                    color: kBlack,
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    " ${bookings[index].count} times",
                                    style: styles.blackRegular13,
                                  ),
                                  // SizedBox(width: 5,),
                                  Text(
                                    "₹ ${booking.totalPrice ?? '0'}",
                                    style: styles.blackRegular15,
                                  ),
                                  SizedBox(width: 8,),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: kRed,
                                            ),
                                            onPressed: () {
                                                bookingViewmodel.advBookingDelete(index);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              bookingViewmodel.popFunction(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              BuildTextWidget(
                                text: booking.godname.toString(),
                                size: 14,
                                color: kBlack,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  BuildTextWidget(
                                    text: "Repeat: $selectedRepMethod",
                                    size: 14,
                                    color: kBlack,
                                  ),
                                  const SizedBox(width: 10),
                                  if (selectedRepMethod != "Once")
                                    Text(
                                      "${bookingViewmodel.repeatDays} times",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: kBlack,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  BuildTextWidget(
                                    text:
                                    " Postal Charges: ₹${bookingViewmodel.postalAmount}",
                                    size: 14,
                                    color: kBlack,
                                  ),
                                ],
                              ),
                              if (selectedRepMethod != "Once" &&
                                  selectedDays.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      spacing: 8.0,
                                      children: selectedDays
                                          .map((day) => Chip(
                                        label: Text(day),
                                        backgroundColor: kLightPrimaryColor
                                            .withOpacity(0.8),
                                      ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),



          ),
        );
      },
    );
  }
}
