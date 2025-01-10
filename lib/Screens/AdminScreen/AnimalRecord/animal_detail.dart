import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/AnimalDetails/animal_detail_model.dart';
import 'package:dairyfarmflow/Providers/animal_registratin_provider.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AnimalDetail extends StatefulWidget {
  String tag, url, id;
   AnimalDetail({super.key,required this.tag, required this.url, required this.id});

  @override
  State<AnimalDetail> createState() => _AnimalDetailState();
}

class _AnimalDetailState extends State<AnimalDetail> {
  
  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<AnimalRegistratinProvider>(context,listen: false);
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
            padding: const EdgeInsets.only(top: 21),
            child: Center(
              child: Container(
                height: screenHeight / 3,
                width: screenWidth / 1.1,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 159, 156, 156),
                    borderRadius: BorderRadius.circular(10)),
                child:  Image(
                    image: NetworkImage(
                        widget.url),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * .025,
          ),
          ReuseableWidget(
            imgUrl: "lib/assets/cow.png",
            text1: "Animal",
            text2: widget.tag,
          ),
          SizedBox(
            width: screenWidth * .85,
            child: const Divider(),
          ),
          
          Consumer<AnimalRegistratinProvider>(
            builder: (context, animalRegProvider, child) {
              animalRegProvider.getAnimalDetailById(context,widget.id, month)
              if(animalRegProvider.isDataFetched){
                return Center(child: CircularProgressIndicator(color: blackColor,));
              }
              else{
              return Column(
                children: [
                ReuseableWidget(
                imgUrl: "lib/assets/milk.png", text1: "Milk", text2: "${animalRegProvider.milkCount} Liters"),
          
          SizedBox(
            width: screenWidth * .85,
            child: const Divider(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      height: 30,
                      width: 30,
                      child: Image(
                        image: AssetImage("lib/assets/medical.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text1(
                        fontColor: lightBlackColor,
                        fontSize: screenWidth * .05,
                        text: "Vacinated"),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text1(
                        fontColor: lightBlackColor,
                        fontSize: screenWidth * .05,
                        text: "Yes"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: screenWidth * .85,
            child: const Divider(),
          ),
          SizedBox(
            height: screenHeight * .010,
          ),
          Expanded(
              child: FutureBuilder<AnimalDetailModel?>(
                future: provider.getAnimalDetailById(context,widget.id),
                builder: (context, snapshot) {
                   if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('An error occurred: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  final animal = snapshot.data!.milkProductionMonthlyRecord;
                  return ListView.builder(
                    itemCount: animal!.length,
                    itemBuilder: (context, index) {
                      final animalList = animal[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: screenWidth * 0.95,
                          height: screenHeight / 7,
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
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_sharp,
                                    color: darkGreenColor,
                                  ),
                                  SizedBox(
                                    width: screenWidth * .005,
                                  ),
                                  Text1(
                                      fontColor: lightBlackColor,
                                      fontSize: paragraph,
                                      text: animalList.date.toString()),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image(
                                            image:
                                                AssetImage("lib/assets/sun.png")),
                                      ),
                                      SizedBox(
                                        width: screenWidth * .005,
                                      ),
                                      Text1(
                                          fontColor: lightBlackColor,
                                          fontSize: screenWidth * .05,
                                          text: animalList.morning.toString())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image(
                                            image: AssetImage(
                                                "lib/assets/moon.png")),
                                      ),
                                      SizedBox(
                                        width: screenWidth * .005,
                                      ),
                                      Text1(
                                          fontColor: lightBlackColor,
                                          fontSize: screenWidth * .05,
                                          text: animalList.evening.toString())
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });

                }else{
                  return const Center(child: Text("No data"),);
                }
                  
                }
               
              )
              )
                ],
              );
             } } 
            )
        ],
      ),
    );
  }
}

class ReuseableWidget extends StatelessWidget {
  String? text1, text2;
  String? imgUrl;
  ReuseableWidget({
    this.imgUrl,
    required this.text1,
    required this.text2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: Image(
                  image: AssetImage(imgUrl.toString()),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text1(
                  fontColor: lightBlackColor,
                  fontSize: screenWidth * .05,
                  text: text1.toString()),
            ],
          ),
          Row(
            children: [
              Text1(
                  fontColor: lightBlackColor,
                  fontSize: screenWidth * .05,
                  text: text2.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
