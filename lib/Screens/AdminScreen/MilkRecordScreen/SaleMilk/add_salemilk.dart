import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';

import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Functions/customDatePicker.dart';
import 'package:dairyfarmflow/Model/vendorResponse.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';

import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/MilkRecordScreen/milk_record.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class AddMilkSale extends StatefulWidget {
  
  const AddMilkSale({super.key,});

  @override
  State<AddMilkSale> createState() => _AddMilkSaleState();
}

class _AddMilkSaleState extends State<AddMilkSale> {
  DateTime? pickedDate;
  TextEditingController milkAmount = TextEditingController();
  TextEditingController datepiker = TextEditingController();
  //TextEditingController totalAmount = TextEditingController();
  DateTime selectedDate = DateTime.now();

  String? selectedVendorId; // Store the selected vendor's ID
  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<MilkProvider>(context).isLoading;
    final vendors = Provider.of<MilkProvider>(context).vendors; // Fetch vendors list
    final isVendorLoading = Provider.of<MilkProvider>(context).isLoading;

    String token =
        Provider.of<UserDetail>(context, listen: false).token.toString();
    print("Token $token");

    return Scaffold(
      appBar: AppBar(
        title: Text1(
          fontColor: whiteColor,
          fontSize: header4,
          text: "Add Sale Record",
        ),
        centerTitle: true,
        foregroundColor: whiteColor,
        backgroundColor: darkGreenColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
          child: Column(
            children: [
              SizedBox(height: paragraph / 6),
              customForm(vendors, isVendorLoading), // Pass vendors and loading state
              SizedBox(height: paragraph / 2),
              customRoundedButton(
                loading: isLoading,
                title: "Sale Milk",
                on_Tap: () async {
                  datepiker.text =
                      DateFormat("EEE MMM dd yyyy").format(selectedDate);
                  await Provider.of<MilkProvider>(context, listen: false)
                      .saleMilk(
                    venderId: selectedVendorId ?? "", // Pass the vendor ID
                    date: datepiker.text,
                    milkAmount: milkAmount.text,
                    totalAmount: "0",
                    context: context,
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customForm(List<Vendor> vendors, bool isVendorLoading) {
    return Padding(
      padding: EdgeInsets.all(paragraph / 6),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFormField("Vendor Name", CupertinoIcons.person),
            isVendorLoading
                ? const Center(child: CircularProgressIndicator())
                :DropdownButtonFormField<String>(
  value: selectedVendorId,
  hint: const Text("Select Vendor"),
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // Rounded corners
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey, // Border color
        width: 1.0, // Border width
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black26, // Focused border color
        width: 1.0, // Focused border width
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    filled: true,
    fillColor: Colors.white, // Background color
    contentPadding: EdgeInsets.symmetric(
      vertical: 15.0,
      horizontal: 10.0,
    ), // Padding inside the form field
  ),
  onChanged: (value) {
    setState(() {
      selectedVendorId = value; // Store selected vendor ID
    });
  },
  items: vendors.map((vendor) {
    return DropdownMenuItem<String>(
      value: vendor.id, // Use vendor ID as the value
      child: Text(vendor.name), // Show vendor name
    );
  }).toList(),
),
            SizedBox(height: paragraph),
            customTextFormField("Date", CupertinoIcons.calendar),
            dateContainer(),
            SizedBox(height: paragraph),
            customTextFormField("Milk ltr", Icons.view_list),
            TextFieldWidget1(
              widgetcontroller: milkAmount,
              fieldName: "Milk ltr",
              isPasswordField: false,
            ),
            SizedBox(height: paragraph),
            
          ],
        ),
      ),
    );
  }

  Widget customTextFormField(String text, IconData customIcon) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(customIcon, color: darkGreenColor),
        Text1(fontColor: blackColor, fontSize: paragraph, text: text),
      ],
    );
  }

  Widget dateContainer() {
    return InkWell(
      onTap: () async {
        pickedDate = await customDatePicker(context, selectedDate);
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate as DateTime;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(paragraph - 7),
        width: double.infinity,
        height: screenHeight / 10,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            border: Border.all(color: CupertinoColors.systemGrey, width: 1),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: CupertinoColors.systemGrey3,
                  offset: Offset(0, 2),
                  blurRadius: 8)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text1(
                fontColor: Colors.black,
                fontSize: paragraph,
                text: DateFormat("EEE MMM dd yyyy").format(selectedDate)),
            Icon(
              CupertinoIcons.calendar,
              color: darkGreenColor,
            )
          ],
        ),
      ),
    );
  }
}
