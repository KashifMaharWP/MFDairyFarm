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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddMedical>(context, listen: false)
          .fetchMedicalRecords(context);
    });
  }

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
          Expanded(
            child: Consumer<AddMedical>(
              builder: (context, medicalProvider, child) {
                if (medicalProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final records =
                      medicalProvider.medicalData?.monthlyMedicalRecords ?? [];

                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items per row
                        crossAxisSpacing: 10, // Spacing between columns
                        mainAxisSpacing: 2, // Spacing between rows
                        childAspectRatio: screenWidth /
                            (screenHeight / 1.8), // Adjust as needed
                      ),
                      itemCount: records.length,
                      itemBuilder: (BuildContext context, int index) {
                        final record = records[index];
                        print(record);
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            width: screenWidth + 10,
                            height: screenHeight + 10,
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MedicalDetail(
                                                  id: record.cow.id ?? '',
                                                  url: record.cow.image,
                                                  tag: record.cow.animalNumber
                                                      .toString(),
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: screenHeight * .20,
                                    width: screenWidth * .58,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          record.cow.image,
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.tag_fill,
                                          color: darkGreenColor,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: screenWidth * .007,
                                        ),
                                        Text1(
                                            fontColor: lightBlackColor,
                                            fontSize: screenWidth * .04,
                                            text: record.cow.animalNumber
                                                .toString()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                              "lib/assets/medical.png"),
                                          width: screenWidth * .060,
                                          height: screenWidth * .060,
                                        ),
                                        SizedBox(
                                          width: screenWidth * .007,
                                        ),
                                        Text1(
                                            fontColor: lightBlackColor,
                                            fontSize: screenWidth * .04,
                                            text:
                                                "Vacination: ${record.totalVaccine.toString()}"),
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
              },
            ),
          ),
        ],
      ),
    );
  }

  //Wrap Text Container
}
