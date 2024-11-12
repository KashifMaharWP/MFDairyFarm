import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';

import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Functions/customDatePicker.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:dairyfarmflow/Providers/auth_provider.dart';

import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddMorningMilk extends StatefulWidget {
  String id = '';
  AddMorningMilk({super.key, required this.id});

  @override
  State<AddMorningMilk> createState() => _AddMorningMilkState();
}

class _AddMorningMilkState extends State<AddMorningMilk> {
  DateTime? pickedDate;
  TextEditingController cowId = TextEditingController();
  TextEditingController datepiker = TextEditingController();
  TextEditingController morning = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    cowId.text = widget.id;
    // final provider = Provider.of<AnimalRegistratinProvider>(context);
    String token =
        Provider.of<UserDetail>(context, listen: false).token.toString();
    print("Token " + token);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
          child: Column(
            children: [
              Text1(
                fontColor: darkGreenColor,
                fontSize: paragraph,
                text: "Add Morning Milk",
              ),
              SizedBox(height: paragraph / 6),
              customForm(),
              SizedBox(height: paragraph / 2),
              customRoundedButton(
                title: "Add Milk",
                on_Tap: () async {
                  datepiker.text =
                      DateFormat("dd / MM / yyyy").format(selectedDate);
                  Provider.of<MilkProvider>(context, listen: false)
                      .sendMorningMilkData(
                          cowId: cowId.text,
                          date: datepiker.text,
                          morning: morning.text,
                          context: context);
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
            customTextFormField("Cow ID", CupertinoIcons.tag_fill),
            TextFieldWidget1(
              isReadOnly: true,
              widgetcontroller: cowId,
              fieldName: "Cow Id",
              isPasswordField: false,
            ),
            SizedBox(height: paragraph),
            customTextFormField("Date", CupertinoIcons.calendar),
            dateContainer(),
            SizedBox(height: paragraph),
            customTextFormField("Morning Milk", CupertinoIcons.calendar),
            TextFieldWidget1(
              widgetcontroller: morning,
              fieldName: "Add Milk(5kg)",
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
            boxShadow: [
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
                text: DateFormat("dd / MM / yyyy").format(selectedDate)),
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
