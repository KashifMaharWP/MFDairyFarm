import 'dart:convert';

import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Screens/Dashboard/Dashboard.dart';
import 'package:dairyfarmflow/Screens/Login/Screen/sign_up_screen.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWithIconWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Class/textSizing.dart';
import '../../../Widget/Text1.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  checkUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final chk = prefs.getString('userId');
    print("User Id = $chk");
    //checking if the user detail is available then
    if (chk != '' && chk != null) {
      //get user data from the preference and store it in userdetail class
      Provider.of<UserDetail>(context, listen: false)
          .setUserDetailByPreferences();

      //after initializing the user detail class move the user to homepage
      Navigator.push(context, MaterialPageRoute(builder: (_) => Dashboard()));
    } else {
      print("User not found!");
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserData();
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
      height: screenHeight / 1.8,
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
          // SizedBox(
          //   height: header1,
          // ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text(
                'Register!',
                style: TextStyle(
                    color: Colors.lightBlue, fontSize: screenWidth * .05),
              )),
          customRoundedButton(
              title: "Sign in",
              on_Tap: () {
                login(email.text, password.text);
                // print("Tapped");
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Dashboard()));
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

  Future<bool> login(String email, String password) async {
    bool authUser = false;
    final bodyy = {"email": email, "password": password};

    final response = await http.post(
        Uri.parse(
            "https://dairy-app-production-4bb8.up.railway.app/api/user/login"),
        body: bodyy);
    final userJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // final userJson = jsonDecode(response.body);
      //LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));
      Provider.of<UserDetail>(context, listen: false).setUserDetail(userJson);
      debugPrint('Api Body: ${response.body}');
      print("Token");
      // print(loginModel.token);
      authUser = true;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      print(response.body.toString());
    }
    return authUser;
  }
}
