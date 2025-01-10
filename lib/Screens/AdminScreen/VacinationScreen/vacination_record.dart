import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/medical.dart';
import 'package:dairyfarmflow/Providers/Medical/add_medical.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/VacinationScreen/medical_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VacinationRecord extends StatefulWidget {
  const VacinationRecord({super.key});

  @override
  State<VacinationRecord> createState() => _VacinationRecordState();
}

class _VacinationRecordState extends State<VacinationRecord> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddMedical>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: const Text("Medical Record"),
      ),
      body: Column(
        children: [
          // SizedBox(
          //   height: screenHeight * .015,
          // ),
          // Container(
          //     width: screenWidth * 0.95,
          //     height: screenHeight * .07,
          //     decoration: BoxDecoration(
          //         color: Colors.white, borderRadius: BorderRadius.circular(10)),
          //     child: const Center(child: customFiltersWidget())),
          SizedBox(
            height: screenHeight * .015,
          ),
          Expanded(
            child: FutureBuilder<List<MonthlyMedicalRecord>>(
              future: provider.fetchMedicalRecords(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final records = snapshot.data!;
                  return ListView.builder(
                      itemCount: records.length,
                      itemBuilder: (BuildContext context, int index) {
                        final record = records[index];
                        print(record);
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            width: screenWidth * 0.95,
                            height: screenHeight / 3.4,
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
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                         MedicalDetail(id: record.cow.id, url: record.cow.image, tag: record.cow.animalNumber.toString(),)));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                //color: const Color.fromARGB(255, 210, 203, 203),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Image(
                                              image: NetworkImage(
                                                  record.cow.image),
                                              fit: BoxFit.fill,
                                            ),
                                            height: screenHeight * .18,
                                            width: screenWidth * .8,
                                            //color: Colors.red,
                                          ),
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
                                            text: record.cow.animalNumber
                                                .toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                              "lib/assets/medical.png"),
                                          width: screenWidth * .055,
                                          height: screenWidth * .055,
                                        ),
                                        SizedBox(
                                          width: screenWidth * .007,
                                        ),
                                        Text1(
                                            fontColor: lightBlackColor,
                                            fontSize: screenWidth * .05,
                                            text: record.date),
                                      ],
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Icon(
                                    //       CupertinoIcons.money_dollar_circle_fill,
                                    //       color: darkGreenColor,
                                    //     ),
                                    //     SizedBox(
                                    //       width: screenWidth * .007,
                                    //     ),
                                    //     Text1(
                                    //         fontColor: lightBlackColor,
                                    //         fontSize: screenWidth * .05,
                                    //         text: "Price"),
                                    //   ],
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
                return const Center();
              },
            ),
          ),
        ],
      ),
    );
  }

  //Wrap Text Container
}
