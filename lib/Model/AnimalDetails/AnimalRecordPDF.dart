import 'dart:io';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Functions/customDatePicker.dart';
import 'package:dairyfarmflow/Model/AnimalDetails/milkProductionModel.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

class AnimalRecordPDF extends StatefulWidget {
  final String id;
  AnimalRecordPDF({super.key, required this.id});

  @override
  State<AnimalRecordPDF> createState() => _AnimalRecordPDFState();
}

class _AnimalRecordPDFState extends State<AnimalRecordPDF> {
  DateTime initialPickedDate = DateTime.now();
  DateTime finalPickedDate = DateTime.now();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialPickedDate = DateTime.now().subtract(Duration(days: 1));
  finalPickedDate = DateTime.now();
  }
  Future<void> generatePDF(CowDetailsResponse data) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => [
        pw.Center(
          child: pw.Text(
            'Animal Record Report',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          'Report Date Range: ${DateFormat("EEE MMM dd yyyy").format(initialPickedDate)} to ${DateFormat("EEE MMM dd yyyy").format(finalPickedDate)}',
          style: pw.TextStyle(fontSize: 14),
        ),
        pw.SizedBox(height: 20),

        // Milk Production Table
        pw.Text('Milk Production Record:',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Table.fromTextArray(
          headers: ['Date', 'Morning (Ltr)', 'Evening (Ltr)', 'Total (Ltr)'],
          data: (data.milkRecords ?? []).map((record) => [
            record.date ?? "N/A",
            record.morning?.toString() ?? "0",
            record.evening?.toString() ?? "0",
            record.total?.toString() ?? "0",
          ]).toList(),
        ),
        pw.SizedBox(height: 10),
        pw.Text('Total Milk Production: ${data.milkCount ?? 0} Ltr',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),

        pw.SizedBox(height: 20),
        pw.Text('Feed Consumption Record:',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Table.fromTextArray(
          headers: ['Date', 'Morning', 'Evening', 'Total'],
          data: (data.feedRecords ?? []).map((record) => [
            record.date ?? "N/A",
            record.morning?.toString() ?? "0",
            record.evening?.toString() ?? "0",
            record.total?.toString() ?? "0",
          ]).toList(),
        ),
pw.SizedBox(height: 10),
        pw.Text('Total Feed Consumption: ${data.feedConsumptionCount ?? 0} ',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),

        pw.SizedBox(height: 20),
        pw.Text('Medical Record:',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Table.fromTextArray(
          headers: ['Date', 'Vaccination Type'],
          data: (data.medicalRecords ?? []).map((record) => [
            record.date ?? "N/A",
            record.vaccineType ?? "N/A",
          ]).toList(),
        ),
        pw.SizedBox(height: 10),
        pw.Text('Total Vaccination: ${data.vaccinationCount ?? 0}',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MilkProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dateContainer(initialPickedDate, (newDate) {
                  setState(() {
                    initialPickedDate = newDate;
                  });
                }),
                SizedBox(height: 20),
                dateContainer(finalPickedDate, (newDate) {
                  setState(() {
                    finalPickedDate = newDate;
                  });
                }),
                SizedBox(height: 20),
                customRoundedButton(
                  loading: provider.isLoading,
                  title: "Generate PDF",
                  on_Tap: () async {
                    final data = await provider.getPDFRecord(
                      widget.id,
                      initialPickedDate.toString(),
                      finalPickedDate.toString(),
                      context,
                    );

                    if (data != null) {
                      print("Data: ${data.milkRecords?[0].evening}");
                      await generatePDF(data);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to fetch data")));
                    }
                  },
                ),
              ],
            );
          },
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
