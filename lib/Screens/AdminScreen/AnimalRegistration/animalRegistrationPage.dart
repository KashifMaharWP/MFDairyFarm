import 'dart:io';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Providers/animal_registratin_provider.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AnimalRegistrationPage extends StatefulWidget {
  const AnimalRegistrationPage({super.key});

  @override
  State<AnimalRegistrationPage> createState() => _AnimalRegistrationPageState();
}

class _AnimalRegistrationPageState extends State<AnimalRegistrationPage> {
  TextEditingController tagId = TextEditingController();
  TextEditingController purchasedPrice = TextEditingController();
  TextEditingController breedType = TextEditingController();
  TextEditingController animalId = TextEditingController();
  String animalIdDropDownValue = "1";
  File? _image;
  final ImagePicker picker = ImagePicker();
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String token =
        Provider.of<UserDetail>(context, listen: false).token.toString();
    if (kDebugMode) {
      print("Token $token");
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkGreenColor,
        foregroundColor: whiteColor,
        title: Text1(
          fontColor: whiteColor,
          fontSize: header4,
          text: "Register Animal",
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
          child: Column(
            children: [
              SizedBox(height: paragraph / 6),
              GestureDetector(
                onTap: () {
                  _showImageSourceDialog(context);
                },
                child: Container(
                  margin: EdgeInsets.all(paragraph / 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: screenWidth,
                  height: screenHeight / 16,
                  decoration: BoxDecoration(
                    border: Border.all(color: darkGreenColor, width: 1),
                    borderRadius: BorderRadius.circular(paragraph / 6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text1(
                        fontColor: lightBlackColor,
                        fontSize: paragraph / 1.2,
                        text: _image == null
                            ? "No Picture Selected"
                            : "Image Selected",
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          CupertinoIcons.camera_fill,
                          color: darkGreenColor,
                          size: header1 * 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: paragraph / 2),
              customForm(),
              SizedBox(height: paragraph / 2),
              customRoundedButton(
                loading: false,
                title: "Save Animal",
                on_Tap: () async {
                //  FocusScope.of(context).unfocus();
                  await Provider.of<AnimalRegistratinProvider>(context,
                          listen: false)
                      .uploadAnimalData(context, animalId.text, breedType.text,
                          purchasedPrice.text, _image!);
                          Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customForm() {
    return Padding(
      padding: EdgeInsets.all(paragraph / 6),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFormField("Animal ID", CupertinoIcons.tag_fill),
            TextFieldWidget1(
              widgetcontroller: animalId,
              fieldName: "Animal Id",
              isPasswordField: false,
            ),
            SizedBox(height: paragraph),
            customTextFormField(
                "Breed Type", CupertinoIcons.arrow_3_trianglepath),
            TextFieldWidget1(
              widgetcontroller: breedType,
              fieldName: "Breed Type",
              isPasswordField: false,
            ),
            SizedBox(height: paragraph),
            customTextFormField(
                "Purchase Price", CupertinoIcons.money_dollar_circle_fill),
            TextFieldWidget1(
              widgetcontroller: purchasedPrice,
              fieldName: "Purchase Price",
              isPasswordField: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextFormField(String text, IconData customIcon) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Icon(customIcon, color: darkGreenColor),
        Text1(fontColor: blackColor, fontSize: paragraph, text: text),
      ],
    );
  }
}
