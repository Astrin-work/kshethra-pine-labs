import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';

class DialogBoxWidget extends StatelessWidget {
  final String title;
  final String fButton;
  final void Function()? fOnTap;
  final String sButton;
  final void Function()? sOnTap;

  const DialogBoxWidget({
    super.key,
    required this.title,
    required this.fButton,
    required this.fOnTap,
    required this.sButton,
    required this.sOnTap,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    return AlertDialog(
      title: Column(
        children: [
          Text(title, style: styles.blackRegular18),
          15.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: MaterialButton(
                  height: 42,
                  onPressed: fOnTap,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: kBlack),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FittedBox(
                    child: Text(fButton, style: styles.blackRegular15),
                  ),
                ),
              ),
              15.kW,
              Flexible(
                child: MaterialButton(
                  height: 42,
                  onPressed: sOnTap,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: kBlack),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FittedBox(
                    child: Text(sButton, style: styles.blackRegular15),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
