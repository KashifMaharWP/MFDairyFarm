import 'package:dairyfarmflow/Functions/customPopUp.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRegistration/animalRegistrationPage.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/FeedEntry/feedEntryPage.dart';
import 'package:dairyfarmflow/Screens/Login/Screen/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Class/colorPallete.dart';
import '../../../Class/screenMediaQuery.dart';
import '../../../Class/textSizing.dart';
import '../../../Widget/Text1.dart';

class AdminDashboardButtons extends StatefulWidget {
  const AdminDashboardButtons({super.key});

  @override
  State<AdminDashboardButtons> createState() => _AdminDashboardButtons();
}

class _AdminDashboardButtons extends State<AdminDashboardButtons> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        padding: EdgeInsets.only(left: 20,top: 20,),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 15,
            mainAxisExtent: 100),
        children: [
          viewContainer("Animal", "lib/assets/cowEntry.png", () async {
            // Navigate to animalRegistrationPage and get the save function
            final Function? saveFunction = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AnimalRegistrationPage(),
              ),
            );
            if (saveFunction != null) {
              // Trigger customPopUp and pass the save function
              customPopUp(context, screenHeight / 3, saveFunction);
            }
          }),
          viewContainer("Wanda", "lib/assets/wanda.png", () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => feedEntryPage()));
          }),
          viewContainer("Worker", "lib/assets/farmWorker.png", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          }),
        ],
      ),
    );
  }

  Widget viewContainer(String text, String iconPath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(paragraph),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: greyGreenColor,
                          offset: const Offset(2, 2),
                          blurRadius: 6),
                    ]),
                child: Center(
                    child: Image(
                        image: AssetImage(iconPath), width: 35)),
              ),
              Text1(fontColor: lightBlackColor, fontSize: paragraph, text: text),
            ],
          ),
          Positioned(
          bottom: 35,
          right: 35,
          child: Icon(
            CupertinoIcons.plus_circle_fill,
            size: header1 * 1.2,
            color: darkGreenColor,
          ))
        ],
      ),
    );
  }
}
