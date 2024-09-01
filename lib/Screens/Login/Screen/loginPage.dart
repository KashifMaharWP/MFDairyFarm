import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:dairyfarmflow/Widget/textFieldWithIconWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Class/textSizing.dart';
import '../../../Widget/Text1.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyGreenColor,
      body: SafeArea(
        child: Column(
          children: [
            pageHeaderContainer(),
            SizedBox(height:screenHeight/15,),
            pageBodyContainer()
          ],
        ),
      )
    );
  }
  Widget pageHeaderContainer(){
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: screenHeight/5),
        child: Image(
            image: AssetImage("lib/assets/Logo.png"),
          width: screenWidth/3,

        )
      ),
    );
  }
  
  Widget pageBodyContainer(){
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(header1),
        width:double.infinity,
        height: screenHeight/1.5,
        decoration: BoxDecoration(
            color: darkGreenColor,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(screenWidth/8),topRight: Radius.circular(screenWidth/8)),
        ),
        child: Column(
          children: [
            Text1(fontColor: whiteColor, fontSize: header1, text: "Sign In to MF Dairy"),
            SizedBox(height: screenHeight/15,),
            customFormLabel("Email"),
            textFieldWithIconWidget(
                widgetcontroller: email,
                fieldName: AutofillHints.email,
                widgeticon: Icons.email_sharp,
                isPasswordField: false
            ),
            SizedBox(height: paragraph,),
            customFormLabel("Password"),
            textFieldWithIconWidget(
                widgetcontroller: password,
                fieldName: "password",
                widgeticon: Icons.lock,
                isPasswordField: true
            ),
            SizedBox(height: header1,),
            customButton("Sign in")
          ],
        ),
      ),
    );
  }

  Widget customFormLabel(String text){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text1(
            fontColor: whiteColor,
            fontSize: header6,
            text: text
        ),
      ],
    );
  }

customButton(String title){
    return  InkWell(
        onTap: (){
          isLoading=true;
        },
        splashColor: darkGreenColor,
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 17,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: greyGreenColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              title,
              style: TextStyle(
                  color: darkGreenColor,
                  fontSize: paragraph,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      );
  }

}
