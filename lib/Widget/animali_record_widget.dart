import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/get_cow_model.dart';
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

class AnimalRecordWidget extends StatelessWidget {
  const AnimalRecordWidget({
    super.key,
    required this.role,
  });

  final String role;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<AnimalRegistratinProvider>(
        builder: (context, value, child) => 
         FutureBuilder<CowsResponse?>(
          future: value.fetchCows(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error fetching cows data"),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text("No cows data found"),
              );
            } else {
              final cows = snapshot.data!.cows;
              return ListView.builder(
                itemCount: cows.length,
                itemBuilder: (BuildContext context, int index) {
                  final cow = cows[index];
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: role == "Admin"
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
                      child: Container(
                        width: screenWidth * 0.95,
                        height: screenHeight / 3.5,
                        padding: EdgeInsets.all(paragraph),
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
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: screenHeight * .18,
                                  width: screenWidth * .8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      cow.image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                               
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * .025,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.tag_fill,
                                      color: darkGreenColor,
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
                                Row(
                                  children: [
                                    Image.asset(
                                      "lib/assets/cowbreed.png",
                                      width: screenWidth * .055,
                                      height: screenWidth * .055,
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
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons
                                          .money_dollar_circle_fill,
                                      color: darkGreenColor,
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
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}