import 'package:bill_app/constants/colors.dart';
import 'package:bill_app/localization/strings.dart';
import 'package:bill_app/widgets/gradient_app_bar.dart';
import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  final String name;
  final String contactNumber;
  final List<Map<String, dynamic>> itemList;
  final double totalUnitPrice;

  const SummaryScreen({
    super.key,
    required this.name,
    required this.contactNumber,
    required this.itemList,
    required this.totalUnitPrice,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  bool isPaid = false; // Default toggle state is unpaid

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text(AppStrings.summary),
        actions: [
          Switch(
            value: isPaid,
            onChanged: (value) {
              setState(() {
                isPaid = value;
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Details',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontStyle: FontStyle.italic, color: AppColors.colorScheme),
            ),
            RichText(
              text: TextSpan(
                text: "Name: ",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: " ${widget.name}",
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: "Contact Number: ",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: " ${widget.contactNumber}",
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Items',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontStyle: FontStyle.italic, color: AppColors.colorScheme),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.itemList.length,
                itemBuilder: (context, index) {
                  final item = widget.itemList[index];
                  return Card(
                    elevation: 5,
                    color: AppColors.secondary,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.white,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(item['itemName']),
                      subtitle: Text('Quantity: ${item['quantity']}'),
                      trailing: Text('Price: ${item['unitPrice']}'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Unit Price: ${widget.totalUnitPrice}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: AppColors.black),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'totalAmount': widget.totalUnitPrice,
                    'date': DateTime.now(),
                    'isPaid': isPaid, // Include toggle state
                  });
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
