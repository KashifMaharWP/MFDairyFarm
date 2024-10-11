import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RowWithTextAndImage extends StatelessWidget {
  String text1, imgUrl;
  RowWithTextAndImage({required this.text1, required this.imgUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AssetImage(imgUrl),
          width: screenHeight * .030,
          height: screenHeight * .030,
        ),
        SizedBox(
          width: screenWidth * .015,
        ),
        Text1(
            fontColor: lightBlackColor,
            fontSize: screenWidth * .05,
            text: text1),
      ],
    );
  }
}
