import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRecord/animalRecord.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/DailyRecord/daily_record_screen.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/FeedEntry/feed_record.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/MilkRecordScreen/milk_record.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/VacinationScreen/vacination_record.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/WorkerRegistration/workers_record.dart';
import 'package:dairyfarmflow/Screens/Dashboard/adminDashboard/adminDashboard.dart';
import 'package:dairyfarmflow/Screens/Dashboard/workerDashboard/workerDashboard.dart';
import 'package:dairyfarmflow/Screens/SampleScreen.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String role = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade100,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constraints.maxHeight),
              child: Column(
                children: [
                  pageHeaderContainer(),
                  Expanded(child: pageBodyContainer()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget pageHeaderContainer() {
    return Material(
        elevation: 6,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        child: Container(
            height: screenHeight / 4,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: greyGreenColor,
                      blurRadius: 6,
                      offset: Offset(2, 2))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  //here is the code for the custom gridview boxes
                  gridButtons()
                  // Text("data")
                ],
              ),
            )));
  }

  Widget gridButtons() {
    return role == "1"
        ? const AdminDashboardButtons()
        : const workerDashboardButtons();
  }

  Widget pageBodyContainer() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(paragraph),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month_sharp,
                      color: darkGreenColor,
                    ),
                    Text1(
                        fontColor: lightBlackColor,
                        fontSize: paragraph,
                        text: DateFormat("MMMM yyyy").format(DateTime.now())),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: paragraph,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(paragraph),
                  boxShadow: [
                    BoxShadow(
                        color: greyGreenColor,
                        blurRadius: 8,
                        offset: Offset(2, 2))
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wrapCircleContainer("25", "Animal"),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          height: 1,
                          width: screenWidth / 3.8,
                          color: CupertinoColors.systemGrey6,
                        ),
                        SizedBox(
                          height: paragraph / 2,
                        ),
                        wrapCircleContainer("5", "Baby"),
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight / 4,
                    width: 1,
                    color: CupertinoColors.systemGrey6,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wrapCircleContainer("200", "Wanda"),
                      SizedBox(
                        height: paragraph / 4,
                      ),
                      Container(
                        height: 1,
                        width: screenWidth / 3.2,
                        color: CupertinoColors.systemGrey6,
                      ),
                      SizedBox(
                        height: paragraph / 2,
                      ),
                      wrapCircleContainer("12", "Vacinated"),
                    ],
                  ),
                  Container(
                    height: screenHeight / 4,
                    width: 1,
                    color: CupertinoColors.systemGrey6,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wrapCircleContainer("5", "Pregnent"),
                      SizedBox(
                        height: paragraph / 4,
                      ),
                      Container(
                        height: 1,
                        width: screenWidth / 3.4,
                        color: CupertinoColors.systemGrey6,
                      ),
                      SizedBox(
                        height: paragraph / 2,
                      ),
                      wrapCircleContainer("3", "Sell"),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: header1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    viewContainer(
                        "Animal", "lib/assets/cow.png", const AnimalRecord()),
                    SizedBox(
                      height: paragraph,
                    ),
                    viewContainer("Daily Record", "lib/assets/dairyfarm.png",
                        const DailyRecordScreen()),
                  ],
                ),
                Column(
                  children: [
                    viewContainer("Vacination", "lib/assets/medical.png",
                        const VacinationRecord()),
                    SizedBox(
                      height: paragraph,
                    ),
                    viewContainer("Workers", "lib/assets/farmWorker.png",
                        const WorkersRecord()),
                  ],
                ),
                Column(
                  children: [
                    viewContainer("Milk(ltr)", "lib/assets/milk.png",
                        const MilkRecordScreen()),
                    SizedBox(
                      height: paragraph,
                    ),
                    viewContainer(
                        "Wanda(kg)", "lib/assets/feed.png", const FeedRecord()),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //Wrap Circle Container and Label
  Widget wrapCircleContainer(String text, label) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: paragraph / 2, horizontal: paragraph / 12),
      padding: EdgeInsets.symmetric(horizontal: paragraph),
      child: Column(
        children: [
          circleContainer("${text}"),
          SizedBox(
            height: 2,
          ),
          Text1(fontColor: lightBlackColor, fontSize: paragraph, text: label)
        ],
      ),
    );
  }

  //Circle Container
  Widget circleContainer(String text) {
    return Container(
      width: screenWidth / 7,
      height: screenWidth / 7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth / 4),
        boxShadow: [
          BoxShadow(
              color: greyGreenColor,
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 2)
        ],
      ),
      child: Center(
          child: Text1(
              fontColor: blackColor, fontSize: paragraph, text: "${text}")),
    );
  }

  //ViewContainer
  Widget viewContainer(String text, iconPath, Widget widget) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(paragraph),
            width: screenWidth / 5,
            height: screenWidth / 4.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(paragraph),
                boxShadow: [
                  BoxShadow(
                      color: greyGreenColor,
                      offset: Offset(2, 2),
                      blurRadius: 6),
                ]),
            child: Center(
                child: Image(
              image: AssetImage(iconPath),
              width: screenWidth / 8,
            )),
          ),
          Text1(fontColor: lightBlackColor, fontSize: paragraph, text: text)
        ],
      ),
    );
  }
}
