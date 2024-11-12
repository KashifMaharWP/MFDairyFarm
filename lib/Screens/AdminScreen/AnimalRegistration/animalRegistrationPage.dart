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
  // List<String> tagIDList = ["1", "2", "3", "4", "5", "6", "7"];
  String animalIdDropDownValue = "1";
  File? _image; // To store the selected image

  final ImagePicker picker = ImagePicker();

  // Method to pick an image
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

  // Method to upload data to the API
  // Future<void> uploadAnimalData(BuildContext context) async {
  //   if (_image == null ||
  //       purchasedPrice.text.isEmpty ||
  //       breedType.text.isEmpty) {
  //     print("Please complete all fields and select an image.");
  //     return;
  //   }

  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //         'https://dairy-app-production-4bb8.up.railway.app/api/cow/register'),
  //   );

  //   // Add headers and fields

  //   request.files.add(
  //     await http.MultipartFile.fromPath(
  //       'image',
  //       _image!.path,
  //       filename: basename(_image!.path),
  //     ),
  //   );

  //   request.headers['Authorization'] =
  //       'Bearer ${Provider.of<UserDetail>(context, listen: false).token}';
  //   request.fields['animalNumber'] = animalIdDropDownValue;
  //   request.fields['breed'] = breedType.text;
  //   request.fields['age'] = purchasedPrice.text;

  //   // Send request and handle response
  //   try {
  //     var response = await request.send();
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       print('Animal data uploaded successfully!');
  //     } else {
  //       print('Failed to upload data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error uploading data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<AnimalRegistratinProvider>(context);
    String token =
        Provider.of<UserDetail>(context, listen: false).token.toString();
    if (kDebugMode) {
      print("Token $token");
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, right: 8, left: 8),
          child: Column(
            children: [
              Text1(
                fontColor: darkGreenColor,
                fontSize: paragraph,
                text: "Register Animal",
              ),
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
                title: "Save Animal",
                on_Tap: () async {
                  await Provider.of<AnimalRegistratinProvider>(context,
                          listen: false)
                      .uploadAnimalData(context, animalId.text, breedType.text,
                          purchasedPrice.text, _image!);
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
