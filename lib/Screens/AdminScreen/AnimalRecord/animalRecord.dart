import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimalRecord extends StatefulWidget {
  const AnimalRecord({super.key});

  @override
  State<AnimalRecord> createState() => _AnimalRecordState();
}

class _AnimalRecordState extends State<AnimalRecord> {
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
        title: const Text("Register Animals"),
      ),
      body: Container(
        child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: screenWidth*0.95,
          height: screenHeight/6,
          padding: EdgeInsets.all(paragraph),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(paragraph),
            boxShadow: [
              BoxShadow(
                color: greyGreenColor,
                blurRadius: 6,
                spreadRadius: 3,
                offset: Offset(2, 0)
              ),
            ]
          ),
          child: Row(
            children: [

            ],
          ),
        ),
      );
    }
        ),
      ),
    );
  }

  //Wrap Text Container

}
