import 'dart:io';

import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Functions/customDatePicker.dart';
import 'package:dairyfarmflow/Providers/DailyRecordProvider/dailyRecordProvider.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DailyRecordPDF extends StatefulWidget {
  @override
  _DailyRecordPDFState createState() => _DailyRecordPDFState();
}

class _DailyRecordPDFState extends State<DailyRecordPDF> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

Future<void> generatePDF(DairyRecordProvider provider) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => [
         pw.Text("Daily Record Report", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text("Date Range: ${DateFormat('yyyy-MM-dd').format(startDate)} to ${DateFormat('yyyy-MM-dd').format(endDate)}"),
            pw.Divider(),
            pw.Text("Milk Production"),
            pw.Text("Morning Milk: ${provider.totalMorningMilk} Ltr"),
            pw.Text("Evening Milk: ${provider.totalEveningMilk} Ltr"),
            pw.Text("Milk Count: ${provider.milkCount} Ltr"),
            pw.Divider(),
            pw.Text("Feed Consumption"),
            pw.Text("Morning Feed: ${provider.totalMorningFeed} Kg"),
            pw.Text("Evening Feed: ${provider.totalEveningFeed} Kg"),
            pw.Text("Total Feed: ${provider.totalFeed} Kg"),
            pw.Divider(),
            pw.Text("Milk Sales"),
            pw.Text("Total Sold: ${provider.totalSoldAmount} Ltr"),
      ],
    ),
  );

  // Save PDF file
  final output = await getExternalStorageDirectory();
  final file = File("${output?.path}/animal_record_report.pdf");
  await file.writeAsBytes(await pdf.save());

  // Open PDF file
  OpenFile.open(file.path);
}



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
Provider.of<DairyRecordProvider>(context,listen: false).fetchDailyRecords(
                  context,
                  DateFormat('yyyy-MM-dd').format(startDate),
                  DateFormat('yyyy-MM-dd').format(endDate),
                );
    });

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DairyRecordProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Daily Record PDF")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            dateContainer(startDate, (newDate) {
                  setState(() {
                    startDate = newDate;
                  });
                }),
                SizedBox(height: 20),
                dateContainer(endDate, (newDate) {
                  setState(() {
                    endDate = newDate;
                  });
                }),
            SizedBox(height: 20),
            
            customRoundedButton(
                  loading: provider.isLoading,
                  title: "Generate PDF",
                  on_Tap: () async {
                    await Provider.of<DairyRecordProvider>(context,listen: false).fetchDailyRecords(
                  context,
                  DateFormat('yyyy-MM-dd').format(startDate),
                  DateFormat('yyyy-MM-dd').format(endDate),
                );
              generatePDF(provider);
                   
                  },
                ),
            
          ],
        ),
      ),
    );
  }

  

  Widget dateContainer(DateTime pickedDate, Function(DateTime) onDatePicked) {
    return InkWell(
      onTap: () async {
        DateTime? newPickedDate = await customDatePicker(context, pickedDate);
        if (newPickedDate != null) {
          onDatePicked(newPickedDate);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: screenHeight / 10,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          border: Border.all(color: CupertinoColors.systemGrey, width: 1),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: CupertinoColors.systemGrey3,
              offset: Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text1(
              fontColor: blackColor,
              fontSize: 14,
              text: DateFormat("EEE MMM dd yyyy").format(pickedDate),
            ),
            Icon(
              CupertinoIcons.calendar,
              color: darkGreenColor,
            ),
          ],
        ),
      ),
    );
  }

  
}
