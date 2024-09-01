import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:flutter/material.dart';
class customRoundedButton extends StatelessWidget {
  customRoundedButton(
      {super.key,
        required this.title,
        //required this.loading,
        required this.on_Tap});
  //bool loading = false;
  String title;
  VoidCallback on_Tap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: on_Tap,
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
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: paragraph,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
