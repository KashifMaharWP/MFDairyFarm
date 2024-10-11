import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/ReuseableWidgets/row_withtext_andimage.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/DailyRecord/daily_record_screen.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkerTask extends StatefulWidget {
  const WorkerTask({super.key});

  @override
  State<WorkerTask> createState() => _WorkerTaskState();
}

class _WorkerTaskState extends State<WorkerTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: darkGreenColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          shadowColor: Colors.black,
          title: const Text("Worker Tasks"),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: screenWidth * .015, right: screenWidth * .015),
          child: Column(
            children: [
              pageHeaderContainer(),
              SizedBox(
                height: screenHeight * .025,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month_sharp,
                    color: darkGreenColor,
                  ),
                  SizedBox(
                    width: screenWidth * .010,
                  ),
                  Text1(
                      fontColor: lightBlackColor,
                      fontSize: paragraph,
                      text: DateFormat("MMMM yyyy").format(DateTime.now())),
                ],
              ),
              SizedBox(
                height: screenHeight * .010,
              ),
              Container(
                child: Expanded(
                  child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: screenWidth * 0.95,
                              height: screenHeight / 4,
                              padding: EdgeInsets.all(paragraph),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(paragraph),
                                  boxShadow: [
                                    BoxShadow(
                                        color: greyGreenColor,
                                        blurRadius: 6,
                                        spreadRadius: 3,
                                        offset: const Offset(2, 0)),
                                  ]),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Column(
                                        children: [
                                          const CircleAvatar(
                                              radius: 55,
                                              backgroundImage: AssetImage(
                                                  "lib/assets/farmWorker.png")),
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenWidth * .05,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text1(
                                                  fontColor: blackColor,
                                                  fontSize: screenWidth * .055,
                                                  text: "Worker Name"),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: RowWithTextAndImage(
                                                  text1: "Total",
                                                  imgUrl:
                                                      "lib/assets/builder.png"),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: RowWithTextAndImage(
                                                  text1: "Complete",
                                                  imgUrl:
                                                      "lib/assets/Check.png"),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: RowWithTextAndImage(
                                                  text1: "Not Complete",
                                                  imgUrl:
                                                      "lib/assets/cross.png"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        );
                      }),
                ),
              )
            ],
          ),
        ));
  }
}

Widget pageHeaderContainer() {
  return Material(
      elevation: 6,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      child: Container(
          height: screenHeight / 5,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: greyGreenColor, blurRadius: 6, offset: Offset(2, 2))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * .02,
                ),

                //here is the code for the custom gridview boxes

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wrapCircleContainer("5", "Available"),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 1,
                          height: screenWidth / 3.8,
                          color: CupertinoColors.systemGrey6,
                        ),
                        wrapCircleContainer("2", "Completed"),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 1,
                          height: screenWidth / 3.8,
                          color: CupertinoColors.systemGrey6,
                        ),
                        wrapCircleContainer("7", "Total"),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 0,
                          height: screenWidth / 3.8,
                          color: CupertinoColors.systemGrey6,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )));
}

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
        child:
            Text1(fontColor: blackColor, fontSize: paragraph, text: "${text}")),
  );
}
