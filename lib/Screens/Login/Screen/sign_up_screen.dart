import 'dart:convert';

import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Screens/Dashboard/Dashboard.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWithIconWidget.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
              title: "Sign Up",
              on_Tap: () async {
                //print("Tapped");
                await signUp(name.text, email.text, password.text);
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

  Future<String> signUp(String name, email, password) async {
    String message = '';
    final bodyy = {"name": name, "email": email, "password": password};

    final response = await http.post(
        Uri.parse(
            "https://dairy-app-production-4bb8.up.railway.app/api/user/signup"),
        body: bodyy);
    final userJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      message = userJson["message"];
      myShowDialog(message);
    } else {
      message = userJson["message"];
      myShowDialog(message);
    }
    return message;
  }

  Future<dynamic> myShowDialog(String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                    fontSize: 18),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        );
      },
    );
  }
}
