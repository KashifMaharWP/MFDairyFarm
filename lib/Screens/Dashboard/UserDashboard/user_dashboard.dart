import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/worker_provider.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/DailyRecord/daily_record_screen.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/FeedEntry/feedEntryPage.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/MilkRecordScreen/SaleMilk/add_salemilk.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/MilkRecordScreen/milk_record.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/VacinationScreen/animal_list.dart';
import 'package:dairyfarmflow/Screens/Dashboard/adminDashboard/adminDashboard.dart';
import 'package:dairyfarmflow/Screens/Dashboard/adminDashboard/profile_view.dart';
import 'package:dairyfarmflow/Screens/Dashboard/workerDashboard/workerDashboard.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:dairyfarmflow/Widget/my_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Notifications/notification_screen.dart';
import '../../../Providers/MilkProviders/milk_record.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int? iconIndex = 0;
  String role = "1";

  final List<Widget> _navigationItems = [
    const Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.notifications_on_rounded,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.person_2_outlined,
      size: 30,
      color: Colors.white,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<WorkerProvider>(context, listen: false)
          .fetchAllTasks(context);
    });
  }

  @override
  void dispose() {
    // Cancel any ongoing tasks or subscriptions here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        drawer: const MyDrawer(),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey.shade100,
        body: iconIndex == 0
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxHeight: constraints.maxHeight),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: darkGreenColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            height: screenHeight / 3.5,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * .045,
                                  right: screenWidth * .045,
                                  top: screenHeight * .025),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        child: const CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "lib/assets/farmWorker.png"),
                                          radius: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * .02,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: screenWidth * .02,
                                            right: screenWidth * .02,
                                            top: screenHeight * .035),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text1(
                                                fontColor: whiteColor,
                                                fontSize: 25,
                                                text: "Welcome"),
                                            Consumer<UserDetail>(
                                              builder: (context, value,
                                                      child) =>
                                                  Text1(
                                                      fontColor: whiteColor,
                                                      fontSize:
                                                          screenWidth * .05,
                                                      text: "${value.name}"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pageBodyContainer(),
                          SizedBox(
                            height: screenHeight * .01,
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.only(left: 8, right: 8),
                          //   child: wrapContainer(),
                          // ),

                          //  pageHeaderContainer(),
                        ],
                      ),
                    ),
                  );
                },
              )
            : iconIndex == 1
                ? const NotificationScreen()
                : const ProfileView(),
        bottomNavigationBar: CurvedNavigationBar(
          items: _navigationItems,
          backgroundColor: Colors.grey.shade100,
          color: darkGreenColor,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (value) {
            iconIndex = value;
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget gridButtons() {
    return role == "1"
        ? const AdminDashboardButtons()
        : const WorkerDashboardButtons();
  }

  Widget pageHeaderContainer() {
    return Padding(
      padding:
          EdgeInsets.only(right: screenWidth * .015, left: screenWidth * .015),
      child: Material(
          elevation: 6,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40)),
          child: Container(
              height: screenHeight / 4,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
                      height: screenHeight / 40,
                    ),
                    //here is the code for the custom gridview boxes
                    gridButtons()
                    // Text("data")
                  ],
                ),
              ))),
    );
  }

  Widget pageBodyContainer() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(paragraph),
        child: Column(
          children: [
            // Container(
            //   padding: const EdgeInsets.only(left: 10),
            //   child: Align(
            //     alignment: Alignment.bottomLeft,
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.calendar_month_sharp,
            //           color: darkGreenColor,
            //         ),
            //         Text1(
            //             fontColor: lightBlackColor,
            //             fontSize: screenWidth * .06,
            //             text: DateFormat("MMMM yyyy").format(DateTime.now())),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: screenHeight * .001,
            // ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(paragraph),
                  boxShadow: [
                    BoxShadow(
                        color: greyGreenColor,
                        blurRadius: 8,
                        offset: const Offset(2, 2))
                  ]),
            ),
            SizedBox(
              height: header1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Column(
                //   children: [
                //     viewContainer(
                //         "Animal", "lib/assets/cow.png", const AnimalRecord()),
                //     SizedBox(
                //       height: paragraph,
                //     ),
                //     viewContainer("Daily Record", "lib/assets/dairyfarm.png",
                //         const DailyRecordScreen()),
                //   ],
                // ),
                viewContainer(
                    "Medical", "lib/assets/medical.png", const AnimalList()),
                SizedBox(
                  height: paragraph,
                ),
                viewContainer("Milk(ltr)", "lib/assets/milk.png",
                    const MilkRecordScreen()),
                SizedBox(
                  height: paragraph,
                ),

                viewContainer("Milk Sale", "lib/assets/milkSale.png",
                    const AddMilkSale()),

                viewContainer("Feed", "lib/assets/feed.png", feedEntryPage()),

                viewContainer("Daily Record", "lib/assets/dairyfarm.png",
                        const DailyRecordScreen()),
              ],
            ),
            SizedBox(
              height: screenHeight * .033,
            ),
            // viewContainer(
            //     "Add Milk", "lib/assets/addMilk.jpg", const AnimalRecord()),
            const Text(
              "Daily Milk Sold Record",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: screenHeight / 1.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Consumer<MilkRecordProvider>(
                    builder: (context, milkProvider, child) {
                  return FutureBuilder(
                    future: milkProvider.fetchMilkSoldByDate(
                      context,
                      DateFormat('EEE MMM dd yyyy').format(DateTime.now()),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No Data Available for Selected Date'));
                      } else if (snapshot.hasData) {
                        // Display the list of milk sold records
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final record = snapshot.data?[index];

                            return Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        record?.vendor?.name ?? "Unknown",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),

                                  // Amount Sold
                                  Row(
                                    children: [
                                      Text(
                                        "${record?.amountSold} ltr",
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
                            );
                            // Container(
                            //   margin: EdgeInsets.symmetric(
                            //       vertical: 5, horizontal: 10),
                            //   //padding: EdgeInsets.all(10),
                            //   decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(10),
                            //       boxShadow: [
                            //         BoxShadow(
                            //           color: Colors.grey.withOpacity(0.5),
                            //           spreadRadius: 5,
                            //           blurRadius: 7,
                            //           offset: Offset(0, 3),
                            //         )
                            //       ]),
                            //   child: ListTile(
                            //     leading: CircleAvatar(
                            //       radius: 20,
                            //       backgroundColor: Colors.greenAccent,
                            //       child: Icon(
                            //         Icons.task,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     title: Text1(
                            //       fontColor: blackColor,
                            //       fontSize: header1,
                            //       text: usertask.description.toString(),
                            //     ),
                            //     // subtitle:Icon(usertask.taskStatus.toString()=='true'?Icons.check:Icons.close) ,
                            //     // // Text1(
                            //     // //   fontColor: lightBlackColor,
                            //     // //   fontSize: header5,
                            //     // //   text: usertask.taskStatus.toString(),
                            //     // // ),
                            //     onTap: () {
                            //       showDialog(
                            //         context: context,
                            //         builder: (context) => AlertDialog(
                            //           title: Text('Task Description'),
                            //           content: Text(usertask.description ??
                            //               'No Description Available'),
                            //           actions: [
                            //             TextButton(
                            //               onPressed: () => Navigator.pop(context),
                            //               child: Text('Close'),
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // );
                          },
                        );
                      } else {
                        return const Center(child: Text('No data available'));
                      }
                    },
                  );
                }))
          ],
        ),
      ),
    );
  }

  //Wrap Circle Container and Label
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

  //Circle Container
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

  //ViewContainer
  Widget viewContainer(String text, iconPath, Widget widget) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(paragraph),
            width: screenWidth / 4.5,
            height: screenWidth / 4.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(paragraph),
                boxShadow: [
                  BoxShadow(
                      color: greyGreenColor,
                      offset: const Offset(2, 2),
                      blurRadius: 6),
                ]),
            child: Center(
                child: Image(
              image: AssetImage(iconPath),
              width: screenWidth / 5,
            )),
          ),
          Text1(fontColor: lightBlackColor, fontSize: paragraph , text: text)
        ],
      ),
    );
  }
}

Widget wrapContainer() {
  return Container(
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
    margin: EdgeInsets.only(top: screenHeight / 94),
    height: screenHeight / 3.6,
    width: screenWidth,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              wrapCircleContainer("25", "Animal"),
              SizedBox(
                height: paragraph / 4,
              ),
              Container(
                height: 1,
                width: screenWidth / 3.8,
                color: CupertinoColors.systemGrey6,
              ),
              SizedBox(
                height: paragraph / 2,
              ),
              wrapCircleContainer("5", "Baby"),
            ],
          ),
          Container(
            height: screenHeight / 4,
            width: 1,
            color: CupertinoColors.systemGrey6,
          ),
          Column(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              wrapCircleContainer("200", "Wanda"),
              SizedBox(
                height: paragraph / 4,
              ),
              Container(
                height: 1,
                width: screenWidth / 3.2,
                color: CupertinoColors.systemGrey6,
              ),
              SizedBox(
                height: paragraph / 2,
              ),
              wrapCircleContainer("12", "Vacinated"),
            ],
          ),
          Container(
            height: screenHeight / 4,
            width: 1,
            color: CupertinoColors.systemGrey6,
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              wrapCircleContainer("5", "Pregnent"),
              SizedBox(
                height: paragraph / 4,
              ),
              Container(
                height: 1,
                width: screenWidth / 3.4,
                color: CupertinoColors.systemGrey6,
              ),
              SizedBox(
                height: paragraph / 2,
              ),
              wrapCircleContainer("3", "Sell"),
            ],
          ),
        ],
      ),
    ),
  );
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
    width: screenWidth / 8,
    height: screenWidth / 8,
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
