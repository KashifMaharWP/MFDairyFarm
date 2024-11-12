import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/registration_provider.dart';
import 'package:dairyfarmflow/Screens/Registration/registration_page2.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWithIconWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RegistrationPage1 extends StatefulWidget {
  const RegistrationPage1({super.key});

  @override
  State<RegistrationPage1> createState() => _RegistrationPage1State();
}

class _RegistrationPage1State extends State<RegistrationPage1> {
  //Controllers of the textform field
  final _dairyNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();

//FUNCTION TO SET THE COMPANY DETAILS
  void setDairyDetails() {
    setState(() {
      Provider.of<RegistrationProvider>(context, listen: false).dairyName =
          _dairyNameController.text;
      Provider.of<RegistrationProvider>(context, listen: false).ownerName =
          _ownerNameController.text;
      Provider.of<RegistrationProvider>(context, listen: false).location =
          _locationController.text;
      Provider.of<RegistrationProvider>(context, listen: false)
          .registrationDate = _dateController.text;
    });
  }

  void ontap() async {
    setDairyDetails();
    bool isreg = await Provider.of<RegistrationProvider>(context, listen: false)
        .registerDairy();

    print("isRegistered : $isreg");
    final chk =
        Provider.of<RegistrationProvider>(context, listen: false).dairyFarmId;
    print("Dairy Id = $chk");
    if (isreg == true) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RegistrationPage2()));
    } else {
      const AlertDialog(
        content: Text("Error While registering the company"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: darkGreenColor,
        // backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: screenHeight / 12),
            Text(
              "Dairy Registration",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * .05),
            ),
            SizedBox(height: screenHeight / 15),
            Container(
              height: screenHeight - (screenHeight / 5.32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
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
                    //Text fields form
                    formTextContainer(),
                    const SizedBox(
                      height: 30,
                    ),
                    customRoundedButton(title: "Next", on_Tap: ontap)
                    //rounded custom button widtet
                    // RoundedButton(title: "Next", loading: false, on_Tap: ontap)
                  ],
                ),
              ),
            )
          ],
        ));
  }

// widget text form field
  Widget formTextContainer() {
    return Form(
        child: Column(
      children: [
        textFieldWithIconWidget(
            widgetcontroller: _dairyNameController,
            fieldName: "Dairy Name",
            isPasswordField: false),
        // TextFieldWidget(
        //     widgetcontroller: _companyNameController,
        //     fieldName: "Company name",
        //     widgeticon: CupertinoIcons.doc_plaintext,
        //     isPasswordField: false),
        const SizedBox(
          height: 30,
        ),
        //
        textFieldWithIconWidget(
            widgetcontroller: _ownerNameController,
            fieldName: "Onwer Name",
            isPasswordField: false),

        const SizedBox(
          height: 30,
        ),
        //
        textFieldWithIconWidget(
            widgetcontroller: _locationController,
            fieldName: "Dairy Location",
            isPasswordField: false),
        const SizedBox(
          height: 30,
        ),
        //
        textFieldWithIconWidget(
            widgetcontroller: _dateController,
            fieldName: "Registration Date",
            isPasswordField: false),
        const SizedBox(
          height: 30,
        ),
        //
        // TextFieldWidget(
        //     widgetcontroller: _companyAddressController,
        //     fieldName: "Address",
        //     widgeticon: CupertinoIcons.news_solid,
        //     isPasswordField: false),
      ],
    ));
  }
}
