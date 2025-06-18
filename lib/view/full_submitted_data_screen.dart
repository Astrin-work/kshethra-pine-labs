import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/booking_viewmodel.dart';

class FullSubmittedDataScreen extends StatelessWidget {
  const FullSubmittedDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedList = context.watch<BookingViewmodel>().submittedGroups;

    return Scaffold(
      appBar: AppBar(title: const Text("Submitted Receipts")),
      body: groupedList.isEmpty
          ? const Center(child: Text("No submitted data"))
          : ListView.builder(
        itemCount: groupedList.length,
        itemBuilder: (context, index) {
          final group = groupedList[index];
          final serial = group['serialNumber'];
          final receipts = group['receipts'] as List;

          return Card(
            margin: const EdgeInsets.all(10),
            child: ExpansionTile(
              title: Text("Serial No: $serial"),
              children: receipts.map((receipt) {
                return ListTile(
                  title: Text(receipt['offerName'] ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${receipt['personName']}"),
                      Text("Star: ${receipt['personStar']}"),
                      Text("Quantity: ${receipt['quantity']}"),
                      Text("Rate: ₹${receipt['rate']}"),
                      Text("Offer Date: ${receipt['offerDate']}"),
                    ],
                  ),
                  trailing: Text(
                    "₹${(receipt['quantity'] ?? 1) * (receipt['rate'] ?? 0)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
