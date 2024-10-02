import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRecord/animal_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/custom_filter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          SizedBox(
            height: screenHeight * .015,
          ),
          Container(
              width: screenWidth * 0.95,
              height: screenHeight * .07,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(child: customFiltersWidget())),
          SizedBox(
            height: screenHeight * .015,
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AnimalDetail()));
                        },
                        child: Container(
                          width: screenWidth * 0.95,
                          height: screenHeight / 3.2,
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
                                    height: screenHeight * .18,
                                    width: screenWidth * .8,
                                    //color: Colors.red,
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
                                    height: screenHeight * .001,
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
