import 'dart:io';

import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Functions/customDatePicker.dart';
import 'package:dairyfarmflow/Model/vendorMilkSalelistModel.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/customRoundButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';

import 'package:pdf/widgets.dart' as pw;

class VendorMilkSaleList extends StatefulWidget {
  final String vendorID;
  VendorMilkSaleList({super.key, required this.vendorID});

  @override
  State<VendorMilkSaleList> createState() => _VendorMilkSaleListState();
}

class _VendorMilkSaleListState extends State<VendorMilkSaleList> {
  DateTime initialPickedDate = DateTime.now();
  DateTime finalPickedDate = DateTime.now();
  VendorMilkSaleListResponse? saleList;


  Future<void> generateVendorMilkSalePDF(
    VendorMilkSaleListResponse data, DateTime startDate, DateTime endDate) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => [
        pw.Center(
          child: pw.Text(
            'Milk Sale Report',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          'Report Date Range: ${DateFormat("EEE MMM dd yyyy").format(startDate)} to ${DateFormat("EEE MMM dd yyyy").format(endDate)}',
          style: pw.TextStyle(fontSize: 14),
        ),
        pw.SizedBox(height: 20),

        // Milk Sale Table
        pw.Text('Milk Sale Records:',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Table.fromTextArray(
          headers: ['Date', 'Amount Sold (Ltr)', ],
          data: data.milkSaleRecords.map((record) => [
            record.date ?? "N/A",
            record.amountSold?.toString() ?? "0",
            
          ]).toList(),
        ),
        pw.SizedBox(height: 10),
       pw.Text(
  'Total Milk Sold: ${data.milkSaleRecords.fold<num>(0, (sum, item) => sum + (item.amountSold))} Ltr',
  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
),
      ],
    ),
  );

  // Save PDF file
  final output = await getExternalStorageDirectory();
  final file = File("${output?.path}/milk_sale_report.pdf");
  await file.writeAsBytes(await pdf.save());

  // Open PDF file
  OpenFile.open(file.path);
}

  @override
  void initState() {
    super.initState();
    initialPickedDate = DateTime.now().subtract(Duration(days: 1));
  finalPickedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    final provider = Provider.of<MilkProvider>(context, listen: false);
    final response = await provider.fetchVendorsMonthSale(
      context,
      widget.vendorID,
    );

    setState(() {
      saleList = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<MilkProvider>(
              builder: (context,provider,child) {
                return Column(
                  children: [
                    dateContainer(initialPickedDate, (newDate) {
                      setState(() {
                        initialPickedDate = newDate;
                      });
                      fetchData();
                    }),
                    SizedBox(height: 20),
                    dateContainer(finalPickedDate, (newDate) {
                      setState(() {
                        finalPickedDate = newDate;
                      });
                      fetchData();
                    }),
                    SizedBox(height: 20),
                    customRoundedButton(
                      loading: provider.isLoading,
                      title: "Generate PDF",
                      on_Tap: () async {
                
                        final data = await provider.fetchVendorsRecord(
                          context,
                          widget.vendorID,
                          initialPickedDate.toString(),
                          finalPickedDate.toString(),
                        
                        );
                
                        if (data != null) {
                         // print("Data: ${data?[0].evening}");
                          await generateVendorMilkSalePDF(data,initialPickedDate,finalPickedDate);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Failed to fetch data")));
                        }
                        
                      },
                    ),
                  ],
                );
              }
            ),
            SizedBox(height: 20),
           
            Expanded(
              child: saleList == null
                  ? Center(child: CircularProgressIndicator())
                  : saleList!.milkSaleRecords.isEmpty
                      ? Center(child: Text("No records found"))
                      : ListView.builder(
                          itemCount: saleList!.milkSaleRecords.length,
                          itemBuilder: (context, index) {
                            final milkSale = saleList!.milkSaleRecords[index];
                            return Card(
                              child: ListTile(
                                title: Text("Amount Sold: ${milkSale.amountSold} Kg"),
                                subtitle: Text(
                                    "Date: ${milkSale.date}"),
                              ),
                            );
                          },
                        ),
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
