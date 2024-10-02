import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';

import '../Class/screenMediaQuery.dart';

customPopUp(BuildContext context, Widget widget, double height) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    content: Container(
      width: screenWidth * 0.85,
      constraints: BoxConstraints(maxHeight: height),
      child: Center(
        child: widget,
      ),
    ),
    actions: [
      InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: screenWidth / 3.5,
          height: screenHeight / 20,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(paragraph / 4),
              boxShadow: [
                BoxShadow(
                    color: greyGreenColor,
                    blurRadius: 6,
                    offset: const Offset(2, 2))
              ]),
          child: Center(
              child: Text1(
                  fontColor: Colors.white,
                  fontSize: paragraph,
                  text: "Cancel")),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: screenWidth / 3.5,
          height: screenHeight / 20,
          decoration: BoxDecoration(
              color: darkGreenColor,
              borderRadius: BorderRadius.circular(paragraph / 4),
              boxShadow: [
                BoxShadow(
                    color: greyGreenColor, blurRadius: 6, offset: Offset(2, 2))
              ]),
          child: Center(
              child: Text1(
                  fontColor: Colors.white, fontSize: paragraph, text: "Save")),
        ),
      )
    ],
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
