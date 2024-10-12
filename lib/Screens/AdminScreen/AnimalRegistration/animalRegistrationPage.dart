import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimalRegistrationPage extends StatefulWidget {
  const AnimalRegistrationPage({super.key});

  @override
  State<AnimalRegistrationPage> createState() => _AnimalRegistrationPageState();
}

class _AnimalRegistrationPageState extends State<AnimalRegistrationPage> {
  TextEditingController tagId = TextEditingController();
  TextEditingController purchasedPrice = TextEditingController();
  TextEditingController breadType = TextEditingController();
  List<String> tagIDList = ["1", "2", "3", "4"];
  String? dropDownItem;
  String animalIdDropDownValue = "1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text1(
                  fontColor: darkGreenColor,
                  fontSize: paragraph,
                  text: "Register Animal"),
              SizedBox(
                height: paragraph / 6,
              ),
              Container(
                margin: EdgeInsets.all(paragraph / 6),
                padding: const EdgeInsets.only(right: 10, left: 10),
                width: screenWidth,
                height: screenHeight / 16,
                decoration: BoxDecoration(
                    border: Border.all(color: darkGreenColor, width: 1),
                    borderRadius:
                        BorderRadius.all(Radius.circular(paragraph / 6))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text1(
                        fontColor: lightBlackColor,
                        fontSize: paragraph / 1.2,
                        text: "No Picture Selected"),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          CupertinoIcons.camera_fill,
                          color: darkGreenColor,
                          size: header1 * 1.5,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: paragraph / 2,
              ),
              customForm(),
            ],
          ),
        ));
  }

  Widget customForm() {
    return Padding(
      padding: EdgeInsets.all(paragraph / 6),
      child: Form(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFormField("Animal Id", CupertinoIcons.tag_fill),
            DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ))),
                value: animalIdDropDownValue,
                items: tagIDList.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownItem = newValue;
                  });
                }),
            SizedBox(
              height: paragraph,
            ),
            customTextFormField(
                "Breed Type", CupertinoIcons.arrow_3_trianglepath),
            TextFieldWidget1(
                widgetcontroller: breadType,
                fieldName: "Breed Type",
                isPasswordField: false),
            SizedBox(
              height: paragraph,
            ),
            customTextFormField(
                "Purchase Price", CupertinoIcons.money_dollar_circle_fill),
            TextFieldWidget1(
                widgetcontroller: purchasedPrice,
                fieldName: "Purchase Price",
                isPasswordField: false)
          ],
        ),
      )),
    );
  }

  Widget customTextFormField(String text, IconData customIcon) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Icon(
          customIcon,
          color: darkGreenColor,
        ),
        Text1(fontColor: blackColor, fontSize: paragraph, text: text),
      ],
    );
  }
}
