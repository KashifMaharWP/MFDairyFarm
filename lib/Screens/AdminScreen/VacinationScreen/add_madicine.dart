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

import '../../../Providers/Medical/add_medical.dart';

class AddMedicine extends StatefulWidget {
  String id = '';
  AddMedicine({super.key, required this.id});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  DateTime? pickedDate;
  TextEditingController cowId = TextEditingController();
  TextEditingController datepiker = TextEditingController();
  TextEditingController medicine = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<MilkProvider>(context).isLoading;
    cowId.text = widget.id;
    // final provider = Provider.of<AnimalRegistratinProvider>(context);
    String token =
        Provider.of<UserDetail>(context, listen: false).token.toString();
    print("Token $token");
    return Scaffold(
      appBar: AppBar(
        title: Text1(
          fontColor: whiteColor,
          fontSize: header4,
          text: "Add Madical Record",
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
                title: "Add Medicine",
                on_Tap: () async {
                  datepiker.text =
                      DateFormat("EEE MMM dd yyyy").format(selectedDate);
                  await Provider.of<AddMedical>(context, listen: false)
                      .addMedicalRecord(
                          cowId: cowId.text,
                          date: datepiker.text,
                          medical: medicine.text,
                          context: context);
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
            // customTextFormField("Cow ID", CupertinoIcons.tag_fill),
            // TextFieldWidget1(
            //   isReadOnly: true,
            //   widgetcontroller: cowId,
            //   fieldName: "Cow Id",
            //   isPasswordField: false,
            // ),
            SizedBox(height: paragraph),
            Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                const Icon(Icons.calendar_month),
                Text1(fontColor: blackColor, fontSize: header6, text: "Date"),
              ],
            ),
            dateContainer(),
            SizedBox(height: paragraph),
            customTextFormField("Medical", "lib/assets/medical.png"),
            TextFieldWidget1(
              // keyboardtype: TextInputType.number,
              widgetcontroller: medicine,
              fieldName: "Type of Vacine",
              isPasswordField: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextFormField(String text, String customIcon) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Image.asset(customIcon,width: 20,),
        Text1(fontColor: blackColor, fontSize: header6, text: text),
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
                fontSize: paragraph ,
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
