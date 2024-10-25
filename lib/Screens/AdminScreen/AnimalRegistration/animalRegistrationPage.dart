import 'dart:io';

import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AnimalRegistrationPage extends StatefulWidget {
  const AnimalRegistrationPage({super.key});

  @override
  State<AnimalRegistrationPage> createState() => _AnimalRegistrationPageState();
}

class _AnimalRegistrationPageState extends State<AnimalRegistrationPage> {
  TextEditingController tagId = TextEditingController();
  TextEditingController purchasedPrice = TextEditingController();
  TextEditingController breadType = TextEditingController();
  List<String> tagIDList = ["1", "2", "3", "4"];
  String? dropDownItem;
  String animalIdDropDownValue = "1";

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text1(
                  fontColor: darkGreenColor,
                  fontSize: paragraph,
                  text: "Register Animal"),
              SizedBox(
                height: paragraph / 6,
              ),
              Container(
                margin: EdgeInsets.all(paragraph / 6),
                padding: const EdgeInsets.only(right: 10, left: 10),
                width: screenWidth,
                height: screenHeight / 16,
                decoration: BoxDecoration(
                    border: Border.all(color: darkGreenColor, width: 1),
                    borderRadius:
                        BorderRadius.all(Radius.circular(paragraph / 6))),
                child: InkWell(
                  onTap: () {
                    _showImageSourceSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text1(
                          fontColor: lightBlackColor,
                          fontSize: paragraph / 1.2,
                          text: _selectedImage == null
                              ? "No Picture Selected"
                              : "Image Selected"),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            CupertinoIcons.camera_fill,
                            color: darkGreenColor,
                            size: header1 * 1.5,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: paragraph / 2,
              ),
              customForm(),
            ],
          ),
        ));
  }

  Widget customForm() {
    return Padding(
      padding: EdgeInsets.all(paragraph / 6),
      child: Form(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFormField("Animal Id", CupertinoIcons.tag_fill),
            DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ))),
                value: animalIdDropDownValue,
                items: tagIDList.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownItem = newValue;
                  });
                }),
            SizedBox(
              height: paragraph,
            ),
            customTextFormField(
                "Breed Type", CupertinoIcons.arrow_3_trianglepath),
            TextFieldWidget1(
                widgetcontroller: breadType,
                fieldName: "Breed Type",
                isPasswordField: false),
            SizedBox(
              height: paragraph,
            ),
            customTextFormField(
                "Purchase Price", CupertinoIcons.money_dollar_circle_fill),
            TextFieldWidget1(
                widgetcontroller: purchasedPrice,
                fieldName: "Purchase Price",
                isPasswordField: false),
          ],
        ),
      )),
    );
  }

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

  Future<void> _showImageSourceSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(CupertinoIcons.photo),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        // Upload the image after picking it
        // await _uploadProfileImage(File(image.path));
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
