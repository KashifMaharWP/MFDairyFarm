import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedRecord extends StatefulWidget {
  const FeedRecord({super.key});

  @override
  State<FeedRecord> createState() => _FeedRecordState();
}

class _FeedRecordState extends State<FeedRecord> {
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
          title: const Text("Feed Record"),
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
                        return Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight * .025,
                                bottom: screenHeight * .025,
                                left: screenWidth * .025,
                                right: screenWidth * .025),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: screenHeight * .035,
                                      width: screenHeight * .035,
                                      child: const Image(
                                        image:
                                            AssetImage("lib/assets/wanda.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * .015,
                                    ),
                                    Text1(
                                        fontColor: lightBlackColor,
                                        fontSize: screenWidth * .05,
                                        text: "Date"),
                                  ],
                                ),
                                Text1(
                                    fontColor: lightBlackColor,
                                    fontSize: screenWidth * .05,
                                    text: "KG"),
                              ],
                            ),
                          ),
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
                        wrapCircleContainer("225", "Available"),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 1,
                          height: screenWidth / 3.8,
                          color: CupertinoColors.systemGrey6,
                        ),
                        wrapCircleContainer("25", "Used"),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 1,
                          height: screenWidth / 3.8,
                          color: CupertinoColors.systemGrey6,
                        ),
                        wrapCircleContainer("250", "Total"),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 1,
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
//https://www.behance.net/gallery/187496733/Dairy-Farm-Management-Mobile-App-UI-Design?tracking_source=search_projects|Dairy+Management&l=0