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
import 'package:simple_toast_message/simple_toast.dart';
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

        feedProvider.fetchFeed(context, DateFormat('EEE MMM dd yyyy').format(_selectedMonth).toLowerCase());
  }

  void _goToNextMonth() {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    });
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    feedProvider.fetchFeedConsumption(
        context, DateFormat('MMM').format(_selectedMonth).toLowerCase());
        feedProvider.fetchFeed(context, DateFormat('EEE MMM dd yyyy').format(_selectedMonth).toLowerCase());
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
          feedProvider.fetchFeed(context, DateFormat('EEE MMM dd yyyy').format(_selectedMonth).toLowerCase());
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

        actions: [
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
  child: GestureDetector(
                onTap: (){

                  _updateFeedSheet(Provider.of<FeedProvider>(context,listen: false).feedTotal.toString());
                },
                child: Icon(Icons.add_circle,size: 30,)
               ),
)
        ],
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
                text: DateFormat("MMMM yyyy").format(_selectedMonth),
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
                child: GridView.builder(
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10, // Spacing between columns
                mainAxisSpacing: 2, // Spacing between rows
                childAspectRatio:
                    screenWidth / (screenHeight / 1.8), ),
                  itemCount: feedConsumed.length,
                  itemBuilder: (context, index) {
                    final feed = feedConsumed[index];
                    return GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Choose an action'),
                            actions: <Widget>[
                              // Update action
                              // TextButton(
                              //   onPressed: () {
                              //     Navigator.of(context)
                              //         .pop(); // Close the dialog first
                              //     _updateFeedSheet(feed!.id.toString()); // Call the function with parentheses
                              //   },
                              //   child: Row(
                              //     children: [
                              //       Icon(Icons.edit,
                              //           color: Colors.blue), // Edit icon
                              //       SizedBox(width: 8),
                              //       Text('Update',
                              //           style: TextStyle(color: Colors.blue)),
                              //     ],
                              //   ),
                              // ),
                              // Delete action
                              TextButton(
                                onPressed: ()async {
                                  await Provider.of<FeedProvider>(context,
                                          listen: false)
                                      .DeleteFeed( feed.id.toString(),context);
                                      final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    await  feedProvider.fetchFeedConsumption(
          context, DateFormat('MMM').format(_selectedMonth).toLowerCase());
      await    feedProvider.fetchFeed(context, DateFormat('MMM yyyy').format(_selectedMonth).toLowerCase());
                                  Navigator.of(context).pop();
                                },
                                // onPressed: () async {
                                //   // Call the deleteFeed method from FeedProvider
                                  

                                  // Close the dialog after deletion
                                  //Navigator.of(context).pop();
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
                        elevation: 2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: screenHeight * .20,
                                width: screenWidth * .58,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      feed.cow!.image.toString(),
                                      fit: BoxFit.fill,
                                    )),
                              ),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      
                                      Text1(
                                        fontColor: lightBlackColor,
                                        fontSize: 12,
                                        text: "${feed.morning} Kg",
                                      ),
                                      Image.asset("lib/assets/sun.png",width: 16,),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      
                                      Text1(
                                        fontColor: lightBlackColor,
                                        fontSize: screenWidth * .05,
                                        text: "${feed.evening} Kg",
                                      ),
                                      Image.asset("lib/assets/moon.png",width: 16),
                                    ],
                                  ),
                                  
                                ],
                              ),
                              Text1(
                                    fontColor: blackColor,
                                    fontSize: screenWidth * .05,
                                    text: "Total : ${feed.total} Kg",
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

  void _updateFeedSheet(String feed) {
  // Controllers to manage input fields
  final TextEditingController feedController = TextEditingController();
 feedController.text=feed;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
      ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Update Total Feed',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
              
                  GestureDetector(
                    onTap: (){

                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel_sharp,size: 30,))
                ],
              ),
              SizedBox(height: 40),
              // Cow ID Field
              TextField(
                controller: feedController,
                //readOnly: true, // Prevent editing Cow ID
                decoration: InputDecoration(
                  labelText: 'Feed',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),
              // Breed Type Field
             GestureDetector(
              onTap: ()async{
                final provider=Provider.of<FeedProvider>(context,listen: false);
                final subtractedAmout=int.parse(feed)-int.parse(feedController.text);
                
              await provider.UpdateInventory(feedAmount: -subtractedAmout,context: context,id: provider.feedId.toString());
              await provider.fetchFeed(context, DateFormat('EEE MMM dd yyyy').format(_selectedMonth).toLowerCase());
               Navigator.pop(context);
                
               
              },
              child: Container(
               height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Update Feed"))),
             )
            ],
          ),
        ),
      );
    },
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
            child: Consumer<FeedProvider>(builder: (context, provider, child) {
              if (provider.isLoading) {
                return CircularProgressIndicator();
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
