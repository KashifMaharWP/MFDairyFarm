import 'dart:developer';

import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/AnimalDetails/AnimalRecordPDF.dart';
import 'package:dairyfarmflow/Providers/animal_registratin_provider.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
          .getAnimalDetailById(context, widget.id,
              DateFormat('EEE MMM dd yyyy').format(_selectedMonth));
      Provider.of<AnimalRegistratinProvider>(context, listen: false)
          .getVacineDetail(
              context,
              DateFormat('EEE MMM dd yyyy').format(_selectedMonth),
              _selectedMonth.year,
              widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    String monthName = DateFormat('MMM yyyy').format(_selectedMonth);
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
                  icon: const Icon(Icons.keyboard_arrow_left_sharp),
                  color: Colors.white,
                  onPressed: () {
                    _goToPreviousMonth();
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      Provider.of<AnimalRegistratinProvider>(context,
                              listen: false)
                          .getAnimalDetailById(
                              context,
                              widget.id,
                              DateFormat('EEE MMM dd yyyy')
                                  .format(_selectedMonth));
                    });
                  }),
              Text(
                monthName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_right_sharp),
                color: Colors.white,
                onPressed: () {
                  if (_selectedMonth.month != _currentMonth.month) {
                    _goToNextMonth();
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      Provider.of<AnimalRegistratinProvider>(context,
                              listen: false)
                          .getAnimalDetailById(
                              context,
                              widget.id,
                              DateFormat('EEE MMM dd yyyy')
                                  .format(_selectedMonth));
                    });
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AnimalRecordPDF(id: widget.id,)));
          }, icon: Icon(Icons.picture_as_pdf))
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Image(
              image: NetworkImage(widget.url),
              fit: BoxFit.contain,
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
                      text2: animalRegProvider.vacineCount,
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
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Choose an action'),
                                actions: <Widget>[
                                  // Update action
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog first
                                      _showUpdateCowSheet(
                                          animalList.sId.toString(),
                                          animalList.morning.toString(),
                                          animalList.evening.toString(),
                                          animalProvider); // Call the function with parentheses
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.edit,
                                            color: Colors.blue), // Edit icon
                                        SizedBox(width: 8),
                                        Text('Update',
                                            style:
                                                TextStyle(color: Colors.blue)),
                                      ],
                                    ),
                                  ),
                                  // Delete action
                                  TextButton(
                                    onPressed: () async {
                                      // Call the deleteCow method from CowsProvider
                                      await provider.deleteMilk(
                                          animalList.sId.toString(), context);

                                      await provider.getAnimalDetailById(
                                          context,
                                          widget.id,
                                          DateFormat('EEE MMM dd yyyy')
                                              .format(_selectedMonth));
                                      // Close the dialog after deletion
                                      Navigator.of(context).pop();
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.delete,
                                            color: Colors.red), // Delete icon
                                        SizedBox(width: 8),
                                        Text('Delete',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Padding(
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
                                            image: AssetImage(
                                                "lib/assets/sun.png"),
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
                                            image: AssetImage(
                                                "lib/assets/moon.png"),
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

  void _showUpdateCowSheet(String cowId, morning, evening, provider) {
    // Controllers to manage input fields
    final TextEditingController morningController =
        TextEditingController(text: morning);
    final TextEditingController eveningTypeController =
        TextEditingController(text: evening);
    //final TextEditingController priceController = TextEditingController(text: price.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 16,
              left: 16,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Update Milk Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Cow ID Field
              TextField(
                controller: morningController,
                decoration: InputDecoration(
                  labelText: 'Morning Milk',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              // Breed Type Field
              TextField(
                controller: eveningTypeController,
                decoration: const InputDecoration(
                  labelText: 'Evening Milk',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Price Field

              const SizedBox(height: 16),
              // Save Button
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () async {
                    // Perform update logic

                    final updatedMorningMilk = morningController.text;
                    final updatedEveningMilk = eveningTypeController.text;
                    final updatedTotal = double.parse(updatedMorningMilk) +
                        double.parse(updatedEveningMilk);

                    // Call provider or API to update cow details
                    await provider.UpdateMilkRecord(
                      cowId,
                      updatedMorningMilk,
                      updatedEveningMilk,
                      updatedTotal.toString(),
                      context,
                    );

                    await provider.getAnimalDetailById(context, widget.id,
                        DateFormat('EEE MMM dd yyyy').format(_selectedMonth));

                    // Close the bottom sheet after saving
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Center(child: Text('Save Changes'))),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
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
