import 'package:flutter/material.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/asset/assets.gen.dart';
import '../../../utils/components/size_config.dart';

class ConfirmButtonWidget extends StatefulWidget {
  final Future<void> Function() onConfirm;
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
  State<ConfirmButtonWidget> createState() => _ConfirmButtonWidgetState();
}

class _ConfirmButtonWidgetState extends State<ConfirmButtonWidget> {
  bool _isLoading = false;

  Future<void> _handleTap() async {
    setState(() => _isLoading = true);
    await widget.onConfirm();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? SizeConfig.screenWidth * 0.135,
        child: InkWell(
          onTap: _isLoading ? null : _handleTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(Assets.images.homeBackground.path),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: _isLoading
                  ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
                  : Text(
                widget.buttonText,
                style: styles.whiteSemi15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
