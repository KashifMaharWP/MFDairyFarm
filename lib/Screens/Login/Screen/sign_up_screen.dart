import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/auth_provider.dart';
import 'package:dairyfarmflow/Providers/register_user_provider.dart';

import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWithIconWidget.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../Class/textSizing.dart';
import '../../../Widget/Text1.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/mfBackground.png"),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              pageHeaderContainer(),
              SizedBox(
                height: screenHeight / 15,
              ),
              pageBodyContainer(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget pageHeaderContainer() {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: screenHeight / 5),
          child: Image(
            image: const AssetImage("lib/assets/Logo.png"),
            width: screenWidth / 3,
          )),
    );
  }

  Widget pageBodyContainer() {
    return Container(
      padding: EdgeInsets.all(header1),
      width: double.infinity,
      height: screenHeight / 1.5,
      decoration: BoxDecoration(
        color: transGreenColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth / 8),
            topRight: Radius.circular(screenWidth / 8)),
      ),
      child: Column(
        children: [
          Text1(fontColor: whiteColor, fontSize: header1, text: "Sign in"),
          SizedBox(
            height: screenHeight / 15,
          ),
          customFormLabel("Name"),
          textFieldWithIconWidget(
              widgetcontroller: name,
              fieldName: AutofillHints.name,
              widgeticon: Icons.person,
              isPasswordField: false),
          customFormLabel("Email"),
          textFieldWithIconWidget(
              widgetcontroller: email,
              fieldName: AutofillHints.email,
              widgeticon: Icons.email_sharp,
              isPasswordField: false),
          SizedBox(
            height: paragraph,
          ),
          customFormLabel("Password"),
          textFieldWithIconWidget(
              widgetcontroller: password,
              fieldName: "password",
              widgeticon: Icons.lock,
              isPasswordField: true),
          SizedBox(
            height: header1,
          ),
          customRoundedButton(
              title: "Register User",
              on_Tap: () async {
                await Provider.of<RegisterUserProvider>(context, listen: false)
                    .registerUser(
                        name: name.text,
                        email: email.text,
                        password: password.text,
                        context: context);
                // await Provider.of<AuthProvider>(context, listen: false)
                //     .signUp(name.text, email.text, password.text, context);
                name.clear();
                email.clear();
                password.clear();
              })
        ],
      ),
    );
  }

  Widget customFormLabel(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text1(fontColor: whiteColor, fontSize: header6, text: text),
      ],
    );
  }
}
