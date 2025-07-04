import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/api%20models/god_model.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/widgets/build_text_widget.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:provider/provider.dart';

class VazhipadduWidget extends StatelessWidget {
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final int crossAxisCount;
  final String screeName;

  const VazhipadduWidget({
    super.key,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.crossAxisCount,
    required this.screeName,
    required int selectedCategoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    const fromLang = "en";
    return Consumer<BookingViewmodel>(
      builder: (context, bookingViewmodel, _) {
        final selectedGod = bookingViewmodel.selectedGods;
        if (selectedGod == null || selectedGod.counters.isEmpty) {
          return const Center(child: Text("No vazhipadu available"));
        }

        final currentCategoryIndex = screeName == "bookingPage"
            ? bookingViewmodel.selectedCategoryIndex
            : bookingViewmodel.selectedAdvancedBookingCategoryIndex;

        List<Vazhipadus> vazhipadus = [];
        if (currentCategoryIndex == 0) {
          for (var counter in selectedGod.counters) {
            vazhipadus.addAll(counter.vazhipadus);
          }
        } else {
          final counterIndex = currentCategoryIndex - 1;
          if (counterIndex >= 0 && counterIndex < selectedGod.counters.length) {
            vazhipadus = selectedGod.counters[counterIndex].vazhipadus;
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30  ,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedGod.counters.length + 1,
                itemBuilder: (context, index) {
                  final isAllSelected = index == 0;
                  final isSelected = index == currentCategoryIndex;
                  final title = isAllSelected
                      ? "All"
                      : selectedGod.counters[index - 1].counterName;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      label: Text(title),
                      selected: isSelected,
                      onSelected: (_) {
                        if (screeName == "bookingPage") {
                          bookingViewmodel.setSelectedCategoryIndex(index);
                        } else {
                          bookingViewmodel
                              .setSelectedAdvancedBookingCategoryIndex(index);
                        }
                      },
                      selectedColor: Colors.orange.shade100,
                      backgroundColor: Colors.grey.shade200,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.deepOrange : Colors.black,
                        // fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            vazhipadus.isEmpty
                ? const Center(child: Text("No vazhipadu found"))
                : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vazhipadus.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: mainAxisSpacing,
                crossAxisSpacing: crossAxisSpacing,
                childAspectRatio: 0.90,
              ),
              itemBuilder: (context, index) {
                final item = vazhipadus[index];
                final isSelected =
                    bookingViewmodel.selectedVazhipaddu == item;

                return InkWell(
                  onTap: () {
                    bookingViewmodel.selectVazhipaddu(item);
                    if (screeName == "bookingPage") {
                      bookingViewmodel.showVazhipadduDialogBox(
                          context, item);
                    } else {
                      bookingViewmodel
                          .showAdvancedVazhipadduDialogBox(
                          context, item);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image:
                        AssetImage(Assets.images.homeBackground.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: isSelected ? Colors.orange.shade100 : kWhite,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildTextWidget(
                            text: item.offerName,
                            fromLang: fromLang,
                            textAlign: TextAlign.center,
                            size: 14,
                            fontWeight: FontWeight.w400,
                            maxLines: 3,
                            style: AppStyles().blackRegular13,
                          ),
                          const SizedBox(height: 5),
                          BuildTextWidget(
                            text: "₹ ${item.cost}/-",
                            fromLang: fromLang,
                            textAlign: TextAlign.center,
                            size: 14,
                          ),
                        ],
                      ),
                    ),

                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
