import 'package:flutter/material.dart';
import 'package:kshethra_mini/utils/app_styles.dart';
import 'package:kshethra_mini/utils/components/size_config.dart';
import 'package:kshethra_mini/view/payment_complete_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeComponent extends StatelessWidget {
  final String amount;
  final String paymentLink;
  const QrCodeComponent({
    super.key,
    required this.amount,
    required this.paymentLink,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();
    SizeConfig().init(context);
    return SizedBox(
      height: SizeConfig.screenHeight * 0.7,
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Amount : ₹ $amount", style: styles.blackRegular22),
          Text("Scan this QR Code to Pay", style: styles.blackRegular18),
          SizedBox(
            child: QrImageView(
              data: paymentLink,
              version: QrVersions.auto,
              size: 300.0,
            ),
          ),
          Text("demotemple@okicici", style: styles.blackRegular13),
          MaterialButton(
            child: Text("data"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentCompleteScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

