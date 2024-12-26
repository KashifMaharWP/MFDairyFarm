import 'dart:convert';
import 'dart:developer';

import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../API/global_api.dart';
import '../../../Providers/FeedProviders/feed_provider.dart';
import '../../../Class/colorPallete.dart';
import '../../../Class/screenMediaQuery.dart';
import '../../../Providers/user_detail.dart';
import '../../../Widget/Text1.dart';

class FeedRecord extends StatefulWidget {
  const FeedRecord({super.key});

  @override
  State<FeedRecord> createState() => _FeedRecordState();
}

class _FeedRecordState extends State<FeedRecord> {
  String Date='Dec';
  @override
  void initState() {
    super.initState();
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    //debugger();
    feedProvider.fetchFeedConsumption(context,Date);
  }

  @override
  Widget build(BuildContext context) {
    final feedProvider = Provider.of<FeedProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: const Text("Feed Record"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * .015),
        child: Column(
          children: [
            feedProvider.isLoading
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
                                  offset: const Offset(2, 2))
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
                : pageHeaderContainer(
                    context, feedProvider.totalFeedFromItem, 0),
            SizedBox(height: screenHeight * .025),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.calendar_month_sharp, color: darkGreenColor),
                SizedBox(width: screenWidth * .010),
                Text1(
                  fontColor: lightBlackColor,
                  fontSize: screenWidth * .05,
                  text: DateFormat("MMMM yyyy").format(DateTime.now()),
                ),
              ],
            ),
            SizedBox(height: screenHeight * .010),
            Expanded(
              child: feedProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : feedProvider.errorMessage != null
                      ? Center(
                          child: Text(feedProvider.errorMessage!),
                        )
                      : feedProvider.feedConsumptions == null
                          ? const Center(
                              child: Text("No feed data found"),
                            )
                          : ListView.builder(
                              itemCount: feedProvider.feedConsumptions!.length,
                              itemBuilder: (context, index) {
                                final feed =
                                    feedProvider.feedConsumptions![index];
                                return Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * .025,
                                      horizontal: screenWidth * .025,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: screenHeight * .035,
                                              width: screenHeight * .035,
                                              child: const Image(
                                                image: AssetImage(
                                                    "lib/assets/wanda.png"),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * .015,
                                            ),
                                            Text1(
                                              fontColor: lightBlackColor,
                                              fontSize: screenWidth * .05,
                                              text: "${feed.date}",
                                            ),
                                          ],
                                        ),
                                        Text1(
                                          fontColor: lightBlackColor,
                                          fontSize: screenWidth * .05,
                                          text: "${feed.total} Kg",
                                        ),
                                      ],
                                    ),
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
}

Widget pageHeaderContainer(BuildContext context, int consumedFeed, feeds) {
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
                    color: greyGreenColor,
                    blurRadius: 6,
                    offset: const Offset(2, 2))
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
                        FutureBuilder<dynamic>(
                          future: fetchFeed(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return wrapCircleContainer("0", "Total");
                            } else if (snapshot.hasError) {
                              return wrapCircleContainer("0", "Total");
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              final feedAvailable = int.tryParse(snapshot
                                      .data['feedInventory']['feedAmount']
                                      .toString()) ??
                                  0;
                              final totalFeedStored =
                                  feedAvailable + consumedFeed;

                              // Display total feed stored
                              return wrapCircleContainer(
                                  "$totalFeedStored", "Total");
                            } else {
                              return wrapCircleContainer("0", "Total");
                            }
                          },
                        ),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 1,
                          height: screenWidth / 3.8,
                          color: CupertinoColors.systemGrey6,
                        ),
                        wrapCircleContainer(consumedFeed.toString(), "Used"),
                        SizedBox(
                          height: paragraph / 4,
                        ),
                        Container(
                          width: 1,
                          height: screenWidth / 3.8,
                          color: CupertinoColors.systemGrey6,
                        ),
                        FutureBuilder<dynamic>(
                          future: fetchFeed(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return wrapCircleContainer("0", "Available");
                            } else if (snapshot.hasError) {
                              return wrapCircleContainer("0", "Available");
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              return wrapCircleContainer(
                                  "${snapshot.data['feedInventory']['feedAmount']}",
                                  "Available");
                            } else {
                              return const Text('No data available');
                            }
                          },
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
          )));
}

Widget wrapCircleContainer(String text, label) {
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
        Text1(fontColor: lightBlackColor, fontSize: paragraph, text: label)
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
            offset: const Offset(2, 2),
            blurRadius: 2,
            spreadRadius: 2)
      ],
    ),
    child: Center(
        child: Text1(fontColor: blackColor, fontSize: paragraph, text: text)),
  );
}

Future<dynamic> fetchFeed(BuildContext context) async {
  var headers = {
    'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
  };
  var request = http.Request(
    'GET',
    Uri.parse('${GlobalApi.baseApi}feedInventory/feedAmount'),
  );

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final jsonString = await response.stream.bytesToString();
    final jsonData = json.decode(jsonString);
    print(jsonData['feedInventory']['feedAmount']);

    return jsonData;
  } else {
    if (kDebugMode) {
      print("Error: ${response.reasonPhrase}");
    }
    return null;
  }
}

// Future<List<FeedConsumption>?> fetchFeedConsumption(
//     BuildContext context) async {
//   final headers = {
//     'Authorization':
//         'Bearer ${Provider.of<UserDetail>(context, listen: false).token}',
//   };
//   final url = Uri.parse('${GlobalApi.baseApi}${GlobalApi.getFeedConsumption}');
//   final response = await http.get(url, headers: headers);

//   if (response.statusCode == 200) {
//     final jsonData = json.decode(response.body);
//     if (jsonData['success'] == true) {
//       final feedConsumptionList = (jsonData['feedConsumtion'] as List)
//           .map((item) => FeedConsumption.fromJson(item))
//           .toList();
//       return feedConsumptionList;
//     } else {
//       // Handle failure response
//       print('Error: ${jsonData['message']}');
//       return null;
//     }
//   } else {
//     print('Failed to fetch data. Error: ${response.reasonPhrase}');
//     return null;
//   }


//https://www.behance.net/gallery/187496733/Dairy-Farm-Management-Mobile-App-UI-Design?tracking_source=search_projects|Dairy+Management&l=0