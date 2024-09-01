import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class animalRegistrationPage extends StatefulWidget {
  const animalRegistrationPage({super.key});

  @override
  State<animalRegistrationPage> createState() => _animalRegistrationPageState();
}

class _animalRegistrationPageState extends State<animalRegistrationPage> {
  TextEditingController tagId=TextEditingController();
  TextEditingController purchasedPrice=TextEditingController();
  TextEditingController breadType=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Container(
        child: Column(
          children: [
            customForm(),
            customRoundedButton(
                title: "Save",
                on_Tap: (){}
            )
          ],
        ),
      )
    );
  }

  Widget customForm(){
    return Padding(padding: EdgeInsets.all(paragraph),
      child: Form(
        child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFormField("Animal Id",CupertinoIcons.tag_fill ),
            TextFieldWidget1(
                widgetcontroller: tagId,
                fieldName: "Animal Id or Name",
                isPasswordField: false
            ),
            SizedBox(height: paragraph,),
            customTextFormField("Breed Type",CupertinoIcons.arrow_3_trianglepath),
            TextFieldWidget1(
                widgetcontroller: breadType,
                fieldName: "Breed Type",
                isPasswordField: false
            ),
            SizedBox(height: paragraph,),
            customTextFormField("Purchase Price",CupertinoIcons.money_dollar_circle_fill),
            TextFieldWidget1(
                widgetcontroller: purchasedPrice,
                fieldName: "Purchase Price",
                isPasswordField: false
            )
          ],
        ),
    )),
    );
  }
  
  Widget customTextFormField(String text,IconData customIcon){
    return  Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Icon(customIcon,color: darkGreenColor,),
        Text1(
            fontColor: blackColor,
            fontSize: paragraph,
            text: text
        ),
      ],
    );
  }
}
