import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/material.dart';

class workerRegistrationPage extends StatefulWidget {
  const workerRegistrationPage({super.key});

  @override
  State<workerRegistrationPage> createState() => _workerRegistrationPageState();
}

class _workerRegistrationPageState extends State<workerRegistrationPage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text1(
                  fontColor: darkGreenColor,
                  fontSize: paragraph,
                  text: "Register Worker"),
              SizedBox(
                height: paragraph / 6,
              ),
              customForm(),
            ],
          ),
        ));
  }

  // Form for Data Entry
  Widget customForm() {
    return Padding(
      padding: EdgeInsets.all(paragraph / 6),
      child: Form(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFormField("Full Name", Icons.person),
            TextFieldWidget1(
                widgetcontroller: fullName,
                fieldName: "Full Name(Azhar Ali)",
                isPasswordField: false),
            SizedBox(
              height: paragraph,
            ),
            customTextFormField("Email", Icons.email),
            TextFieldWidget1(
                widgetcontroller: email,
                fieldName: "Email(azhar@gmail.com)",
                isPasswordField: false),
            SizedBox(
              height: paragraph,
            ),
            customTextFormField("Password", Icons.lock),
            TextFieldWidget1(
                widgetcontroller: password,
                fieldName: "Password",
                isPasswordField: true),
          ],
        ),
      )),
    );
  }

//custom Text Form for Input entry
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
