import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Screens/Dashboard/Dashboard.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWithIconWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Class/textSizing.dart';
import '../../../Widget/Text1.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("lib/assets/mfBackground.png"),fit: BoxFit.cover)
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                pageHeaderContainer(),
                SizedBox(height:screenHeight/15,),
                pageBodyContainer(),
              ],
            ),
          ),
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
    return Container(
      padding: EdgeInsets.all(header1),
      width:double.infinity,
      height: screenHeight/1.8,
      decoration: BoxDecoration(
          color: transGreenColor,
        borderRadius: BorderRadius.only(topLeft:Radius.circular(screenWidth/8),topRight: Radius.circular(screenWidth/8)),
      ),
      child: Column(
        children: [
          Text1(fontColor: whiteColor, fontSize: header1, text: "Sign in"),
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
          customRoundedButton(title: "Sign in", on_Tap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
          })
        ],
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


}
