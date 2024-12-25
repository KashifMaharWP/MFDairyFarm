import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
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
        appBar: AppBar(
          backgroundColor: darkGreenColor,
          foregroundColor: whiteColor,
          centerTitle: true,
          title: Text1(
            fontSize: header4,
            fontColor: whiteColor,
            text: "Register Worker",
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // pageHeaderContainer(),
                SizedBox(
                  height: screenHeight / 15,
                ),
                pageBodyContainer(),
              ],
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
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight * .025, horizontal: screenWidth * .05),
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
          Consumer<RegisterUserProvider>(
            builder: (context, value, child) => customRoundedButton(
                loading: value.isLoading,
                title: "Register User",
                on_Tap: () async {
                  FocusScope.of(context).unfocus();
                  await Provider.of<RegisterUserProvider>(context,
                          listen: false)
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
                }),
          )
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
