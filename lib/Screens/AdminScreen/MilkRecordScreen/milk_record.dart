import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRecord/animal_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/custom_filter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MilkRecordScreen extends StatefulWidget {
  const MilkRecordScreen({super.key});

  @override
  State<MilkRecordScreen> createState() => _MilkRecordScreenState();
}

class _MilkRecordScreenState extends State<MilkRecordScreen> {
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
        title: const Text("Milk Record"),
      ),
      body: Column(
        children: [
          pageHeaderContainer(),
          SizedBox(
            height: screenHeight * .015,
          ),
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
            height: paragraph / 4,
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        child: Container(
                          width: screenWidth * 0.95,
                          height: screenHeight / 3.5,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            //color: const Color.fromARGB(255, 210, 203, 203),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Image(
                                          image: NetworkImage(
                                              "https://static.vecteezy.com/system/resources/thumbnails/023/651/804/small/dairy-cow-on-transparent-background-created-with-generative-ai-png.png"),
                                          fit: BoxFit.fill,
                                        ),
                                        height: screenHeight * .135,
                                        width: screenWidth * .8,
                                        //color: Colors.red,
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.more_vert,
                                      size: screenWidth * .065,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * .025,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.tag_fill,
                                            color: darkGreenColor,
                                          ),
                                          SizedBox(
                                            width: screenWidth * .007,
                                          ),
                                          Text1(
                                              fontColor: lightBlackColor,
                                              fontSize: screenWidth * .044,
                                              text: "Animal"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.add,
                                            color: darkGreenColor,
                                          ),
                                          SizedBox(
                                            width: screenWidth * .007,
                                          ),
                                          Text1(
                                              fontColor: lightBlackColor,
                                              fontSize: screenWidth * .044,
                                              text: "Total"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * .015,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image(
                                            image: const AssetImage(
                                                "lib/assets/sun.png"),
                                            width: screenWidth * .055,
                                            height: screenWidth * .055,
                                          ),
                                          SizedBox(
                                            width: screenWidth * .007,
                                          ),
                                          Text1(
                                              fontColor: lightBlackColor,
                                              fontSize: screenWidth * .044,
                                              text: "Morning"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image(
                                            image: const AssetImage(
                                                "lib/assets/moon.png"),
                                            width: screenWidth * .055,
                                            height: screenWidth * .055,
                                          ),
                                          SizedBox(
                                            width: screenWidth * .007,
                                          ),
                                          Text1(
                                              fontColor: lightBlackColor,
                                              fontSize: screenWidth * .044,
                                              text: "Evening"),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  //Wrap Text Container
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
                        wrapCircleContainer(
                            "225", "Total", 'lib/assets/milk.png'),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 1,
                          height: screenWidth / 3.5,
                          color: CupertinoColors.systemGrey6,
                        ),
                        wrapCircleContainer(
                            "150", "Morning", 'lib/assets/sun.png'),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 01,
                          height: screenWidth / 3.8,
                          color: CupertinoColors.systemGrey6,
                        ),
                        wrapCircleContainer(
                            "75", "Evening", 'lib/assets/moon.png'),
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

Widget wrapCircleContainer(String text, label, url) {
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
        Row(
          children: [
            Image(
              image: AssetImage(url),
              width: screenWidth * .05,
              height: screenWidth * .05,
            ),
            SizedBox(
              width: screenWidth * .005,
            ),
            Text1(fontColor: lightBlackColor, fontSize: paragraph, text: label),
          ],
        )
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
