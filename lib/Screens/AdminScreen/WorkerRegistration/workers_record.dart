import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkersRecord extends StatefulWidget {
  const WorkersRecord({super.key});

  @override
  State<WorkersRecord> createState() => _WorkersRecordState();
}

class _WorkersRecordState extends State<WorkersRecord> {
  @override
  Widget build(BuildContext context) {
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
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: screenWidth * 0.95,
                      height: screenHeight / 5,
                      padding: EdgeInsets.all(paragraph),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text1(
                                  fontColor: lightBlackColor,
                                  fontSize: screenWidth * .05,
                                  text: "Worker Name"),
                              Text1(
                                  fontColor: lightBlackColor,
                                  fontSize: screenWidth * .05,
                                  text: "Sallary"),
                            ],
                          )
                        ],
                      )),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
