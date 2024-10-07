// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';

class DailyRecordScreen extends StatefulWidget {
  const DailyRecordScreen({super.key});

  @override
  State<DailyRecordScreen> createState() => _DailyRecordScreenState();
}

class _DailyRecordScreenState extends State<DailyRecordScreen> {
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
        title: const Text("Daily Record"),
      ),
      body: Column(
        children: [
          pageHeaderContainer(),
          SizedBox(
            height: screenHeight * .023,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenWidth * 0.95,
                  height: screenHeight / 7,
                  padding: EdgeInsets.all(paragraph),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(paragraph),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text1(
                              fontColor: blackColor,
                              fontSize: screenWidth * .055,
                              text: "Customer Name"),
                          Text1(
                              fontColor: blackColor,
                              fontSize: screenWidth * .055,
                              text: "Liters")
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * .023,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RowWithTextAndImage(
                              text1: "Morning", imgUrl: "lib/assets/sun.png"),
                          RowWithTextAndImage(
                            imgUrl: "lib/assets/moon.png",
                            text1: "Evening",
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}

Widget pageHeaderContainer() {
  return Material(
      elevation: 6,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      child: Container(
          height: screenHeight / 2.2,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Row(
                        children: [
                          Image(
                            image: const AssetImage("lib/assets/milk.png"),
                            width: screenHeight * .040,
                            height: screenHeight * .040,
                          ),
                          SizedBox(
                            width: screenWidth * .015,
                          ),
                          Text1(
                              fontColor: blackColor,
                              fontSize: screenWidth * .055,
                              text: "Milk Record"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .02,
                    ),
                    ReuseRow(
                      text1: "20",
                      text2: "Morning",
                      text3: "25",
                      text4: "Evening",
                      text5: "250",
                      text6: "Total",
                    ),
                    const SizedBox(
                      height: 15,
                      child: Divider(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage("lib/assets/wanda.png"),
                            width: screenHeight * .040,
                            height: screenHeight * .040,
                          ),
                          SizedBox(
                            width: screenWidth * .015,
                          ),
                          Text1(
                              fontColor: blackColor,
                              fontSize: screenWidth * .055,
                              text: "Feed Record"),
                        ],
                      ),
                    ),
                    ReuseRow(
                      text1: "100",
                      text2: "Available",
                      text3: "66",
                      text4: "Used",
                      text5: "166",
                      text6: "Total",
                    ),
                  ],
                ),
              ],
            ),
          )));
}

class ReuseRow extends StatelessWidget {
  String text1, text2, text3, text4, text5, text6;
  ReuseRow(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4,
      required this.text5,
      required this.text6})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        wrapCircleContainer(text1, text2),
        SizedBox(
          height: paragraph / 4,
        ),
        Container(
          width: 1,
          height: screenWidth / 3.8,
          color: CupertinoColors.systemGrey6,
        ),
        wrapCircleContainer(text3, text4),
        SizedBox(
          height: paragraph / 4,
        ),
        Container(
          width: 1,
          height: screenWidth / 3.8,
          color: CupertinoColors.systemGrey6,
        ),
        wrapCircleContainer(text5, text6),
        SizedBox(
          height: paragraph / 4,
        ),
        Container(
          width: 1,
          height: screenWidth / 3.8,
          color: CupertinoColors.systemGrey6,
        ),
      ],
    );
  }
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

class RowWithTextAndImage extends StatelessWidget {
  String text1, imgUrl;
  RowWithTextAndImage({required this.text1, required this.imgUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AssetImage(imgUrl),
          width: screenHeight * .030,
          height: screenHeight * .030,
        ),
        SizedBox(
          width: screenWidth * .015,
        ),
        Text1(
            fontColor: lightBlackColor,
            fontSize: screenWidth * .05,
            text: text1),
      ],
    );
  }
}
