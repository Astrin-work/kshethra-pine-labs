import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/asset/assets.gen.dart';
import '../../../utils/components/size_config.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final VoidCallback onConfirm;
  final String buttonText;
  final double? height;
  final double? width;

  const ConfirmButtonWidget({
    super.key,
    required this.onConfirm,
    this.buttonText = "Confirm Payment",
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: SizedBox(
        width: width ?? double.infinity,
        height: height ?? SizeConfig.screenWidth * 0.135,
        child: InkWell(
          onTap: onConfirm,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(Assets.images.homeBackground.path),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: styles.whiteSemi15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
