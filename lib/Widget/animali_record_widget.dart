import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/get_cow_model.dart';
import 'package:dairyfarmflow/Providers/CowProvider/cows_provider.dart';
import 'package:dairyfarmflow/Providers/animal_registratin_provider.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/colorPallete.dart';
import '../Class/screenMediaQuery.dart';

import '../Screens/AdminScreen/AnimalRecord/animal_detail.dart';
import '../Screens/AdminScreen/MilkRecordScreen/add_evening_milk.dart';
import '../Screens/AdminScreen/MilkRecordScreen/add_morning_milk.dart';

class AnimalRecordWidget extends StatefulWidget {
  const AnimalRecordWidget({
    super.key,
    required this.role,
  });

  final String role;

  @override
  State<AnimalRecordWidget> createState() => _AnimalRecordWidgetState();
}


class _AnimalRecordWidgetState extends State<AnimalRecordWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<CowsProvider>(context,listen: false).fetchCows(context);
  });
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<CowsProvider>(
        builder: (context, cowsProvider, child){
  
            if (cowsProvider.isCowListLoad) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }  else {
              final cows = cowsProvider.cowList?.cows??[];
              return GridView.builder(
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 10, // Spacing between columns
                  mainAxisSpacing: 2, // Spacing between rows
                  childAspectRatio:
                      screenWidth / (screenHeight / 1.8), // Adjust as needed
                ),
                itemCount: cows.length,
                itemBuilder: (BuildContext context, int index) {
                  final cow = cows[index];
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: widget.role == "Admin"
                          ? () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>  AnimalDetail(tag: cow.animalNumber.toString(), url: cow.image, id: cow.id,)));
                            }
                          : () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddMorningMilk(
                                                          id: cow.id,
                                                        )));
                                          },
                                          leading: Image(
                                            image: const AssetImage(
                                                "lib/assets/sun.png"),
                                            width: screenWidth * .075,
                                            height: screenWidth * .075,
                                          ),
                                          title: const Text("Morning"),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddEveningMilk(
                                                            id: cow.id)));
                                          },
                                          leading: Image(
                                            image: const AssetImage(
                                                "lib/assets/moon.png"),
                                            width: screenWidth * .075,
                                            height: screenWidth * .075,
                                          ),
                                          title: const Text("Evening"),
                                        )
                                      
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                      child: Expanded(
                      child: Container(
                        width: screenWidth + 10,
                        height: screenHeight + 10,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(paragraph),
                          boxShadow: [
                            BoxShadow(
                              color: greyGreenColor,
                              blurRadius: 6,
                              spreadRadius: 3,
                              offset: const Offset(2, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: screenHeight * .20,
                                    width: screenWidth * .58,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          cow.image,
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                // role == "Admin"
                                //     ? InkWell(
                                //         onTap: () {
                                //           Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       feedEntryPage(
                                //                         id: cow.id,
                                //                       )));
                                //         },
                                //         child: Icon(
                                //           Icons.more_vert,
                                //           color: darkGreenColor,
                                //           size: screenWidth * .070,
                                //         ),
                                //       )
                                //     : const Center(),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      CupertinoIcons.tag_fill,
                                      color: darkGreenColor,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: screenWidth * .007,
                                    ),
                                    Text1(
                                      fontColor: lightBlackColor,
                                      fontSize: screenWidth * .04,
                                      text: "Animal ${cow.animalNumber}",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "lib/assets/cowbreed.png",
                                      width: screenWidth * .060,
                                      height: screenWidth * .060,
                                    ),
                                    SizedBox(
                                      width: screenWidth * .007,
                                    ),
                                    Text1(
                                      fontColor: lightBlackColor,
                                      fontSize: screenWidth * .04,
                                      text: cow.breed,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.money_dollar_circle_fill,
                                      color: darkGreenColor,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: screenWidth * .007,
                                    ),
                                    Text1(
                                      fontColor: lightBlackColor,
                                      fontSize: screenWidth * .04,
                                      text: cow.age
                                          .toString(), // Update as needed
                                    ),
                                  ],
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
            }
          },
        
      ),
    );
  }
}