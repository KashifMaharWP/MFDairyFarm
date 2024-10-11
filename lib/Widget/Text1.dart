import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Text1 extends StatefulWidget {
  final double fontSize;
  final Color fontColor;
  final String text;
  const Text1(
      {required this.fontColor, required this.fontSize, required this.text});

  @override
  State<Text1> createState() => _Text1State();
}

class _Text1State extends State<Text1> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.nunito(
          textStyle: TextStyle(
              color: widget.fontColor,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w500)),
    );
  }
}
