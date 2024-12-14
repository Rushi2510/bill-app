import 'package:bill_app/constants/colors.dart';
import 'package:bill_app/localization/strings.dart';
import 'package:bill_app/pages/bill_page.dart';
import 'package:bill_app/widgets/gradient_app_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> billRecords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text(AppStrings.homeScreen),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: billRecords.length,
        itemBuilder: (context, index) {
          final record = billRecords[index];
          return Card(
            color: AppColors.secondary,
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.white,
                child: Text('${index + 1}'),
              ),
              title: RichText(
                text: TextSpan(
                  text: "Total Amount: ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.textPrimary),
                  children: <TextSpan>[
                    TextSpan(
                      text: "${record['totalAmount']}/-",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                  text: "Date: ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.textPrimary),
                  children: <TextSpan>[
                    TextSpan(
                      text: "${record['date'].toString().split(' ')[0]}",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              trailing: Text(
                (record['isPaid'] ?? false)
                    ? AppStrings.paid
                    : AppStrings.unpaid,
                style: TextStyle(
                  color: (record['isPaid'] ?? false)
                      ? AppColors.green
                      : AppColors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BillScreen()),
          );

          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              billRecords.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
