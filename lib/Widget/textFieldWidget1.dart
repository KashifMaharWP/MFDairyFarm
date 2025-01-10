import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget1 extends StatefulWidget {
  TextFieldWidget1({
    super.key,
    required this.widgetcontroller,
    required this.fieldName,
    this.widgeticon,
    required this.isPasswordField,
    this.keyboardtype,
    this.isReadOnly = false,
  });

  //SETTING THE PARAMETER FOR THE widgets
  TextEditingController widgetcontroller = TextEditingController();
  IconData? widgeticon;
  String fieldName = "sample";
  bool isPasswordField = false;
  bool isReadOnly = false;
  TextInputType? keyboardtype = TextInputType.text;

  @override
  State<TextFieldWidget1> createState() => TextFieldWidget1State();
}

class TextFieldWidget1State extends State<TextFieldWidget1> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      shadowColor: darkGreenColor.withOpacity(0.3),
      child: TextFormField(
        readOnly: widget.isReadOnly,
        obscureText: widget.isPasswordField
            ? showPassword
                ? false
                : true
            : false,
        scrollPhysics: const BouncingScrollPhysics(),
        keyboardType: widget.keyboardtype,
        controller: widget.widgetcontroller,
        decoration: InputDecoration(
            //prefixIcon: Icon(widget.widgeticon),
            hintStyle: GoogleFonts.nunito(
              textStyle:
                  TextStyle(color: lightBlackColor, fontSize: paragraph+3),
            ),
            suffixIcon: widget.isPasswordField
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = showPassword ? false : true;
                      });
                    },
                    child: Icon(showPassword
                        ? CupertinoIcons.lock_open_fill
                        : CupertinoIcons.lock_fill))
                : const IgnorePointer(),
            hintText: widget.fieldName,
            
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: greyGreenColor, width: 1))
            //label: Text(widget.fieldName),
            ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your ${widget.fieldName}";
          }
          return null;
        },
      ),
    );
  }
}
