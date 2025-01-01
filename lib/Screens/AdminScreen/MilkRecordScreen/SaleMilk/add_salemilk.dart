import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';

import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Functions/customDatePicker.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';

import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class AddMilkSale extends StatefulWidget {
  
  AddMilkSale({super.key,});

  @override
  State<AddMilkSale> createState() => _AddMilkSaleState();
}

class _AddMilkSaleState extends State<AddMilkSale> {
  DateTime? pickedDate;
  TextEditingController venderName = TextEditingController();
  TextEditingController milkAmount = TextEditingController();
  TextEditingController datepiker = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<MilkProvider>(context).isLoading;
   
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
              // Text1(
              //   fontColor: darkGreenColor,
              //   fontSize: paragraph,
              //   text: "Add Morning Milk",
              // ),
              SizedBox(height: paragraph / 6),
              customForm(),
              SizedBox(height: paragraph / 2),
              customRoundedButton(
                loading: isLoading,
                title: "Sale Milk",
                on_Tap: () async {
                  datepiker.text =
                      DateFormat("EEE MMM dd yyyy").format(selectedDate);
                 await Provider.of<MilkProvider>(context,listen: false).saleMilk(venderName: venderName.text, date: datepiker.text, milkAmount: milkAmount.text, totalAmount: totalAmount.text, context: context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customForm() {
    return Padding(
      padding: EdgeInsets.all(paragraph / 6),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFormField("Vender Name", CupertinoIcons.person),
            TextFieldWidget1(
             
              widgetcontroller: venderName,
              fieldName: "Vender Name",
              isPasswordField: false,
            ),
            SizedBox(height: paragraph),
            customTextFormField("Date", CupertinoIcons.calendar),
            dateContainer(),
            SizedBox(height: paragraph),
            customTextFormField("Milk Amount",Icons.view_list),
            TextFieldWidget1(
              // keyboardtype: TextInputType.number,
              widgetcontroller: milkAmount,
              fieldName: "Milk Amount",
              isPasswordField: false,
            ),
             SizedBox(height: paragraph),
            customTextFormField("Payment", CupertinoIcons.money_dollar),
            TextFieldWidget1(
              // keyboardtype: TextInputType.number,
              widgetcontroller: totalAmount,
              fieldName: "Milk price",
              isPasswordField: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextFormField(String text, IconData customIcon) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
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
        width: screenWidth,
        height: screenHeight / 14,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            border: Border.all(color: CupertinoColors.systemGrey, width: 1),
            borderRadius: BorderRadius.circular(paragraph - 10),
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
                fontColor: blackColor,
                fontSize: paragraph - 3,
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

//custom Text Form for Input entry
}
