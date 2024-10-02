import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimalDetail extends StatefulWidget {
  const AnimalDetail({super.key});

  @override
  State<AnimalDetail> createState() => _AnimalDetailState();
}

class _AnimalDetailState extends State<AnimalDetail> {
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
        title: const Text("Animal Detail"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Container(
                height: screenHeight / 3,
                width: screenWidth / 1.1,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 159, 156, 156),
                    borderRadius: BorderRadius.circular(10)),
                child: const Image(
                    image: NetworkImage(
                        "https://static.vecteezy.com/system/resources/thumbnails/023/651/804/small/dairy-cow-on-transparent-background-created-with-generative-ai-png.png"),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * .025,
          ),
          ReuseableWidget(
            text1: "Animal",
            text2: "Tag",
          ),
          ReuseableWidget(text1: "Milk", text2: "Liters")
        ],
      ),
    );
  }
}

class ReuseableWidget extends StatelessWidget {
  String? text1, text2;
  ReuseableWidget({
    required this.text1,
    required this.text2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text1(
            fontColor: lightBlackColor,
            fontSize: screenWidth * .05,
            text: text1.toString()),
        Text1(
            fontColor: lightBlackColor,
            fontSize: screenWidth * .05,
            text: text2.toString()),
      ],
    );
  }
}
