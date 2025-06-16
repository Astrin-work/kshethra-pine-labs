import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_styles.dart';


class ChoosePaymentMethodEHundiWidget extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String> onMethodSelected;

  const ChoosePaymentMethodEHundiWidget({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    AppStyles styles = AppStyles();

    final List<Map<String, dynamic>> paymentMethods = [
      {'label': 'UPI', 'icon': Icons.qr_code},
      {'label': 'Card', 'icon': Icons.credit_card},
    ];

    return Column(
      children:
      paymentMethods.map((method) {
        final isSelected = selectedMethod == method['label'];
        return GestureDetector(
          onTap: () {
            onMethodSelected(method['label']);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
              isSelected
                  ? kDullPrimaryColor.withOpacity(0.2)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? kPrimaryColor : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(method['icon'], color: kPrimaryColor, size: 28),
                const SizedBox(width: 15),
                Text(method['label'], style: styles.blackRegular15),
                const Spacer(),
                if (isSelected)
                  const Icon(Icons.check_circle, color: kPrimaryColor),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
