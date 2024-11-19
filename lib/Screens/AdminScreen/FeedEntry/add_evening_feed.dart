import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';

import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Functions/customDatePicker.dart';
import 'package:dairyfarmflow/Providers/FeedProviders/feed_provider.dart';
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

class AddEveningFeed extends StatefulWidget {
  //String id = '';
  const AddEveningFeed({
    super.key,
  });

  @override
  State<AddEveningFeed> createState() => _AddEveningFeedState();
}

class _AddEveningFeedState extends State<AddEveningFeed> {
  DateTime? pickedDate;
  TextEditingController cowId = TextEditingController();
  TextEditingController datepiker = TextEditingController();
  TextEditingController evening = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<FeedProvider>(context).isLoading;
    //cowId.text = widget.id;
    // final provider = Provider.of<AnimalRegistratinProvider>(context);
    String token =
        Provider.of<UserDetail>(context, listen: false).token.toString();
    print("Token " + token);
    return Scaffold(
      appBar: AppBar(
        title: Text1(
          fontColor: whiteColor,
          fontSize: header4,
          text: "Add Evening Feed",
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
              customForm(),
              SizedBox(height: paragraph / 2),
              customRoundedButton(
                loading: isLoading,
                title: "Add Feed",
                on_Tap: () async {
                  FocusScope.of(context).unfocus();
                  datepiker.text =
                      DateFormat("EEE MMM dd yyyy").format(selectedDate);
                  await Provider.of<FeedProvider>(context, listen: false)
                      .sendEveningFeedData(
                          context: context,
                          date: datepiker.text,
                          evening: evening.text);
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
            customTextFormField("Date", CupertinoIcons.calendar),
            dateContainer(),
            SizedBox(height: paragraph),
            customTextFormField("Evening Feed", CupertinoIcons.calendar),
            TextFieldWidget1(
              keyboardtype: TextInputType.number,
              widgetcontroller: evening,
              fieldName: "Add Feed(5kg)",
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
