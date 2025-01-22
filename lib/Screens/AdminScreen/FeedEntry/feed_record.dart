import 'dart:convert';
import 'dart:developer';

import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/feed_inventory.dart';
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
  //final date = DateFormat("EEE MMM dd yyyy").format(DateTime.now());
  // String date = "Jan 2025";
  // @override
  // void initState() {
  //   super.initState();
  //   final feedProvider = Provider.of<FeedProvider>(context, listen: false);
  //   //debugger();
  //   feedProvider.fetchFeedConsumption(context, date);
  // }
  late DateTime _currentMonth;
  late DateTime _selectedMonth;
  void _goToPreviousMonth() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
    });
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    feedProvider.fetchFeedConsumption(
        context, DateFormat('MMM').format(_selectedMonth).toLowerCase());
  }

  void _goToNextMonth() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    });
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    feedProvider.fetchFeedConsumption(
        context, DateFormat('MMM').format(_selectedMonth).toLowerCase());
  }

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now(); // Initialize with the current month
    _selectedMonth = _currentMonth;

    // Fetch feed consumption for the current month
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final feedProvider = Provider.of<FeedProvider>(context, listen: false);
      feedProvider.fetchFeedConsumption(
          context, DateFormat('MMM').format(_selectedMonth).toLowerCase());
          feedProvider.fetchFeed(context, DateFormat('MMM yyyy').format(_selectedMonth).toLowerCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    final feedProvider = Provider.of<FeedProvider>(context);
    String monthName = DateFormat('MMM yyyy').format(_selectedMonth);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.keyboard_arrow_left_sharp),
                color: Colors.white,
                onPressed: () {
                  _goToPreviousMonth(); // Go to the previous month and fetch data
                },
              ),
              Text(
                DateFormat('MMM yyyy').format(_selectedMonth),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right_sharp),
                color: Colors.white,
                onPressed: () {
                  if (_selectedMonth.month != _currentMonth.month) {
                    _goToNextMonth();
                  }
                  // Go to the next month and fetch data
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          feedProvider.isLoading
              ? Shimmer(
                  color: Colors.white,
                  child: Center(
                    child: Container(
                        height: screenHeight / 4,
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
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                        )),
                  ))
              : pageHeaderContainer(
                  context,),
          SizedBox(height: screenHeight * .015),
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
          Consumer<FeedProvider>(builder: (context, feedProvider, child) {
            if (feedProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final feedConsumed = feedProvider
                      .feedConsumeRecord?.feedConsumptionRecordMonthly ??
                  [];
              return Flexible(
                child: ListView.builder(
                  itemCount: feedConsumed.length,
                  itemBuilder: (context, index) {
                    final feed = feedConsumed[index];
                    return GestureDetector(
                      onLongPress: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Choose an action'),
                            actions: <Widget>[
                              // Update action
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog first
                                  //_showUpdateFeedSheet(feed.id); // Call the function with parentheses
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.edit,
                                        color: Colors.blue), // Edit icon
                                    SizedBox(width: 8),
                                    Text('Update',
                                        style: TextStyle(color: Colors.blue)),
                                  ],
                                ),
                              ),
                              // Delete action
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                // onPressed: () async {
                                //   // Call the deleteFeed method from FeedProvider
                                //   await Provider.of<FeedProvider>(context,
                                //           listen: false)
                                //       .deleteFeed(context, feed);

                                //   // Close the dialog after deletion
                                //   Navigator.of(context).pop();
                                // },
                                child: Row(
                                  children: [
                                    Icon(Icons.delete,
                                        color: Colors.red), // Delete icon
                                    SizedBox(width: 8),
                                    Text('Delete',
                                        style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      child: Card(
                        color: Colors.white,
                        elevation: 2.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * .025,
                            horizontal: screenWidth * .025,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: screenHeight * .035,
                                    width: screenHeight * .035,
                                    child: const Image(
                                      image: AssetImage("lib/assets/wanda.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * .015),
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
                      ),
                    );
                  },
                ),
              );
            }
          })
        ],
      ),
    );
  }
}

Widget pageHeaderContainer(
    BuildContext context,) {
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
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<FeedProvider>(builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return CircularProgressIndicator();
                      } else {
                        return Row(
                          children: [
                            wrapCircleContainer(
                                "${provider.feedTotal}", "Total"),
                            SizedBox(
                              width: paragraph / 4,
                            ),
                            Container(
                              width: 1,
                              height: screenWidth / 3.8,
                              color: CupertinoColors.systemGrey6,
                            ),
                            wrapCircleContainer("${provider.feedUsed}", "Used"),
                            SizedBox(
                              width: paragraph / 4,
                            ),
                            Container(
                              width: 1,
                              height: screenWidth / 3.8,
                              color: CupertinoColors.systemGrey6,
                            ),
                            wrapCircleContainer(
                                "${provider.feedAvailable}", "Available"),
                          ],
                        );
                      }
                    }),
                    // FutureBuilder<dynamic>(
                    //   future: fetchFeed(context, month),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return wrapCircleContainer("0", "Total");
                    //     } else if (snapshot.hasError) {
                    //       return wrapCircleContainer("0", "Total");
                    //     } else if (snapshot.hasData && snapshot.data != null) {
                    //       final totalFeed = int.tryParse(snapshot
                    //               .data['feedInventory']['totalAmount']
                    //               .toString()) ??
                    //           0;
                    //       final availableFeed = int.parse(snapshot
                    //           .data['feedInventory']['availableAmount']
                    //           .toString());
                    //       final usedFeed = totalFeed - availableFeed;
                    //       // Display total feed stored
                    //       return Row(
                    //         //crossAxisAlignment: CrossAxisAlignment.center,
                    //         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [

                    //         ],
                    //       );
                    //     }
                    //   },
                    // ),

                    // FutureBuilder<dynamic>(
                    //   future: fetchFeed(context,month),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return wrapCircleContainer("0", "Available");
                    //     } else if (snapshot.hasError) {
                    //       return wrapCircleContainer("0", "Available");
                    //     } else if (snapshot.hasData && snapshot.data != null) {
                    //       return wrapCircleContainer(
                    //           "${snapshot.data['feedInventory']['availableAmount']}",
                    //           "Available");
                    //     } else {
                    //       return const Text('No data available');
                    //     }
                    //   },
                    // ),

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
          height: 5,
        ),
        Text1(fontColor: lightBlackColor, fontSize: paragraph, text: label)
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
