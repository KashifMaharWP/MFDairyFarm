import 'package:dairyfarmflow/Functions/customPopUp.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRegistration/animalRegistrationPage.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/FeedEntry/feedEntryPage.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/WorkerRegistration/workerRegistrationPage.dart';
import 'package:dairyfarmflow/Screens/SampleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Class/colorPallete.dart';
import '../../../Class/screenMediaQuery.dart';
import '../../../Class/textSizing.dart';
import '../../../Widget/Text1.dart';
import '../../../Widget/customDashboardButton.dart';


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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              mainAxisExtent: 110),
          children: [
            viewContainer("Animal", "lib/assets/cowEntry.png",animalRegistrationPage(),screenHeight/2),
            viewContainer("Wanda", "lib/assets/wanda.png",feedEntryPage(),screenHeight/3),
            viewContainer("Worker", "lib/assets/farmWorker.png",workerRegistrationPage(),screenHeight/2),
          ],
        ),
      );
  }

  Widget viewContainer(String text, iconPath,Widget widget,double height){
    return InkWell(
      onTap: (){
        customPopUp(context, widget,height);
      },
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(paragraph),
                width: screenWidth/5,
                height: screenWidth/5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth/5),
                    boxShadow: [
                      BoxShadow(
                          color: greyGreenColor,
                          offset: Offset(2, 2),
                          blurRadius: 6
                      ),
                    ]
                ),
                child: Center(
                    child: Image(image: AssetImage(iconPath),width: screenWidth/4,)
                ),
              ),
          
              Text1(
                  fontColor: lightBlackColor,
                  fontSize: paragraph, text: text)
            ],
          ),
          Positioned(
            top: header1*1.8,
            left: header1*2,
              child: Icon(
                  CupertinoIcons.plus_circle_fill,
                  size: header1*1.2,
                color: darkGreenColor,
              )
          )
        ],
      ),
    );
  }
}
