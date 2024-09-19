import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class customRoundedButton extends StatefulWidget {
  customRoundedButton(
      {super.key,
        required this.title,
        //required this.loading,
        required this.on_Tap});
  //bool loading = false;
  String title;
  VoidCallback on_Tap;

  @override
  State<customRoundedButton> createState() => _customRoundedButtonState();
}

class _customRoundedButtonState extends State<customRoundedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.on_Tap,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 17,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: darkGreenColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.title,
            style: GoogleFonts.nunito(
              textStyle:TextStyle(
                  color: Colors.white,
                  fontSize: paragraph,
                  fontWeight: FontWeight.w400),
            ),
            )
        ),
      ),
    );
  }
}
