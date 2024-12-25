import 'dart:convert';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:http/http.dart' as http;
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/workers.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkersRecord extends StatefulWidget {
  const WorkersRecord({super.key});

  @override
  State<WorkersRecord> createState() => _WorkersRecordState();
}

class _WorkersRecordState extends State<WorkersRecord> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<UserDetail>(context, listen: false).token;
    print(token);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: const Text("Worker's Record"),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: screenHeight * .024,
            left: screenWidth * .010,
            right: screenWidth * .010),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: fetchWorkers(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No workers found"));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final worker = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: screenWidth * 0.95,
                                  height: screenHeight / 5,
                                  padding: EdgeInsets.all(paragraph),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(paragraph),
                                      boxShadow: [
                                        BoxShadow(
                                            color: greyGreenColor,
                                            blurRadius: 6,
                                            spreadRadius: 3,
                                            offset: const Offset(2, 0)),
                                      ]),
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 55,
                                        backgroundImage: NetworkImage(
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaXFahyLr8mW7OKfJ6YNcSbdpdz6erNOe-uQ&s"),
                                      ),
                                      SizedBox(
                                        width: screenWidth * .05,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text1(
                                              fontColor: blackColor,
                                              fontSize: screenWidth * .055,
                                              text: worker.name),
                                          Text1(
                                              fontColor: lightBlackColor,
                                              fontSize: screenWidth * .05,
                                              text: worker.registrationDate),
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          },
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

Future<List<Worker>> fetchWorkers(BuildContext context) async {
  var headers = {
    'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
  };
  final url = '${GlobalApi.baseApi}user/getMyWorkers';

  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);

    // Check if the response contains the "workers" list
    if (data['workers'] != null) {
      List<dynamic> workersJson = data['workers'];
      return workersJson.map((worker) => Worker.fromJson(worker)).toList();
    } else {
      throw Exception("Workers data not found in response.");
    }
  } else {
    throw Exception("Failed to load workers.");
  }
}
