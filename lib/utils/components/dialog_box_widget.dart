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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                minWidth: 85,
                height: 42,
                onPressed: fOnTap,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: kBlack),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(fButton, style: styles.blackRegular15),
              ),
              MaterialButton(
                minWidth: 85,
                height: 42,
                onPressed: sOnTap,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: kBlack),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(sButton, style: styles.blackRegular15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
