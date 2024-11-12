import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/registration_provider.dart';
import 'package:dairyfarmflow/Screens/Registration/registration_page1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWithIconWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage2 extends StatefulWidget {
  const RegistrationPage2({super.key});

  @override
  State<RegistrationPage2> createState() => _RegistrationPage2State();
}

class _RegistrationPage2State extends State<RegistrationPage2> {
  //Controllers of the textform field
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

// function to send the details
  void setAdminDetails() {
    setState(() {
      Provider.of<RegistrationProvider>(context, listen: false).name =
          _fullnameController.text;
      Provider.of<RegistrationProvider>(context, listen: false).email =
          _emailController.text;
      Provider.of<RegistrationProvider>(context, listen: false).password =
          _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: darkGreenColor,
        // backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 18),
            //widget of page back button and heading
            pageHeader(),
            SizedBox(height: screenHeight / 15),
            //Form container
            FormContiner()
          ],
        ));
  }

//Widget header
  Widget pageHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                iconSize: screenWidth * .05,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage1()));
                },
                icon: const Icon(CupertinoIcons.back))
          ],
        ),
        Text(
          "Admin Registration",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: screenWidth * .05),
        ),
      ],
    );
  }

//form container
  Widget FormContiner() {
    return Container(
      height: screenHeight - (screenHeight / 5.32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 4),
            // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            FormTextContainer(),
            const SizedBox(
              height: 50,
            ),
            customRoundedButton(
                title: "Register",
                on_Tap: () {
                  setAdminDetails();
                  Provider.of<RegistrationProvider>(context, listen: false)
                      .registerAdmin();
                })
            // RoundedButton(
            //     title: "Register",
            //     loading: false,
            //     on_Tap: () {
            //       setAdminDetails();

            //       Provider.of<RegistrationProvider>(context, listen: false)
            //           .registerAdmin();
            //     })
          ],
        ),
      ),
    );
  }

// widget text form field
  Widget FormTextContainer() {
    return Form(
        child: Column(
      children: [
        textFieldWithIconWidget(
            widgetcontroller: _fullnameController,
            fieldName: "Full Name",
            isPasswordField: false),
        // TextFieldWidget(
        //     widgetcontroller: _fullnameController,
        //     fieldName: "Fullname",
        //     widgeticon: CupertinoIcons.person,
        //     isPasswordField: false),
        const SizedBox(
          height: 30,
        ),
        //
        textFieldWithIconWidget(
            widgetcontroller: _emailController,
            fieldName: "Email",
            isPasswordField: false),

        const SizedBox(
          height: 30,
        ),
        //
        textFieldWithIconWidget(
            widgetcontroller: _passwordController,
            fieldName: "Password",
            isPasswordField: true),
        const SizedBox(
          height: 30,
        ),
        //
        // TextFieldWidget(
        //   widgetcontroller: _addressController,
        //   fieldName: "Address",
        //   widgeticon: CupertinoIcons.news,
        //   isPasswordField: false,
        //   keyboardtype: TextInputType.text,
        // ),

        const SizedBox(
          height: 30,
        ),
        //
        // TextFieldWidget(
        //   widgetcontroller: _passwordController,
        //   fieldName: "Password",
        //   widgeticon: CupertinoIcons.lock_fill,
        //   isPasswordField: false,
        //   keyboardtype: TextInputType.visiblePassword,
        // ),
      ],
    ));
  }
}
