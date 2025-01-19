import 'dart:convert';
import 'dart:developer';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/AnimalDetails/animal_detail_model.dart';
import 'package:dairyfarmflow/Model/feed_consume.dart';
import 'package:dairyfarmflow/Providers/animal_registratin_provider.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AnimalDetail extends StatefulWidget {
  String tag, url, id;
  AnimalDetail(
      {super.key, required this.tag, required this.url, required this.id});

  @override
  State<AnimalDetail> createState() => _AnimalDetailState();
}

class _AnimalDetailState extends State<AnimalDetail> {
  late DateTime _currentMonth;
  late DateTime _selectedMonth;

  Future<void> deleteCow(BuildContext context, String cowId) async {
    print('Function called');
    try {
      final headers = {
        'Authorization':
            'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
      };
      final url =
          Uri.parse('${GlobalApi.baseApi}${GlobalApi.deleteAnimal}/$cowId');
      final response = await http.delete(url, headers: headers);
      print(response.statusCode);
      // debugger();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cow deleted successfully'),
          ),
        );
        Navigator.pop(context); // Call Navigator.pop after showing the SnackBar
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cow not found'),
          ),
        );
        Navigator.pop(context); // Call Navigator.pop after showing the SnackBar
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting cow'),
          ),
        );
        Navigator.pop(context); // Call Navigator.pop after showing the SnackBar
      }
    } catch (e) {
      print(e);
    }
  }

  void _goToPreviousMonth() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    });
  }

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedMonth = _currentMonth;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AnimalRegistratinProvider>(context, listen: false)
          .getAnimalDetailById(
              context, widget.id, DateFormat('MMM').format(_selectedMonth));
              Provider.of<AnimalRegistratinProvider>(context,listen: false).getVacineDetail(context,  DateFormat('MMM').format(_selectedMonth), widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    String monthName = DateFormat('MMMM yyyy').format(_selectedMonth);
    final provider =
        Provider.of<AnimalRegistratinProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(
            right: 40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.keyboard_arrow_left_sharp),
                  color: Colors.white,
                  onPressed: () {
                    _goToPreviousMonth();
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      Provider.of<AnimalRegistratinProvider>(context,
                              listen: false)
                          .getAnimalDetailById(context, widget.id,
                              DateFormat('MMM').format(_selectedMonth));
                    });
                  }),
              Text(
                monthName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right_sharp),
                color: Colors.white,
                onPressed: () {
                  if (_selectedMonth.month != _currentMonth.month) {
                    _goToNextMonth();
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      Provider.of<AnimalRegistratinProvider>(context,
                              listen: false)
                          .getAnimalDetailById(context, widget.id,
                              DateFormat('MMM').format(_selectedMonth));
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onLongPress: () => _showPopupMenu(context),
            child: Center(
              child: Image(
                image: NetworkImage(widget.url),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * .025,
          ),
          Consumer<AnimalRegistratinProvider>(
            builder: (context, animalRegProvider, child) {
              if (animalRegProvider.isDataFetched) {
                return Center(
                  child: CircularProgressIndicator(color: blackColor),
                );
              } else {
                return Column(
                  children: [
                    ReuseableWidget(
                      imgUrl: "lib/assets/cow.png",
                      text1: "Animal",
                      text2: widget.tag,
                    ),
                    SizedBox(
                      width: screenWidth * .85,
                      child: const Divider(),
                    ),
                    ReuseableWidget(
                      imgUrl: "lib/assets/milk.png",
                      text1: "Milk",
                      text2: "${animalRegProvider.milkCount} Liters",
                    ),
                    SizedBox(
                      width: screenWidth * .85,
                      child: const Divider(),
                    ),
                    ReuseableWidget(
                      imgUrl: "lib/assets/medical.png",
                      text1: "Vaccination",
                      text2: "${animalRegProvider.vacineCount}",
                    ),
                    SizedBox(
                      width: screenWidth * .85,
                      child: const Divider(),
                    ),
                  ],
                );
              }
            },
          ),
          Flexible(
            child: Consumer<AnimalRegistratinProvider>(
              builder: (context, animalProvider, child) {
                if (animalProvider.isDataFetched) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final animal = animalProvider
                          .animalDetail?.milkProductionMonthlyRecord ??
                      [];
                  return ListView.builder(
                    itemCount: animal.length,
                    itemBuilder: (context, index) {
                      final animalList = animal[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
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
                                offset: const Offset(2, 0),
                              ),
                            ],
                          ),
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
                                    text: animalList.date.toString(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image(
                                          image:
                                              AssetImage("lib/assets/sun.png"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * .005,
                                      ),
                                      Text1(
                                        fontColor: lightBlackColor,
                                        fontSize: screenWidth * .05,
                                        text: animalList.morning.toString(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image(
                                          image:
                                              AssetImage("lib/assets/moon.png"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * .005,
                                      ),
                                      Text1(
                                        fontColor: lightBlackColor,
                                        fontSize: screenWidth * .05,
                                        text: animalList.evening.toString(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an action'),
          actions: <Widget>[
            // Update action
            TextButton(
              onPressed: () {
                // Handle Update action
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.blue), // Edit icon
                  SizedBox(width: 8),
                  Text('Update', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            // Delete action
            TextButton(
              onPressed: () {
                deleteCow(context, widget.id);
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red), // Delete icon
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        );
      },
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
              SizedBox(
                height: 30,
                width: 30,
                child: Image(
                  image: AssetImage(imgUrl.toString()),
                ),
              ),
              const SizedBox(
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
