import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Model/Medical/details_model.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/Medical/add_medical.dart';

class MedicalDetail extends StatefulWidget {
  String id;
  String url;
  String tag;
   MedicalDetail({super.key, required this.id, required this.url, required this.tag});

  @override
  State<MedicalDetail> createState() => _MedicalDetailState();
}

class _MedicalDetailState extends State<MedicalDetail> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<AddMedical>(context,listen: false).fetchMedicalDetails(context, widget.id);
    });
  }

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
        title: const Text("Medical Detail"),
      ),
      body: Column(
        children: [
          Image(
              image: NetworkImage(
                 widget.url),
              fit: BoxFit.contain),
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
          ReuseableWidget(
            imgUrl: "lib/assets/cow.png",
            text1: "Animal",
            text2: widget.tag,
          ),
          SizedBox(
            height: screenHeight * .010,
          ),
          Expanded(
              child: Consumer<AddMedical>(
                
                builder: (context,medicalProvider, child){
                  if (medicalProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } 
                 else{
                  final medical =medicalProvider.singleMedicalDetail?.cowMedicalRecord??[];
                   return  ListView.builder(
                    itemCount: medical.length,
                    itemBuilder: (context, index) {
                      final record = medical[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: screenWidth * 0.95,
                          height: screenHeight / 6,
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
                                      text: record.date.toString()),
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
                                        child:  Image(
                                            image: AssetImage(
                                                "lib/assets/medical.png")),
                                      ),
                                      SizedBox(
                                        width: screenWidth * .005,
                                      ),
                                      Text1(
                                          fontColor: lightBlackColor,
                                          fontSize: screenWidth * .05,
                                          text: record.vaccineType.toString())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                     const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child:  Image(
                                            image: AssetImage(
                                                "lib/assets/Check.png")),
                                      ),
                                      SizedBox(
                                        width: screenWidth * .005,
                                      ),
                                      Text1(
                                          fontColor: lightBlackColor,
                                          fontSize: screenWidth * .05,
                                          text: "Yes")
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
                 }
                }
                
              ))
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
