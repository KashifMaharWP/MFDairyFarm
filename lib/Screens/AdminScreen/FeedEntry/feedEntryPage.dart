import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Functions/customDatePicker.dart';

class feedEntryPage extends StatefulWidget {
  const feedEntryPage({super.key});

  @override
  State<feedEntryPage> createState() => _feedEntryPageState();
}

class _feedEntryPageState extends State<feedEntryPage> {
  TextEditingController wanda=TextEditingController();
  TextEditingController purchasedPrice=TextEditingController();
  TextEditingController breadType=TextEditingController();
  List<String> tagIDList=["1", "2", "3", "4"];
  String? dropDownItem;
  String animalIdDropDownValue="1";
  DateTime selectedDate=DateTime.now();



  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
          child:Column(
            children: [
              Text1(fontColor: darkGreenColor, fontSize: paragraph, text: "Add Feed"),
              SizedBox(height: paragraph/6,),
              customForm(),
            ],
          )
      ),
    );
  }

  // Form for Data Entry
  Widget customForm(){
    return Padding(padding: EdgeInsets.all(paragraph/6),
      child: Form(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextFormField("Wanda",Icons.grass ),
                TextFieldWidget1(
                    widgetcontroller: wanda,
                    fieldName: "Wanda-(kg)",
                    isPasswordField: false
                ),
                SizedBox(height: paragraph,),

                customTextFormField("Date",CupertinoIcons.calendar),
                dateContainer()
              ],
            ),
          )),
    );
  }

//Custom Date Container
Widget dateContainer(){
    return InkWell(
      onTap: ()async{
        final DateTime? pickedDate=await customDatePicker(context, selectedDate);
        if(pickedDate!=null){
          setState(() {
            selectedDate=pickedDate as DateTime;
          });
        }
        },
      child: Container(
        padding: EdgeInsets.all(paragraph-7),
        width:screenWidth ,
        height: screenHeight/14,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            border: Border.all(color: CupertinoColors.systemGrey,width: 1),
            borderRadius: BorderRadius.circular(paragraph-10),
            boxShadow: [
              BoxShadow(
                  color: CupertinoColors.systemGrey3,
                  offset: Offset(0, 2),
                  blurRadius: 8
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text1(fontColor: blackColor, fontSize: paragraph-3, text: DateFormat("dd / MM / yyyy").format(selectedDate)),
            Icon(CupertinoIcons.calendar,color: darkGreenColor,)
          ],
        ),
      ),
    );
}
//custom Text Form for Input entry
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
