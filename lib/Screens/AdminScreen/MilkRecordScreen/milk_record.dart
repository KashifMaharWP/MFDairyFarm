import 'dart:convert';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/add_milk.dart';
import 'package:dairyfarmflow/Providers/Filter%20Provider/filter.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/MilkRecordScreen/add_evening_milk.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/MilkRecordScreen/add_morning_milk.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/animali_record_widget.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:dairyfarmflow/Widget/textFieldWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../Providers/MilkProviders/milk_record.dart';
import '../../../Providers/user_detail.dart';
import '../../../Widget/custom_filter_widget.dart';

class MilkRecordScreen extends StatefulWidget {
  const MilkRecordScreen({super.key});

  @override
  State<MilkRecordScreen> createState() => _MilkRecordScreenState();
}

class _MilkRecordScreenState extends State<MilkRecordScreen> {
   String role = '';
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
      milkProvider.fetchMilkCount(context,DateFormat('EEE MMM dd yyyy').format(DateTime.now()));
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

  void deleteRecord(String id) async {
    
    await Provider.of<MilkProvider>(context, listen: false)
        .deleteMilkData(id: id, context: context);
    fetchMilkData();
    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
   
    final selected = Provider.of<FilterProvider>(context).filtering;
    
    final milkProvider =
        Provider.of<MilkRecordProvider>(context, listen: false);

    milkProvider.fetchMilkRecords(context);

    // print(eveningMilk);
     role = Provider.of<UserDetail>(context).role.toString();
    //  print(role);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10,),
            Image.asset(
              "lib/assets/milk.png",
              width: 30,
              
            ),
            const Text("Milk Record"),
          ],
        ),
      ),
      body: Column(
        children: [
          isLoading
              ? Shimmer(
                  color: Colors.white,
                  child: Container(
                      height: screenHeight / 4.5,
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
                                offset: const Offset(2, 2))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
                                      radius: 25,
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
                                      radius: 25,
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
                                      radius: 25,
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
                            ),
                          ],
                        ),
                      )))
              : Consumer<MilkRecordProvider>(
                builder: (context, value, child) => 
                 pageHeaderContainer(
                    totalMilk == null ? "0" : value.total,
                    morningMilk == null ? "0" :value.morningMilk,
                    eveningMilk == null ? "0" : value.eveningMilk),
              ),
          SizedBox(
            height: screenHeight * .015,
          ),
          Container(
                  width: screenWidth * 0.95,
                  height: screenHeight * .07,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(child: customFiltersWidget()),
                ),
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
         selected == "Milk"? Consumer<MilkRecordProvider>(
            builder: (context, value, child) => value.milkRecords.isEmpty
                ? Center(
                    child: value.isLoading
                        ? const CircularProgressIndicator()
                        : Text1(
                            fontColor: lightBlackColor,
                            fontSize: paragraph,
                            text: "No Milk Record",
                          ),
                  )
                : Flexible(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Two items per row
                                crossAxisSpacing: 10, // Spacing between columns
                                mainAxisSpacing: 2, // Spacing between rows
                                childAspectRatio:
                    screenWidth / (screenHeight / 1.8), // Adjust as needed
                              ),
                      itemCount: value.milkRecords.length,
                      itemBuilder: (BuildContext context, int index) {
                       
                        final cow = value.milkRecords[index];
                        // print(cow);
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Slidable(
                            key: ValueKey(cow.id),
                            startActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      String id = cow.id;
                                      //print(id);
                                      String morning = cow.morning.toString();
                                      String evening = cow.evening.toString();
                                      String total = _morningMilkContriller
                                          .text = morning;
                              
                                      _eveningMilkContriller.text = evening;
                              
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SingleChildScrollView(
                                            child: AlertDialog(
                                              title: Center(
                                                child: Text1(
                                                    fontColor: blackColor,
                                                    fontSize: header5,
                                                    text: "Update"),
                                              ),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: [
                                                  customTextFormField(
                                                    "Morning Milk",
                                                  ),
                                                  TextFieldWidget1(
                                                      keyboardtype:
                                                          TextInputType
                                                              .number,
                                                      widgetcontroller:
                                                          _morningMilkContriller,
                                                      fieldName:
                                                          "Morning Milk",
                                                      isPasswordField: false),
                                                  SizedBox(
                                                    height:
                                                        screenHeight * .025,
                                                  ),
                                                  customTextFormField(
                                                    "Evening Milk",
                                                  ),
                                                  TextFieldWidget1(
                                                      keyboardtype:
                                                          TextInputType
                                                              .number,
                                                      widgetcontroller:
                                                          _eveningMilkContriller,
                                                      fieldName:
                                                          "Evening Milk",
                                                      isPasswordField: false),
                                                  SizedBox(
                                                    height:
                                                        screenHeight * .025,
                                                  ),
                                                  customTextFormField(
                                                    "Total Milk",
                                                  ),
                                                  TextFieldWidget1(
                                                      isReadOnly: true,
                                                      widgetcontroller:
                                                          _totalMilkContriller,
                                                      fieldName: "Total Milk",
                                                      isPasswordField: false),
                                                  SizedBox(
                                                    height:
                                                        screenHeight * .025,
                                                  ),
                                                  Center(
                                                    child:
                                                        customRoundedButton(
                                                            loading:
                                                                isLoading,
                                                            title: "Update",
                                                            on_Tap: () async {
                                                              await Provider.of<MilkProvider>(context, listen: false).upadetMilkData(
                                                                  id: id,
                                                                  morning: int.parse(
                                                                      _morningMilkContriller
                                                                          .text),
                                                                  evening: int.parse(
                                                                      _eveningMilkContriller
                                                                          .text),
                                                                  total: int.parse(
                                                                      _totalMilkContriller
                                                                          .text),
                                                                  context:
                                                                      context);
                                                              Navigator.pop(
                                                                  context);
                                                                  
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
                                    backgroundColor: Colors.blue,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                ]),
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    deleteRecord(cow.id);
                                    setState(() {});
                                  },
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                )
                              ],
                            ),
                            child: Container(
                              width: screenWidth * 0.95,
                              height: screenHeight / 2.5,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(paragraph),
                                  boxShadow: [
                                    BoxShadow(
                                        color: greyGreenColor,
                                        blurRadius: 6,
                                        spreadRadius: 3,
                                        offset: const Offset(2, 0)),
                                  ]),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Center(
                                        child: ClipRRect(
                                          borderRadius:  BorderRadius.circular(10),
                                          child: Image(
                                            image: NetworkImage(
                                                cow.cow.image),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
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
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: screenWidth * .007,
                                              ),
                                              Text1(
                                                  fontColor:
                                                      lightBlackColor,
                                                  fontSize: paragraph,
                                                  text: cow
                                                      .cow.animalNumber
                                                      .toString()),
                                            ],
                                          ),
                                          SizedBox(
                                            width: screenWidth * .055,
                                          ),
                                          Row(
                                            children: [
                                              Text1(
                                                  fontColor:
                                                      lightBlackColor,
                                                  fontSize: paragraph,
                                                  text:
                                                      "Total:"),
                                              SizedBox(
                                                width: screenWidth * .007,
                                              ),
                                              Text1(
                                                  fontColor:
                                                      lightBlackColor,
                                                  fontSize: paragraph,
                                                  text:
                                                      "${cow.total} Kg"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: screenHeight * .025,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
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
                                                  fontSize: paragraph,
                                                  text: "${cow.morning} Kg"),
                                            ],
                                          ),
                                          SizedBox(
                                            width: screenWidth * .055,
                                          ),
                                          Row(
                                            children: [
                                              Image(
                                                image: const AssetImage(
                                                    "lib/assets/moon.png"),
                                                width: screenWidth * .055,
                                                height:
                                                    screenWidth * .055,
                                              ),
                                              SizedBox(
                                                width: screenWidth * .007,
                                              ),
                                              Text1(
                                                  fontColor:
                                                      lightBlackColor,
                                                  fontSize: paragraph,
                                                  text:
                                                      "${cow.evening} Kg"),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
          ):AnimalRecordWidget(role: role)

         
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
          height: screenHeight / 4.5,
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
                    offset: const Offset(2, 2))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * .02,
                ),
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
          height: 5,
        ),
        Row(
          children: [
            Image(
              image: AssetImage(url),
              width: screenWidth * .07,
              height: screenWidth * .07,
            ),
            SizedBox(
              width: screenWidth * .005,
            ),
            Text1(fontColor: lightBlackColor, fontSize: header5, text: label),
          ],
        )
      ],
    ),
  );
}

Widget circleContainer(String text) {
  return Container(
    width: screenWidth / 5.5,
    height: screenWidth / 5.5,
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
        child: Text1(fontColor: blackColor, fontSize: paragraph, text: text)),
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


