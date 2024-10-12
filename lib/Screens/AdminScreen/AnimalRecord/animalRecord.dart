import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRecord/animal_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/custom_filter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimalRecord extends StatefulWidget {
  const AnimalRecord({super.key});

  @override
  State<AnimalRecord> createState() => _AnimalRecordState();
}

class _AnimalRecordState extends State<AnimalRecord> {
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
        title: const Text("Animal Record"),
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
                              Column(
                                children: [
                                  Row(
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
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.more_vert,
                                          size: screenWidth * .065,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * .025,
                              ),
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
                                          fontSize: screenWidth * .05,
                                          text: "Animal"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                            "lib/assets/cowbreed.png"),
                                        width: screenWidth * .055,
                                        height: screenWidth * .055,
                                      ),
                                      SizedBox(
                                        width: screenWidth * .007,
                                      ),
                                      Text1(
                                          fontColor: lightBlackColor,
                                          fontSize: screenWidth * .05,
                                          text: "Breed Type"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.money_dollar_circle_fill,
                                        color: darkGreenColor,
                                      ),
                                      SizedBox(
                                        width: screenWidth * .007,
                                      ),
                                      Text1(
                                          fontColor: lightBlackColor,
                                          fontSize: screenWidth * .05,
                                          text: "Price"),
                                    ],
                                  ),
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
