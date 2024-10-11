import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicalDetail extends StatefulWidget {
  const MedicalDetail({super.key});

  @override
  State<MedicalDetail> createState() => _MedicalDetailState();
}

class _MedicalDetailState extends State<MedicalDetail> {
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
        title: const Text("Medical Detail"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 21),
            child: Center(
              child: Container(
                height: screenHeight / 3,
                width: screenWidth / 1.1,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 159, 156, 156),
                    borderRadius: BorderRadius.circular(10)),
                child: const Image(
                    image: NetworkImage(
                        "https://static.vecteezy.com/system/resources/thumbnails/023/651/804/small/dairy-cow-on-transparent-background-created-with-generative-ai-png.png"),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * .025,
          ),
          ReuseableWidget(
            imgUrl: "lib/assets/cow.png",
            text1: "Animal",
            text2: "Tag",
          ),
          // SizedBox(
          //   width: screenWidth * .85,
          //   child: const Divider(),
          // ),
          // ReuseableWidget(
          //     imgUrl: "lib/assets/milk.png", text1: "Milk", text2: "Liters"),
          // SizedBox(
          //   width: screenWidth * .85,
          //   child: const Divider(),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 35, right: 35, top: 8),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Row(
          //         children: [
          //           Container(
          //             height: 30,
          //             width: 30,
          //             child: const Image(
          //               image: AssetImage("lib/assets/medical.png"),
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 10,
          //           ),
          //           Text1(
          //               fontColor: lightBlackColor,
          //               fontSize: screenWidth * .05,
          //               text: "Vacinated"),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           const Icon(
          //             Icons.check,
          //             color: Colors.green,
          //             size: 30,
          //           ),
          //           const SizedBox(
          //             width: 10,
          //           ),
          //           Text1(
          //               fontColor: lightBlackColor,
          //               fontSize: screenWidth * .05,
          //               text: "Yes"),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            width: screenWidth * .85,
            child: const Divider(),
          ),
          SizedBox(
            height: screenHeight * .010,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: screenWidth * 0.95,
                        height: screenHeight / 8.5,
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
                              children: [
                                Icon(
                                  Icons.calendar_month_sharp,
                                  color: darkGreenColor,
                                ),
                                SizedBox(
                                  width: screenWidth * .005,
                                ),
                                Text1(
                                    fontColor: lightBlackColor,
                                    fontSize: paragraph,
                                    text: DateFormat("dd MMMM yyyy")
                                        .format(DateTime.now())),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      child: const Image(
                                          image: AssetImage(
                                              "lib/assets/medical.png")),
                                    ),
                                    SizedBox(
                                      width: screenWidth * .005,
                                    ),
                                    Text1(
                                        fontColor: lightBlackColor,
                                        fontSize: screenWidth * .05,
                                        text: "Vacine Type")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      child: const Image(
                                          image: AssetImage(
                                              "lib/assets/Check.png")),
                                    ),
                                    SizedBox(
                                      width: screenWidth * .005,
                                    ),
                                    Text1(
                                        fontColor: lightBlackColor,
                                        fontSize: screenWidth * .05,
                                        text: "Yes")
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

class ReuseableWidget extends StatelessWidget {
  String? text1, text2;
  String? imgUrl;
  ReuseableWidget({
    this.imgUrl,
    required this.text1,
    required this.text2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 30,
                width: 30,
                child: Image(
                  image: AssetImage(imgUrl.toString()),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text1(
                  fontColor: lightBlackColor,
                  fontSize: screenWidth * .05,
                  text: text1.toString()),
            ],
          ),
          Row(
            children: [
              Text1(
                  fontColor: lightBlackColor,
                  fontSize: screenWidth * .05,
                  text: text2.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
