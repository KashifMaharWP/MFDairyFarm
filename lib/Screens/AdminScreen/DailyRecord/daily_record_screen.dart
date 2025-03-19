// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:dairyfarmflow/Functions/customDatePicker.dart';
import 'package:dairyfarmflow/Model/soldmilk.dart';
import 'package:dairyfarmflow/Providers/FeedProviders/feed_provider.dart';
import 'package:dairyfarmflow/ReuseableWidgets/reuse_row.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/DailyRecord/dailyRecordPDF.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/VendorList/VendorMilkSale.dart';
import 'package:dairyfarmflow/Screens/dailyList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import '../../../Providers/MilkProviders/milk_record.dart';
import '../../../Widget/customRoundButton.dart';
import '../../../Widget/textFieldWidget1.dart';
import '../MilkRecordScreen/milk_record.dart';

import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;

class DailyRecordScreen extends StatefulWidget {
  const DailyRecordScreen({super.key});

  @override
  State<DailyRecordScreen> createState() => _DailyRecordScreenState();
}

class _DailyRecordScreenState extends State<DailyRecordScreen> {
  final TextEditingController vendorName = TextEditingController();
  final TextEditingController amountSold = TextEditingController();
  final TextEditingController datePicker = TextEditingController();
  final TextEditingController totalPayment = TextEditingController();

  late DateTime _currentDate;
  late DateTime _selectedDate;
  DateTime selectedDate = DateTime.now();
  DateTime? pickedDate;
  List<SoldMilkRecord> vendorRecord=[];
  @override
  void initState() {
    super.initState();

    // Initialize _currentDate with the current date
    _currentDate = DateTime.now();

    // Initialize _selectedDate with the current date
    _selectedDate = _currentDate;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDataForSelectedDate();
    });
  }

  // Navigate to the previous day
  void _goToPreviousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
    _fetchDataForSelectedDate();
  }

  // Navigate to the next day
  void _goToNextDay() {
    if (_selectedDate.isAtSameMomentAs(_currentDate)) {
      // If the selected date is in the future, prevent navigation
      print('Cannot navigate to a future date.');
    } else {
      setState(() {
        _selectedDate = _selectedDate.add(const Duration(days: 1));
      });
      _fetchDataForSelectedDate();
    }
  }




  // Fetch data for the selected date
  void _fetchDataForSelectedDate() async {
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    final milkProvider =
        Provider.of<MilkRecordProvider>(context, listen: false);

    String formattedDate = DateFormat('EEE MMM dd yyyy').format(_selectedDate);
    print(selectedDate);
    
     feedProvider.fetchFeedCount(context, formattedDate);
     milkProvider.fetchMilkCount(context, formattedDate);
    await milkProvider.fetchMilkSoldForDate(
        context, _selectedDate.toString(), formattedDate.toString());
   vendorRecord= await milkProvider.fetchMilkSoldByDate(context, formattedDate);

  }

  Future<void> generateMilkReportPdf({
  required String morningMilk,
  required String eveningMilk,
  required String totalMilk,
  required String totalSold,
  required String usedFeed,
  required String morningFeed,
  required String eveningFeed,
  required DateTime selectedDate,
  required List<SoldMilkRecord>? vendorRecord, // Added null safety
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => [
        pw.Center(
          child: pw.Text(
            'Milk & Feed Report - ${DateFormat("EEE MMM dd yyyy").format(selectedDate)}',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Text('Milk Record:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Text('Morning: ${morningMilk.isNotEmpty ? morningMilk : '0'} Ltr'),
        pw.Text('Evening: ${eveningMilk.isNotEmpty ? eveningMilk : '0'} Ltr'),
        pw.Text('Total Milk: ${totalMilk.isNotEmpty ? totalMilk : '0'} Ltr'),
        pw.Text('Total Sold: ${totalSold.isNotEmpty ? totalSold : '0'} Ltr'),
        pw.SizedBox(height: 20),
        pw.Text('Feed Record:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Text('Total Used: ${usedFeed.isNotEmpty ? usedFeed : '0'} Kg'),
        pw.Text('Morning: ${morningFeed.isNotEmpty ? morningFeed : '0'} Kg'),
        pw.Text('Evening: ${eveningFeed.isNotEmpty ? eveningFeed : '0'} Kg'),
        pw.SizedBox(height: 20),
        pw.Text('Vendor Sales:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Table.fromTextArray(
          headers: ['Vendor Name', 'Amount Sold (Ltr)'],
          data: (vendorRecord?.isNotEmpty ?? false)
              ? vendorRecord!.map(
                  (record) => [
                    record.vendor?.name ?? 'Unknown',
                    '${record.amountSold ?? 0} Ltr',
                  ],
                ).toList()
              : [['No Data', '0 Ltr']], // Default if no records
        ),
      ],
    ),
  );

  final output = await getExternalStorageDirectory();
  final file = File("${output?.path}/milk_feed_report.pdf");
  await file.writeAsBytes(await pdf.save());

  OpenFile.open(file.path);
}



  @override
  Widget build(BuildContext context) {
    final milkProvider = Provider.of<MilkRecordProvider>(context);
    final feedProvider = Provider.of<FeedProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_left_sharp),
                color: Colors.white,
                onPressed: _goToPreviousDay, // Go to the previous day
              ),
              Text(
                DateFormat('dd MMM yyyy').format(_selectedDate),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_right_sharp),
                color: Colors.white,
                onPressed: _goToNextDay, // Go to the next day
              ),

              
            ],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.picture_as_pdf),
          onPressed: () async {
            if (vendorRecord.isEmpty ) {
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No records available to export')),
              );
            } else {
              

               await generateMilkReportPdf(
    morningMilk: milkProvider.morningMilk?? '0',
    eveningMilk: milkProvider.eveningMilk?? '0',
    totalMilk: milkProvider.total?? '0',
    totalSold: vendorRecord[0].amountSold.toString()?? '0',
    usedFeed: feedProvider.usedFeed.toString()?? '0',
    morningFeed: feedProvider.morningFeed.toString()?? '0',
    eveningFeed: feedProvider.eveningFeed.toString() ?? '0',
    selectedDate: selectedDate ?? DateTime.now(),
    vendorRecord: vendorRecord ?? []
  );
            }
          },
        ),
        
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: darkGreenColor,
          borderRadius: BorderRadius.circular(40)
        ),
        child: IconButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>DailyRecordPDF()));
        },
         icon: Icon(Icons.visibility, size: 25,color: Colors.white,)),
      ),
      body: Column(
        children: [
          pageHeaderContainer(),
          SizedBox(
            height: screenHeight * .023,
          ),
          Expanded(
            child: FutureBuilder<List<SoldMilkRecord>>(
              future: milkProvider.fetchMilkSoldByDate(
                context,
                DateFormat('EEE MMM dd yyyy').format(_selectedDate),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No Data Available for Selected Date'));
                } else if (snapshot.hasData) {
                  final dailyRecords = snapshot.data!;

                  return ListView.builder(
                    itemCount: dailyRecords.length,
                    itemBuilder: (context, index) {
                      final record = dailyRecords[index];

                      return GestureDetector(
                        onTap: (){
                         
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorMilkSaleList(vendorID:record.vendor!.id.toString(),)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Slidable(
                            startActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      vendorName.text =
                                          record.vendor!.name.toString();
                                      amountSold.text =
                                          record.amountSold.toString();
                                      totalPayment.text =
                                          record.totalPayment.toString();
                                      datePicker.text = record.date.toString();
                        
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  customTextFormField(
                                                    "Vendor Name",
                                                  ),
                                                  TextFieldWidget1(
                                                      keyboardtype:
                                                          TextInputType.number,
                                                      widgetcontroller:
                                                          vendorName,
                                                      fieldName: "Vendor Name",
                                                      isPasswordField: false),
                                                  SizedBox(
                                                    height: screenHeight * .025,
                                                  ),
                                                  customTextFormField(
                                                    "Milk Ltr",
                                                  ),
                                                  TextFieldWidget1(
                                                      keyboardtype:
                                                          TextInputType.number,
                                                      widgetcontroller:
                                                          amountSold,
                                                      fieldName: "Milk Ltr",
                                                      isPasswordField: false),
                                                  SizedBox(
                                                    height: screenHeight * .025,
                                                  ),
                        
                                                  dateContainer(),
                                                  // customTextFormField(
                                                  //   "Date",
                                                  // ),
                                                  // TextFieldWidget1(
                                                  //     widgetcontroller:
                                                  //         datePicker,
                                                  //     fieldName: "Date",
                                                  //     isPasswordField: false),
                                                  SizedBox(
                                                    height: screenHeight * .025,
                                                  ),
                                                  Center(
                                                    child: customRoundedButton(
                                                        loading: false,
                                                        title: "Update",
                                                        on_Tap: () async {
                                                          // print(record.sId);
                                                          datePicker
                                                              .text = DateFormat(
                                                                  "EEE MMM dd yyyy")
                                                              .format(
                                                                  selectedDate);
                                                          await Provider.of<
                                                                      MilkRecordProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .upadetMilkSold(
                                                                  id: record.id
                                                                      .toString(),
                                                                  vendorName:
                                                                      vendorName
                                                                          .text,
                                                                  datePicker:
                                                                      datePicker
                                                                          .text,
                                                                  amountSold:
                                                                      int.parse(
                                                                          amountSold
                                                                              .text),
                                                                  totalPayment: 0,
                                                                  context:
                                                                      context);
                                                          Navigator.pop(context);
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
                                  onPressed: (context) async {
                                    await Provider.of<MilkRecordProvider>(context,
                                            listen: false)
                                        .deleteMilkSold(
                                            id: record.id.toString(),
                                            context: context);
                                    setState(() {});
                                  },
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                )
                              ],
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 6,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Vendor Name
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                            "lib/assets/vendorMan.png"),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        record.vendor?.name ?? "Unknown",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                        
                                  // Amount Sold
                                  Row(
                                    children: [
                                      Text(
                                        "${record.amountSold} ltr",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(width: 4),
                                      Image.asset(
                                        "lib/assets/milkSale.png",
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No data available for selected date',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
              },
            ),
          )
        
        ],
      ),
    );
  }

  Widget dateContainer() {
    return InkWell(
      onTap: () async {
        pickedDate = await customDatePicker(context, selectedDate);
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate as DateTime;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(paragraph - 7),
        width: double.infinity,
        height: screenHeight / 10,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            border: Border.all(color: CupertinoColors.systemGrey, width: 1),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: CupertinoColors.systemGrey3,
                  offset: Offset(0, 2),
                  blurRadius: 8)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text1(
                fontColor: Colors.black,
                fontSize: paragraph,
                text: DateFormat("EEE MMM dd yyyy").format(selectedDate)),
            Icon(
              CupertinoIcons.calendar,
              color: darkGreenColor,
            )
          ],
        ),
      ),
    );
  }
}

Widget pageHeaderContainer() {
  return Material(
      elevation: 6,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      child: Container(
          height: screenHeight / 2.2,
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
            padding: EdgeInsets.only(
                top: screenHeight * .02,
                left: screenWidth * .02,
                right: screenWidth * .02),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * .02,
                ),

                //here is the code for the custom gridview boxes

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * .045),
                      child: Row(
                        children: [
                          Image(
                            image: const AssetImage("lib/assets/milk.png"),
                            width: screenHeight * .040,
                            height: screenHeight * .040,
                          ),
                          SizedBox(
                            width: screenWidth * .015,
                          ),
                          Text1(
                              fontColor: blackColor,
                              fontSize: screenWidth * .055,
                              text: "Milk Record"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .02,
                    ),
                    Consumer<MilkRecordProvider>(
                      builder: (context, milk, child) => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // ReuseRow(
                          //   text1: milk.morningMilk,
                          //   text2: "Morning",
                          //   text3: milk.eveningMilk,
                          //   text4: "Evening",
                          //   text5: milk.total,
                          //   text6: "Total Milk",
                          //   img1: "lib/assets/sun.png",
                          //   img2: "lib/assets/moon.png",
                          // ),
                          WrapCircleContainer(
                            text: milk.morningMilk,
                            label: "Morning",
                            optional: "lib/assets/sun.png",
                          ),
                          SizedBox(
                            height: paragraph / 4,
                          ),
                          Container(
                            width: 1,
                            height: screenWidth / 3.8,
                            color: CupertinoColors.systemGrey6,
                          ),
                          WrapCircleContainer(
                            text: milk.eveningMilk,
                            label: "Evening",
                            optional: "lib/assets/moon.png",
                          ),
                          SizedBox(
                            height: paragraph / 4,
                          ),
                          Container(
                            width: 1,
                            height: screenWidth / 3.8,
                            color: CupertinoColors.systemGrey6,
                          ),
                          WrapCircleContainer(
                            text: milk.total,
                            label: "Total Milk",
                          ),
                          SizedBox(
                            height: paragraph / 4,
                          ),
                          Container(
                            width: 1,
                            height: screenWidth / 3.8,
                            color: CupertinoColors.systemGrey6,
                          ),
                          WrapCircleContainer(
                            text: milk.totalMilk,
                            label: 'Total Sold',
                            optional: "lib/assets/vendorMan.png",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                      child: Divider(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * .045),
                      child: Row(
                        children: [
                          Image(
                            image: const AssetImage("lib/assets/wanda.png"),
                            width: screenHeight * .040,
                            height: screenHeight * .040,
                          ),
                          SizedBox(
                            width: screenWidth * .015,
                          ),
                          Text1(
                              fontColor: blackColor,
                              fontSize: screenWidth * .055,
                              text: "Feed Record"),
                        ],
                      ),
                    ),
                    Consumer<FeedProvider>(
                      builder: (context, value, child) => ReuseRow(
                        text1: value.usedFeed.toString(),
                        text2: "Total Used",
                        text3: value.morningFeed.toString(),
                        text4: "Morning",
                        text5: value.eveningFeed.toString(),
                        text6: "Evening",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )));
}

// Widget wrapCircleContainer(String text, label) {
//   return
// }
class WrapCircleContainer extends StatelessWidget {
  String text, label;
  String? optional;

  WrapCircleContainer({
    required this.text,
    required this.label,
    this.optional,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              optional == null
                  ? const Center()
                  : Image(
                      image: AssetImage(optional.toString()),
                      width: screenHeight * .025,
                      height: screenHeight * .025,
                    ),
              Text1(
                  fontColor: lightBlackColor, fontSize: paragraph, text: label),
            ],
          )
        ],
      ),
    );
  }
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
            offset: const Offset(2, 2),
            blurRadius: 2,
            spreadRadius: 2)
      ],
    ),
    child: Center(
        child: Text1(fontColor: blackColor, fontSize: paragraph, text: text)),
  );

  
}
