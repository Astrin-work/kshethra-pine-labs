import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/build_text_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

class GodWidget extends StatefulWidget {
  const GodWidget({super.key});

  @override
  State<GodWidget> createState() => _GodWidgetState();
}

class _GodWidgetState extends State<GodWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<BookingViewmodel>(context, listen: false).fetchGods());
  }

  @override
  Widget build(BuildContext context) {
    // final currentLang = Provider.of<HomePageViewmodel>(context).currentLanguage;
    // AppStyles styles = AppStyles();
    SizeConfig().init(context);

    return Consumer<BookingViewmodel>(
      builder: (context, bookingViewmodel, child) {
        final godList = bookingViewmodel.gods;
        final isLoading = bookingViewmodel.isLoading;
        final fromLang = "en";
        if (isLoading) {
          return const Center(child: CircularProgressIndicator(color: kDullPrimaryColor,));
        }
        return SizedBox(
          height: SizeConfig.screenHeight * 0.280,
          width: SizeConfig.screenWidth,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: godList.length,
            itemBuilder: (context, index) {
              final itemWidth = (SizeConfig.screenWidth - 20) / 4;

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        bookingViewmodel.setGod(godList[index]);
                        print('------pressed-------');
                      },
                      child: Container(
                        height: SizeConfig.screenHeight * 0.200,
                        width: itemWidth,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: bookingViewmodel.selectedGods == godList[index]
                                  ? kPrimaryColor
                                  : kTransparent,
                              blurRadius: 5,
                              spreadRadius: 5,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/img.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(godList[index].devathaImage),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: itemWidth,
                      child: Align(
                        alignment: Alignment.center,
                        child: BuildTextWidget(
                          text: godList[index].devathaName,
                          fromLang: fromLang,
                          size: 13,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );

      },
    );
  }
}

