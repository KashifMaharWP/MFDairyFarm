import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/Medical/details_model.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Providers/Medical/add_medical.dart';

class MedicalDetail extends StatefulWidget {
  String id;
  String url;
  String tag;
  MedicalDetail(
      {super.key, required this.id, required this.url, required this.tag});

  @override
  State<MedicalDetail> createState() => _MedicalDetailState();
}

class _MedicalDetailState extends State<MedicalDetail> {
  late DateTime _currentMonth;
  late DateTime _selectedMonth;
  void _goToPreviousMonth() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
    });
  }

  // Navigate to the next month
  void _goToNextMonth() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    });
  }

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now(); // Initialize with the current month
    _selectedMonth = _currentMonth;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Initially fetch data for the selected month (you can adjust this if needed)
      Provider.of<AddMedical>(context, listen: false).fetchMedicalDetails(
          context, widget.id, DateFormat('MMM yyyy').format(_selectedMonth));
    });
  }

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_){
//       Provider.of<AddMedical>(context,listen: false).fetchMedicalDetails(context, widget.id);
//     });
//   }

  @override
  Widget build(BuildContext context) {
    String monthName = DateFormat('MMMM yyyy').format(_selectedMonth);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(
            right: 40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show the '<' button to go to the previous month, if it's  the current year
              IconButton(
                  icon: Icon(Icons.keyboard_arrow_left_sharp),
                  color: Colors.white,
                  onPressed: () {
                    // if (DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1)
                    //         .year !=
                    //     _currentMonth.year) {
                    //   // Show Snackbar if the year is not the current year
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //         content: Text(
                    //             'You can only see the records of the current year.')),
                    //   );
                    // } else {
                    _goToPreviousMonth();
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      Provider.of<AddMedical>(context, listen: false)
                          .fetchMedicalDetails(context, widget.id,
                              DateFormat('MMM yyyy').format(_selectedMonth));
                    });
                    //   }
                  } //_goToPreviousMonth,
                  ),
              // Display the current selected month in the middle
              Text(
                monthName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Show the '>' button to go to the next month, if it's not the current month
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right_sharp),
                color: Colors.white,
                onPressed: () {
                  if (_selectedMonth.month != _currentMonth.month) {
                    _goToNextMonth();
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      // Initially fetch data for the selected month (you can adjust this if needed)
                      Provider.of<AddMedical>(context, listen: false)
                          .fetchMedicalDetails(context, widget.id,
                              DateFormat('MMM yyyy').format(_selectedMonth));
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
          Image(image: NetworkImage(widget.url), fit: BoxFit.contain),
          SizedBox(
            height: screenHeight * .025,
          ),
          ReuseableWidget(
            imgUrl: "lib/assets/cow.png",
            text1: "Animal",
            text2: widget.tag,
          ),
          SizedBox(
            width: screenWidth * .85,
            child: const Divider(),
          ),
          SizedBox(
            height: screenHeight * .010,
          ),
          Expanded(child:
              Consumer<AddMedical>(builder: (context, medicalProvider, child) {
            if (medicalProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final medical =
                  medicalProvider.singleMedicalDetail?.cowMedicalRecord ?? [];
              return ListView.builder(
                  itemCount: medical.length,
                  itemBuilder: (context, index) {
                    final record = medical[index];
                    return GestureDetector(
                      onLongPress: (){

                      },
                      child: Dismissible(
                        key: Key(record.sId.toString()),
                        direction: DismissDirection.endToStart,
background:  _buildDismissBackground(),
confirmDismiss: (_) => _confirmDismiss(context, "Are you sure you want to delete this item?"),
onDismissed: (_) async {
      await Provider.of<AddMedical>(context,listen: false).DeleteMedicalRecord(context, record.sId.toString());
      setState(() {
        
      });
      },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: screenWidth * 0.95,
                            height: screenHeight / 6,
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
                                        text: record.date.toString()),
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
                                        const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Image(
                                              image: AssetImage(
                                                  "lib/assets/medical.png")),
                                        ),
                                        SizedBox(
                                          width: screenWidth * .005,
                                        ),
                                        Text1(
                                            fontColor: lightBlackColor,
                                            fontSize: screenWidth * .05,
                                            text: record.vaccineType.toString())
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Image(
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
                        ),
                      ),
                    );
                  });
            }
          }))
        ],
      ),
    );
  }

  Future<bool?> _confirmDismiss(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Delete',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          ),
          content: Text(
            message,
            style: GoogleFonts.montserrat(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: GoogleFonts.montserrat(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Delete',
                style: GoogleFonts.montserrat(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Icon(Icons.delete, color: Colors.white, size: 20),
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
