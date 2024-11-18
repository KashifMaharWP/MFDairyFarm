import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DairyFormDetail extends StatelessWidget {
  const DairyFormDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: darkGreenColor,
          centerTitle: true,
          title: Text1(
            fontColor: whiteColor,
            fontSize: screenWidth * .055,
            text: "DairyFarm Detail",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              Container(
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
                margin: EdgeInsets.only(top: screenHeight / 94),
                height: screenHeight / 3,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
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
        Text1(
            fontColor: lightBlackColor, fontSize: paragraph / 1.07, text: label)
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
            offset: const Offset(2, 2),
            blurRadius: 2,
            spreadRadius: 2)
      ],
    ),
    child: Center(
        child: Text1(
            fontColor: blackColor, fontSize: paragraph / 1.1, text: text)),
  );
}
