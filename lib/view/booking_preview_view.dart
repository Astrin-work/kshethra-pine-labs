  import 'package:easy_localization/easy_localization.dart';
  import 'package:flutter/material.dart';
  import 'package:kshethra_mini/utils/app_styles.dart';
  import 'package:kshethra_mini/utils/components/app_bar_widget.dart';
  import 'package:kshethra_mini/utils/components/responsive_layout.dart';
  import 'package:kshethra_mini/utils/components/size_config.dart';
  import 'package:kshethra_mini/view/widgets/booking_page_widget/booking_action_bar.dart';
  import 'package:kshethra_mini/view/widgets/booking_page_widget/float_button_widget.dart';
  import 'package:kshethra_mini/view/widgets/build_text_widget.dart';
  import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
  import 'package:provider/provider.dart';

  class BookingPreviewView extends StatelessWidget {
    final String page;

    const BookingPreviewView({
      super.key,
      required this.page,
      required String selectedRepMethod,
    });

    @override
    Widget build(BuildContext context) {
      SizeConfig().init(context);
      return Scaffold(
        floatingActionButton: ResponsiveLayout(
          pinelabDevice: BookingActionBar(title: 'Booking', noOfScreens: 4),
          mediumDevice: BookingActionBar(
            title: 'Booking',
            noOfScreens: 4,
            height: 65,
          ),
          largeDevice: BookingActionBar(
            title: 'Booking',
            noOfScreens: 4,
            height: 75,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(title: "Vazhipaddu".tr()),
              PreViewWidget(page: page),
            ],
          ),
        ),
      );
    }
  }

  class PreViewWidget extends StatelessWidget {
    final String page;

    const PreViewWidget({super.key, required this.page});

    @override
    Widget build(BuildContext context) {
      AppStyles styles = AppStyles();
      SizeConfig().init(context);
      final fromLang = "en";
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
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color:  Color(0xFFFFF8E1),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BuildTextWidget(
                                  text: "Vazhipadu :    ${booking.vazhipadu ?? ''}",
                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                  fromLang: fromLang,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.cancel, color: Colors.red),
                                  onPressed: () {
                                    bookingViewmodel.vazhipaduDelete(index);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: BuildTextWidget(
                                    text: "Qty",
                                    style: styles.blackRegular13,

                                  ),
                                ),
                                const Text(":"),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: BuildTextWidget(
                                    text: "${booking.count ?? '0'}",
                                    style: styles.blackRegular13,
                                    fromLang: fromLang,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: BuildTextWidget(
                                    text: "Name".tr(),
                                    style: styles.blackRegular13,
                                    // fromLang: fromLang,
                                  ),
                                ),
                                const Text(":"),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: BuildTextWidget(
                                    text: booking.name ?? '',
                                    style: styles.blackRegular13,
                                    fromLang: fromLang,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: BuildTextWidget(
                                    text: "Star",
                                    style: styles.blackRegular13,
                                    fromLang: fromLang,
                                  ),
                                ),
                                const Text(":"),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: BuildTextWidget(
                                    text: booking.star ?? '',
                                    style: styles.blackRegular13,
                                    fromLang: fromLang,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: BuildTextWidget(
                                    text: "Vazhipadu Date",
                                    style: styles.blackRegular13,
                                    fromLang: fromLang,
                                  ),
                                ),
                                const Text(":"),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: BuildTextWidget(
                                    text: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                    style: styles.blackRegular13,
                                    fromLang: fromLang,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                BuildTextWidget(
                                  text: "Amount: ₹ ${booking.totalPrice ?? '0'}",
                                  style: styles.blackRegular13,
                                  fromLang: fromLang,
                                ),
                              ],
                            ),
                          ],
                        ),
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
