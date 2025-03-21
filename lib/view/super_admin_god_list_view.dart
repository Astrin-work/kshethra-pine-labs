import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/demo_model/e_hundi_model.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class SuperAdminGodListView extends StatelessWidget {
  const SuperAdminGodListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 25,
              crossAxisSpacing: 30,
              crossAxisCount: 2,
            ),
            itemCount: hundiList.length,
            itemBuilder: (context, index) {
              return Consumer<HomePageViewmodel>(
                builder:
                    (context, homepageViewmodel, child) => InkWell(
                      onTap: () {
                        homepageViewmodel.stringImageToUint(
                          hundiList[index].godImg!,
                        );
                        homepageViewmodel.popFunction(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(hundiList[index].godImg!),
                          ),
                        ),
                      ),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
