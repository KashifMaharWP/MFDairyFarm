import 'dart:convert';
import 'package:dairyfarmflow/API/global_api.dart';
import 'package:dairyfarmflow/Functions/customDatePicker.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/WorkerRegistration/add_worker_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/workers.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Widget/textFieldWidget1.dart';

class WorkersRecord extends StatefulWidget {
  const WorkersRecord({super.key});

  @override
  State<WorkersRecord> createState() => _WorkersRecordState();
}

class _WorkersRecordState extends State<WorkersRecord> {
  DateTime? pickedDate;
  TextEditingController workerName = TextEditingController();
  TextEditingController datepiker = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  DateTime selectedDate = DateTime.now();
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddWorkerTask(
                                                id: worker.id,
                                                name: worker.name,
                                              )));
                                },
                                
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
                                                text: worker.email),
                                                Text1(
                                                fontColor: lightBlackColor,
                                                fontSize: screenWidth * .05,
                                                text: worker.password),
                                                
                                          ],
                                        )
                                      ],
                                    )),
                              ),
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

  
void _showUpdateCowSheet(String UserName, Password) {

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Worker Detail',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Cow ID Field

             Row(
               children: [
                 Text(
                  'User Name:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                             ),
                 Text(
                  UserName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                             ),
               ],
             ),

             Row(
               children: [
                 Text(
                  'Password:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                             ),
                 Text(
                  Password,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                             ),
               ],
             ),
           
          ],
        ),
      );
    },
  );
}

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Assign Task'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                customForm(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add Task'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget customForm() {
    return Padding(
      padding: EdgeInsets.all(paragraph / 6),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFormField("Worker Name", CupertinoIcons.person),
            TextFieldWidget1(
              isReadOnly: true,
              widgetcontroller: workerName,
              fieldName: "Worker Name",
              isPasswordField: false,
            ),
            SizedBox(height: paragraph),
            customTextFormField("Date", CupertinoIcons.calendar),
            dateContainer(),
            SizedBox(height: paragraph),
            customTextFormField("Task", CupertinoIcons.info_circle),
            TextFieldWidget1(
              // keyboardtype: TextInputType.number,
              widgetcontroller: taskDescription,
              fieldName: "Task Description",
              isPasswordField: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextFormField(String text, IconData customIcon) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Icon(customIcon, color: darkGreenColor),
        Text1(fontColor: blackColor, fontSize: paragraph, text: text),
      ],
    );
  }

  Widget dateContainer() {
    return InkWell(
      onTap: () async {
        pickedDate = await customDatePicker(context, selectedDate);
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate as DateTime;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(paragraph - 7),
        width: screenWidth,
        height: screenHeight / 14,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            border: Border.all(color: CupertinoColors.systemGrey, width: 1),
            borderRadius: BorderRadius.circular(paragraph - 10),
            boxShadow: const [
              BoxShadow(
                  color: CupertinoColors.systemGrey3,
                  offset: Offset(0, 2),
                  blurRadius: 8)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text1(
                fontColor: blackColor,
                fontSize: paragraph - 3,
                text: DateFormat("EEE MMM dd yyyy").format(selectedDate)),
            Icon(
              CupertinoIcons.calendar,
              color: darkGreenColor,
            )
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
