import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/ReuseableWidgets/dairy_form_detail.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRecord/animalRecord.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/DailyRecord/daily_record_screen.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/FeedEntry/feed_record.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/MilkRecordScreen/milk_record.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/VacinationScreen/vacination_record.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/WorkerRegistration/worker_task.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/WorkerRegistration/workers_record.dart';
import 'package:dairyfarmflow/Screens/Dashboard/adminDashboard/adminDashboard.dart';
import 'package:dairyfarmflow/Screens/Dashboard/workerDashboard/workerDashboard.dart';
import 'package:dairyfarmflow/Screens/SampleScreen.dart';

import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/my_drawer.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int? iconIndex = 0;
  String role = "1";

  final List<Widget> _navigationItems = [
    const Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.info,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.task_alt,
      size: 30,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade100,
      body: iconIndex == 0
          ? LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxHeight: constraints.maxHeight),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: darkGreenColor,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          height: screenHeight / 6.2,
                          width: screenWidth,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * .045,
                                right: screenWidth * .045,
                                top: screenHeight * .025),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                      child: const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "lib/assets/farmWorker.png"),
                                        radius: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * .02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * .02,
                                          right: screenWidth * .02,
                                          top: screenHeight * .035),
                                      child: Column(
                                        children: [
                                          Text1(
                                              fontColor: whiteColor,
                                              fontSize: screenWidth * .05,
                                              text: "Welcome"),
                                          Consumer<UserDetail>(
                                            builder: (context, value, child) =>
                                                Text1(
                                                    fontColor: whiteColor,
                                                    fontSize: screenWidth * .05,
                                                    text:
                                                        value.name.toString()),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.notifications,
                                      size: screenWidth * .095,
                                      color: whiteColor,
                                    ),
                                    SizedBox(
                                      width: screenWidth * .02,
                                    ),
                                    PopupMenuButton(
                                      icon: Icon(
                                        Icons.more_vert_outlined,
                                        size: screenWidth * .065,
                                        color: whiteColor,
                                      ),
                                      elevation: 6,
                                      offset: Offset(screenWidth * .05,
                                          screenHeight * .055),
                                      color: Colors.white,
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                            value: 1,
                                            child: ListTile(
                                                title: Text1(
                                                    fontColor: blackColor,
                                                    fontSize: screenWidth * .05,
                                                    text: "Option1"))),
                                        PopupMenuItem(
                                            value: 2,
                                            child: ListTile(
                                              title: Text1(
                                                  fontColor: blackColor,
                                                  fontSize: screenWidth * .05,
                                                  text: "Option2"),
                                            )),
                                        PopupMenuItem(
                                            value: 3,
                                            child: ListTile(
                                              title: Text1(
                                                  fontColor: blackColor,
                                                  fontSize: screenWidth * .05,
                                                  text: "Option3"),
                                            )),
                                        PopupMenuItem(
                                            value: 4,
                                            child: ListTile(
                                              title: Text1(
                                                  fontColor: blackColor,
                                                  fontSize: screenWidth * .05,
                                                  text: "Option2"),
                                            )),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        pageBodyContainer(),
                        SizedBox(
                          height: screenHeight * .025,
                        ),
                        pageHeaderContainer(),
                      ],
                    ),
                  ),
                );
              },
            )
          : iconIndex == 1
              ? const DairyFormDetail()
              : const WorkerTask(),
      bottomNavigationBar: CurvedNavigationBar(
        items: _navigationItems,
        backgroundColor: Colors.grey.shade100,
        color: darkGreenColor,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (value) {
          iconIndex = value;
          setState(() {});
        },
      ),
    );
  }

  Widget pageHeaderContainer() {
    return Padding(
      padding:
          EdgeInsets.only(right: screenWidth * .015, left: screenWidth * .015),
      child: Material(
          elevation: 6,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40)),
          child: Container(
              height: screenHeight / 4,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: greyGreenColor,
                        blurRadius: 6,
                        offset: const Offset(2, 2))
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
              ))),
    );
  }

  Widget gridButtons() {
    return role == "1"
        ? const AdminDashboardButtons()
        : const WorkerDashboardButtons();
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
                        fontSize: screenWidth * .06,
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
                        offset: const Offset(2, 2))
                  ]),
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
                    viewContainer(
                        "Daily Record",
                        "lib/assets/dairyfarm.png",
                        const sampleScreen(
                            backgroundColor:
                                Colors.yellow)) //DailyRecordScreen()),
                  ],
                ),
                Column(
                  children: [
                    viewContainer("Medical Record", "lib/assets/medical.png",
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
          circleContainer(text),
          const SizedBox(
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
              offset: const Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 2)
        ],
      ),
      child: Center(
          child: Text1(fontColor: blackColor, fontSize: paragraph, text: text)),
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
                      offset: const Offset(2, 2),
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
