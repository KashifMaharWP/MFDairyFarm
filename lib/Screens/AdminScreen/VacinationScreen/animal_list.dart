import 'dart:convert';

import 'package:dairyfarmflow/Screens/AdminScreen/VacinationScreen/add_madicine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../API/global_api.dart';
import '../../../Class/colorPallete.dart';
import '../../../Class/screenMediaQuery.dart';
import '../../../Class/textSizing.dart';
import '../../../Model/get_cow_model.dart';
import '../../../Providers/user_detail.dart';
import '../../../Widget/Text1.dart';
import '../../../Widget/custom_filter_widget.dart';

class AnimalList extends StatefulWidget {
  const AnimalList({super.key});

  @override
  State<AnimalList> createState() => _AnimalListState();
}

class _AnimalListState extends State<AnimalList> {
  @override
  String role = '';

  @override
  Widget build(BuildContext context) {
   // role = Provider.of<UserDetail>(context).role.toString();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title:  const Text("Add Medical"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * .015,
          ),
          role == "Admin"
              ? Container(
                  width: screenWidth * 0.95,
                  height: screenHeight * .07,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(child: customFiltersWidget()),
                )
              : const Center(),
          SizedBox(
            height: screenHeight * .015,
          ),
          CowsList(),
        ],
      ),
    );
  }
}

class CowsList extends StatelessWidget {
  const CowsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<CowsResponse?>(
        future: fetchCows(context),
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
                    onTap: 
                         () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddMedicine(id: cow.id),
                              ),
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
    );
  }
}

Future<CowsResponse?> fetchCows(BuildContext context) async {
  var headers = {
    'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
  };
  var request = http.Request(
    'GET',
    Uri.parse('${GlobalApi.baseApi}${GlobalApi.getAnimal}'),
  );

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final jsonString = await response.stream.bytesToString();
    final jsonData = json.decode(jsonString);
    return CowsResponse.fromJson(jsonData);
  } else {
    if (kDebugMode) {
      print("Error: ${response.reasonPhrase}");
    }
    return null;
  }
}
