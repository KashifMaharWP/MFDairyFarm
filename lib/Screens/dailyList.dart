import 'dart:developer';
import 'dart:io';

import 'package:dairyfarmflow/Providers/FeedProviders/feed_provider.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_record.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;

class DailyList extends StatefulWidget {
  const DailyList({super.key});

  @override
  State<DailyList> createState() => _DailyListState();
}

class _DailyListState extends State<DailyList> {
  List<FeedRecord> feedRecords = [];
  List<MilkDataRecord> milkRecords = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
//     Provider.of<FeedProvider>(context, listen: false).fetchFeedCountsInRange(
//   context,
//   DateTime(2025, 1, 1),
//   DateTime(2025, 2, 13),
// );
if(mounted){
fetchFeedCountsForDateRange(
    context, DateTime(2025, 2, 9), DateTime(2025, 2, 13));

fetchMilkCountsForDateRange(
    context, DateTime(2025, 2, 9), DateTime(2025, 2, 13));

}
//  for (DateTime date = DateTime(2025, 2, 9);
//                   date.isBefore(DateTime(2025, 2, 13).add(const Duration(days: 1)));
//                   date = date.add(const Duration(days: 1))) {
//                 Provider.of<FeedProvider>(context, listen: false).fetchFeedCount(context, date);
//               }

    });
  }

  void fetchFeedCountsForDateRange(
    BuildContext context, DateTime startDate, DateTime endDate) async {
  int differenceInDays = endDate.difference(startDate).inDays;
  List<FeedRecord> tempRecords = [];
  List<MilkDataRecord> tempMilkRecords = [];

  for (int i = 0; i <= differenceInDays; i++) {
    DateTime currentDate = startDate.add(Duration(days: i));
    String formattedDate =
        DateFormat('EEE MMM dd yyyy').format(currentDate);

    FeedRecord? record = await Provider.of<FeedProvider>(context, listen: false).fetchFeedCount(context, formattedDate);
    MilkDataRecord? milkRecord=await Provider.of<MilkRecordProvider>(context, listen: false).fetchMilkCount(context, formattedDate);
    
    if (record != null) {
      tempRecords.add(record);
    }
    
    if(milkRecord!=null){
      tempMilkRecords.add(milkRecord);
    }
  }
  // Update the state with fetched records
  setState(() {
    feedRecords = tempRecords;
    milkRecords=tempMilkRecords;
  });
}


void fetchMilkCountsForDateRange(
    BuildContext context, DateTime startDate, DateTime endDate) async {
  int differenceInDays = endDate.difference(startDate).inDays;
  
  List<MilkDataRecord> tempMilkRecords = [];

  for (int i = 0; i <= differenceInDays; i++) {
    DateTime currentDate = startDate.add(Duration(days: i));
    String formattedDate =
        DateFormat('EEE MMM dd yyyy').format(currentDate);

     MilkDataRecord? milkRecord=await Provider.of<MilkRecordProvider>(context, listen: false).fetchMilkCount(context, formattedDate);
    
    
   
    if(milkRecord!=null){
      tempMilkRecords.add(milkRecord);
    }
  }
  // Update the state with fetched records
  setState(() {
    
    milkRecords=tempMilkRecords;
  });
}

Future<void> generateDailyReport(List<FeedRecord> feedRecords, List<MilkDataRecord> milkRecords) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Daily Feed & Milk Consumption Report',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Table.fromTextArray(
            headers: ['Date', 'Morning Feed', 'Evening Feed', 'Total Feed', 'Morning Milk', 'Evening Milk', 'Total Milk'],
            data: feedRecords.map((feed) {
              final milk = milkRecords.firstWhere(
                (m) => m.date == feed.date,
                orElse: () => MilkDataRecord(
                  date: feed.date,
                  morningMilk: 0,
                  eveningMilk: 0,
                  totalMilk: 0,
                ),
              );
              return [
                feed.date,
                feed.morningFeed,
                feed.eveningFeed,
                feed.totalFeed,
                milk.morningMilk,
                milk.eveningMilk,
                milk.totalMilk,
              ].map((e) => e.toString()).toList();
            }).toList(),
          ),
        ],
      ),
    ),
  );

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/daily_feed_milk_report.pdf';
  final file = File(filePath);

  await file.writeAsBytes(await pdf.save());
  await OpenFile.open(filePath);
}



  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Feed Consumption Records'),
      actions: [
        IconButton(
          icon: Icon(Icons.picture_as_pdf),
          onPressed: () async {
            if (feedRecords.isNotEmpty) {
              await generateDailyReport(feedRecords,milkRecords);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No records available to export')),
              );
            }
          },
        ),
      ],
    ),
    body: Consumer<FeedProvider>(
      builder: (context, provider, child) {
        if (feedRecords.isEmpty) {
          return const Center(child: Text('No records found.'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: feedRecords.length,
                  itemBuilder: (context, index) {
                    final record = feedRecords[index];
                    return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Date: ${record.date}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Morning: ${record.morningFeed}'),
                    Text('Evening: ${record.eveningFeed}'),
                    Text(
                      'Total: ${record.totalFeed}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
                    );
                  },
                    ),
            ),
          
           Expanded(
             child: ListView.builder(
                  itemCount: milkRecords.length,
                  itemBuilder: (context, index) {
                    final record = milkRecords[index];
                    return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Date: ${record.date}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Morning: ${record.morningMilk}'),
                    Text('Evening: ${record.eveningMilk}'),
                    Text(
                      'Total: ${record.totalMilk}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
                    );
                  },
                    ),
           ),
          
          ],
        );
      },
    ),
  );
}
}