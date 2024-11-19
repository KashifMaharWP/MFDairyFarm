import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWithIconWidget.dart';
import 'package:flutter/material.dart';
import 'package:dairyfarmflow/Class/colorPallete.dart';

import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Getting the screen dimensions using MediaQuery
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<UserDetail>(
          builder: (context, value, child) => Column(
            children: [
              pageHeaderContainer(screenHeight, screenWidth),
              SizedBox(
                height: screenHeight * .03,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldWithIconWidget(
                  fieldName: value.name.toString(),
                  isPasswordField: false,
                  widgeticon: Icons.person,
                  widgetcontroller: name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldWithIconWidget(
                  fieldName: value.email.toString(),
                  isPasswordField: false,
                  widgeticon: Icons.email,
                  widgetcontroller: name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldWithIconWidget(
                  fieldName: value.role.toString(),
                  isPasswordField: false,
                  widgeticon: Icons.wallet_travel_outlined,
                  widgetcontroller: name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldWithIconWidget(
                  fieldName: "0304040039",
                  isPasswordField: false,
                  widgeticon: Icons.phone,
                  widgetcontroller: name,
                ),
              ),
              SizedBox(
                height: screenHeight * .035,
              ),
              customRoundedButton(
                  loading: false, title: "Edit Profile", on_Tap: () {})
              // Add other widgets for the profile view here
            ],
          ),
        ),
      ),
    );
  }
}

Widget pageHeaderContainer(double screenHeight, double screenWidth) {
  return Material(
    elevation: 6,
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(100),
      bottomRight: Radius.circular(100),
    ),
    child: Container(
      height: screenHeight / 3,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
        color: darkGreenColor,
        boxShadow: [
          BoxShadow(
            color: greyGreenColor,
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * .03, top: screenHeight * 0.05),
                  child: Column(
                    children: [
                      Consumer<UserDetail>(
                        builder: (context, value, child) => Text(
                          value.name.toString(),
                          style: TextStyle(
                              fontSize: header1,
                              fontWeight: FontWeight.w600,
                              color: whiteColor),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * .02,
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        // You can use a Network image or asset image for the avatar
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: darkGreenColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
