import 'dart:convert';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/add_milk.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/MilkRecordScreen/add_evening_milk.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/MilkRecordScreen/add_morning_milk.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../Providers/MilkProviders/milk_record.dart';
import '../../../Providers/user_detail.dart';

class MilkRecordScreen extends StatefulWidget {
  const MilkRecordScreen({super.key});

  @override
  State<MilkRecordScreen> createState() => _MilkRecordScreenState();
}

class _MilkRecordScreenState extends State<MilkRecordScreen> {
  final TextEditingController _morningMilkContriller = TextEditingController();
  final TextEditingController _eveningMilkContriller = TextEditingController();
  final TextEditingController _totalMilkContriller = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers and remove listeners to prevent memory leaks
    _morningMilkContriller.dispose();
    _eveningMilkContriller.dispose();
    _totalMilkContriller.dispose();
    super.dispose();
  }

// Method to update the total
  void _updateTotal() {
    final int morningMilk = int.tryParse(_morningMilkContriller.text) ?? 0;
    final int eveningMilk = int.tryParse(_eveningMilkContriller.text) ?? 0;

    final int totalMilk = morningMilk + eveningMilk;

    // Update the total controller
    _totalMilkContriller.text = totalMilk.toString();
  }

  int? morningMilk;
  int? eveningMilk;
  int? totalMilk;

  bool isLoading = true; // For loading state
  String? errorMessage; // For error messages

  @override
  void initState() {
    super.initState();
    _morningMilkContriller.addListener(_updateTotal);
    _eveningMilkContriller.addListener(_updateTotal);
    fetchMilkData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final milkProvider =
          Provider.of<MilkRecordProvider>(context, listen: false);
      milkProvider.fetchMilkRecords(context);
      milkProvider.fetchMilkCount(context);
    });
  }

  Future<void> fetchMilkData() async {
    try {
      final data = await fetchMilkCount(context);
      if (data != null && data['success'] == true) {
        final milkCount = (data['todayMilkCount'] as List<dynamic>).first;
        setState(() {
          morningMilk = milkCount['morning'];
          eveningMilk = milkCount['evening'];
          totalMilk = (morningMilk ?? 0) + (eveningMilk ?? 0);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = data?['message'] ?? 'Failed to fetch milk count';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  void DeleteRecord(String id) async {
    await Provider.of<MilkProvider>(context, listen: false)
        .deleteMilkData(id: id, context: context);
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final milkProvider =
        Provider.of<MilkRecordProvider>(context, listen: false);

    milkProvider.fetchMilkRecords(context);

    // print(eveningMilk);
    final role = Provider.of<UserDetail>(context).role;
    //  print(role);
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
          isLoading
              ? Shimmer(
                  color: Colors.white,
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
                                color: greyGreenColor,
                                blurRadius: 6,
                                offset: Offset(2, 2))
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 30,
                                    ),
                                    SizedBox(
                                      height: paragraph / 4,
                                    ),
                                    Container(
                                      width: 1,
                                      height: screenWidth / 3.5,
                                      color: CupertinoColors.systemGrey6,
                                    ),
                                    const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 30,
                                    ),
                                    SizedBox(
                                      height: paragraph / 4,
                                    ),
                                    Container(
                                      width: 01,
                                      height: screenWidth / 3.8,
                                      color: CupertinoColors.systemGrey6,
                                    ),
                                    const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 30,
                                    ),
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
                      )))
              : pageHeaderContainer(totalMilk.toString(),
                  morningMilk.toString(), eveningMilk.toString()),
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
          Consumer<MilkRecordProvider>(
            builder: (context, value, child) => Expanded(
                child: ListView.builder(
                    itemCount: value.milkRecords.length,
                    itemBuilder: (BuildContext context, int index) {
                      final cow = value.milkRecords[index];
                      // print(cow);
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: role == "Employee"
                              ? () {
                                  ShowDialog(context, cow);
                                }
                              : null,
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
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image(
                                              image:
                                                  NetworkImage(cow.cow.image),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          height: screenHeight * .135,
                                          width: screenWidth * .8,
                                          //color: Colors.red,
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                        onTap: () {
                                          String id = cow.id;
                                          //print(id);
                                          String morning =
                                              cow.morning.toString();
                                          String evening =
                                              cow.evening.toString();
                                          String total = _morningMilkContriller
                                              .text = morning;

                                          _eveningMilkContriller.text = evening;

                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return SingleChildScrollView(
                                                              child:
                                                                  AlertDialog(
                                                                title: Center(
                                                                  child: Text1(
                                                                      fontColor:
                                                                          blackColor,
                                                                      fontSize:
                                                                          header5,
                                                                      text:
                                                                          "Update"),
                                                                ),
                                                                content: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    customTextFormField(
                                                                      "Morning Milk",
                                                                    ),
                                                                    TextFieldWidget1(
                                                                        widgetcontroller:
                                                                            _morningMilkContriller,
                                                                        fieldName:
                                                                            "Morning Milk",
                                                                        isPasswordField:
                                                                            false),
                                                                    SizedBox(
                                                                      height:
                                                                          screenHeight *
                                                                              .025,
                                                                    ),
                                                                    customTextFormField(
                                                                      "Evening Milk",
                                                                    ),
                                                                    TextFieldWidget1(
                                                                        widgetcontroller:
                                                                            _eveningMilkContriller,
                                                                        fieldName:
                                                                            "Evening Milk",
                                                                        isPasswordField:
                                                                            false),
                                                                    SizedBox(
                                                                      height:
                                                                          screenHeight *
                                                                              .025,
                                                                    ),
                                                                    customTextFormField(
                                                                      "Total Milk",
                                                                    ),
                                                                    TextFieldWidget1(
                                                                        widgetcontroller:
                                                                            _totalMilkContriller,
                                                                        fieldName:
                                                                            "Total Milk",
                                                                        isPasswordField:
                                                                            false),
                                                                    SizedBox(
                                                                      height:
                                                                          screenHeight *
                                                                              .025,
                                                                    ),
                                                                    Center(
                                                                      child: customRoundedButton(
                                                                          title: "Update",
                                                                          on_Tap: () async {
                                                                            await Provider.of<MilkProvider>(context, listen: false).upadetMilkData(
                                                                                id: id,
                                                                                morning: int.parse(_morningMilkContriller.text),
                                                                                evening: int.parse(_eveningMilkContriller.text),
                                                                                total: int.parse(_totalMilkContriller.text),
                                                                                context: context);
                                                                            Navigator.pop(context);
                                                                            setState(() {
                                                                              fetchMilkData();
                                                                            });
                                                                          }),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      leading: const Icon(
                                                          Icons.edit),
                                                      title: Text("Edit"),
                                                    ),
                                                    ListTile(
                                                      onTap: () =>
                                                          DeleteRecord(id),
                                                      leading: const Icon(
                                                          Icons.delete),
                                                      title:
                                                          const Text("Delete"),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.more_vert,
                                          size: screenWidth * .065,
                                        )),
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
                                                text: cow.cow.animalNumber
                                                    .toString()),
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
                                                text: "${cow.total} Kg"),
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
                                                text: "${cow.morning} Kg"),
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
                                                text: "${cow.evening} Kg"),
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
                    })
                // Example widget

                ),
          ),

          // Container(
          //   child: Expanded(
          //     child: FutureBuilder<List<TodayMilkRecord>>(
          //       future: getMilkRecord(context),
          //       builder: (context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         } else if (snapshot.hasError) {
          //           return const Center(
          //             child: Text("Error fetching cows data"),
          //           );
          //         } else if (!snapshot.hasData || snapshot.data == null) {
          //           return const Center(
          //             child: Text("No cows data found"),
          //           );
          //         } else {
          //           final milkRecords = snapshot.data!;
          //           return ListView.builder(
          //               itemCount: milkRecords.length,
          //               itemBuilder: (BuildContext context, int index) {
          //                 final cow = milkRecords[index];
          //                 return Padding(
          //                   padding: const EdgeInsets.all(5),
          //                   child: GestureDetector(
          //                     onTap: role == "Employee"
          //                         ? () {
          //                             showDialog(
          //                               context: context,
          //                               builder: (context) {
          //                                 return AlertDialog(
          //                                   content: Column(
          //                                     mainAxisSize: MainAxisSize.min,
          //                                     children: [
          //                                       ListTile(
          //                                         onTap: () {
          //                                           Navigator.push(
          //                                               context,
          //                                               MaterialPageRoute(
          //                                                   builder: (context) =>
          //                                                       AddMorningMilk(
          //                                                         id: cow.id,
          //                                                       )));
          //                                         },
          //                                         leading: Image(
          //                                           image: const AssetImage(
          //                                               "lib/assets/sun.png"),
          //                                           width: screenWidth * .075,
          //                                           height: screenWidth * .075,
          //                                         ),
          //                                         title: const Text("Morning"),
          //                                       ),
          //                                       ListTile(
          //                                         onTap: () {
          //                                           Navigator.push(
          //                                               context,
          //                                               MaterialPageRoute(
          //                                                   builder: (context) =>
          //                                                       AddEveningMilk(
          //                                                           id: cow
          //                                                               .id)));
          //                                         },
          //                                         leading: Image(
          //                                           image: const AssetImage(
          //                                               "lib/assets/moon.png"),
          //                                           width: screenWidth * .075,
          //                                           height: screenWidth * .075,
          //                                         ),
          //                                         title: const Text("Evening"),
          //                                       )
          //                                     ],
          //                                   ),
          //                                 );
          //                               },
          //                             );
          //                           }
          //                         : null,
          //                     child: Container(
          //                       width: screenWidth * 0.95,
          //                       height: screenHeight / 3.5,
          //                       padding: EdgeInsets.all(paragraph),
          //                       decoration: BoxDecoration(
          //                           color: Colors.white,
          //                           borderRadius:
          //                               BorderRadius.circular(paragraph),
          //                           boxShadow: [
          //                             BoxShadow(
          //                                 color: greyGreenColor,
          //                                 blurRadius: 6,
          //                                 spreadRadius: 3,
          //                                 offset: const Offset(2, 0)),
          //                           ]),
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Row(
          //                             children: [
          //                               Column(
          //                                 children: [
          //                                   Container(
          //                                     decoration: BoxDecoration(
          //                                         //color: const Color.fromARGB(255, 210, 203, 203),
          //                                         borderRadius:
          //                                             BorderRadius.circular(
          //                                                 20)),
          //                                     child: ClipRRect(
          //                                       borderRadius:
          //                                           BorderRadius.circular(10),
          //                                       child: Image(
          //                                         image: NetworkImage(
          //                                             cow.cow.image),
          //                                         fit: BoxFit.fill,
          //                                       ),
          //                                     ),
          //                                     height: screenHeight * .135,
          //                                     width: screenWidth * .8,
          //                                     //color: Colors.red,
          //                                   ),
          //                                 ],
          //                               ),
          //                               InkWell(
          //                                 onTap: () {},
          //                                 child: role == "Admin"
          //                                     ? Icon(
          //                                         Icons.more_vert,
          //                                         size: screenWidth * .065,
          //                                       )
          //                                     : const Icon(null),
          //                               ),
          //                             ],
          //                           ),
          //                           SizedBox(
          //                             height: screenHeight * .025,
          //                           ),
          //                           Column(
          //                             children: [
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Row(
          //                                     children: [
          //                                       Icon(
          //                                         CupertinoIcons.tag_fill,
          //                                         color: darkGreenColor,
          //                                       ),
          //                                       SizedBox(
          //                                         width: screenWidth * .007,
          //                                       ),
          //                                       Text1(
          //                                           fontColor: lightBlackColor,
          //                                           fontSize:
          //                                               screenWidth * .044,
          //                                           text: cow.cow.animalNumber
          //                                               .toString()),
          //                                     ],
          //                                   ),
          //                                   Row(
          //                                     children: [
          //                                       Icon(
          //                                         CupertinoIcons.add,
          //                                         color: darkGreenColor,
          //                                       ),
          //                                       SizedBox(
          //                                         width: screenWidth * .007,
          //                                       ),
          //                                       Text1(
          //                                           fontColor: lightBlackColor,
          //                                           fontSize:
          //                                               screenWidth * .044,
          //                                           text: "${cow.total} Kg"),
          //                                     ],
          //                                   ),
          //                                 ],
          //                               ),
          //                               SizedBox(
          //                                 height: screenHeight * .015,
          //                               ),
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Row(
          //                                     children: [
          //                                       Image(
          //                                         image: const AssetImage(
          //                                             "lib/assets/sun.png"),
          //                                         width: screenWidth * .055,
          //                                         height: screenWidth * .055,
          //                                       ),
          //                                       SizedBox(
          //                                         width: screenWidth * .007,
          //                                       ),
          //                                       Text1(
          //                                           fontColor: lightBlackColor,
          //                                           fontSize:
          //                                               screenWidth * .044,
          //                                           text: "${cow.morning} Kg"),
          //                                     ],
          //                                   ),
          //                                   Row(
          //                                     children: [
          //                                       Image(
          //                                         image: const AssetImage(
          //                                             "lib/assets/moon.png"),
          //                                         width: screenWidth * .055,
          //                                         height: screenWidth * .055,
          //                                       ),
          //                                       SizedBox(
          //                                         width: screenWidth * .007,
          //                                       ),
          //                                       Text1(
          //                                           fontColor: lightBlackColor,
          //                                           fontSize:
          //                                               screenWidth * .044,
          //                                           text: "${cow.evening} Kg"),
          //                                     ],
          //                                   ),
          //                                 ],
          //                               )
          //                             ],
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               });
          //         }
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<dynamic> ShowDialog(BuildContext context, TodayMilkRecord cow) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddMorningMilk(
                                id: cow.id,
                              )));
                },
                leading: Image(
                  image: const AssetImage("lib/assets/sun.png"),
                  width: screenWidth * .075,
                  height: screenWidth * .075,
                ),
                title: const Text("Morning"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEveningMilk(id: cow.id)));
                },
                leading: Image(
                  image: const AssetImage("lib/assets/moon.png"),
                  width: screenWidth * .075,
                  height: screenWidth * .075,
                ),
                title: const Text("Evening"),
              )
            ],
          ),
        );
      },
    );
  }

  //Wrap Text Container
}

Widget pageHeaderContainer(String Total, morning, evening) {
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
                            Total, "Total", 'lib/assets/milk.png'),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 1,
                          height: screenWidth / 3.5,
                          color: CupertinoColors.systemGrey6,
                        ),
                        wrapCircleContainer(
                            morning, "Morning", 'lib/assets/sun.png'),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 01,
                          height: screenWidth / 3.8,
                          color: CupertinoColors.systemGrey6,
                        ),
                        wrapCircleContainer(
                            evening, "Evening", 'lib/assets/moon.png'),
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

Future<Map<String, dynamic>?> fetchMilkCount(BuildContext context) async {
  final headers = {
    'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
  };
  final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.getMilkCount}');
  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    print(jsonData);
    return jsonData;
  } else {
    debugPrint("Error: ${response.reasonPhrase}");
    return null;
  }
}

Widget customTextFormField(
  String text,
) {
  return Wrap(
    alignment: WrapAlignment.start,
    runAlignment: WrapAlignment.center,
    crossAxisAlignment: WrapCrossAlignment.start,
    children: [
      //Icon(customIcon, color: darkGreenColor),
      Text1(fontColor: blackColor, fontSize: paragraph, text: text),
    ],
  );
}
