import 'package:bill_app/constants/colors.dart';
import 'package:bill_app/localization/strings.dart';
import 'package:bill_app/pages/summary_page.dart';
import 'package:bill_app/widgets/gradient_app_bar.dart';
import 'package:flutter/material.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final _formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var numberController = TextEditingController();
  var itemNameController = TextEditingController();
  var quantityController = TextEditingController();
  var unitPriceController = TextEditingController();

  List<Map<String, dynamic>> itemList = [];
  double totalUnitPrice = 0;
 

  void _addItem() {
    if (itemNameController.text.isNotEmpty &&
        quantityController.text.isNotEmpty &&
        unitPriceController.text.isNotEmpty) {
      final item = {
        'itemName': itemNameController.text,
        'quantity': int.parse(quantityController.text),
        'unitPrice': double.parse(unitPriceController.text),
      };

      setState(() {
        itemList.add(item);
       totalUnitPrice += double.parse(item['unitPrice'].toString());

      });

      // Clear the text fields
      itemNameController.clear();
      quantityController.clear();
      unitPriceController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(AppStrings.pleaseFillAllItemDetails)),
      );
    }
  }

 void _navigateToSummaryScreen() {
  if (_formKey.currentState!.validate()) {
    if (itemList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.plsAddAtLeastOneItem)),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          name: nameController.text,
          contactNumber: numberController.text,
          itemList: itemList,
          totalUnitPrice: totalUnitPrice,
        ),
      ),
    ).then((result) {
      if (result != null && result is Map<String, dynamic>) {
        Navigator.pop(context, {
          'totalAmount': result['totalAmount'],
          'date': result['date'],
          'isPaid': result['isPaid'], // Forward the isPaid value
        });
      }
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: GradientAppBar(
        title: Text(AppStrings.billScreen),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  AppStrings.customerDetails,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontStyle: FontStyle.italic, color: AppColors.colorScheme),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 5,
                  color: AppColors.secondary,
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name ,
                    decoration:  InputDecoration(
                      border: InputBorder.none ,
                      hintText: AppStrings.name,
                      contentPadding: EdgeInsets.only(left: 5)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.nameCanNotBeEmpty;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 5,
                  color: AppColors.secondary,
                  child: TextFormField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStrings.contactNumber,
                      contentPadding: EdgeInsets.only(left: 5)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.contactNoCanNotBeEmpty;
                      }
                      if (value.length != 10) {
                        return AppStrings.contactNoMustBe10Digit;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppStrings.addItems,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontStyle: FontStyle.italic, color: AppColors.colorScheme),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 5,
                  color: AppColors.secondary,
                  child: TextFormField(
                    controller: itemNameController,
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 5),
                      hintText: AppStrings.itemName,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 5,
                  color: AppColors.secondary,
                  child: TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 5),
                      hintText: AppStrings.quantity,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  color: AppColors.secondary,
                  elevation: 5,
                  child: TextFormField(
                    controller: unitPriceController,
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 5),
                      hintText: AppStrings.unitPrice,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.colorScheme)
                  ),
                  onPressed: _addItem,
                  child: const Text(AppStrings.add),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                  
                    onPressed: _navigateToSummaryScreen,
                    child: const Text(AppStrings.save),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

