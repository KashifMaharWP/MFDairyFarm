import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class customRoundedButton extends StatelessWidget {
  customRoundedButton(
      {super.key,
      required this.title,
      required this.loading,
      required this.on_Tap});
  bool loading = false;
  String title;
  VoidCallback on_Tap;

  @override
  Widget build(BuildContext context) {
    // bool isLoading = false;
    // final animalProvider = Provider.of<AnimalRegistratinProvider>(context);
    // final authProvider = Provider.of<AuthProvider>(context);
    // isLoading = authProvider.isLoading;
    // isLoading = animalProvider.isLoading;

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
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: whiteColor,
                    ),
                  )
                : Text(
                    title,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: paragraph,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
      ),
    );
  }
}
