import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';

class sampleScreen extends StatelessWidget {
  final Color backgroundColor;
  const sampleScreen({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Text1(
            fontColor: whiteColor, fontSize: header1, text: "Comming Soon"),
      ),
    );
  }
}
