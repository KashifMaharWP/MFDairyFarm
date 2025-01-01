// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dairyfarmflow/Model/soldmilk.dart';
import 'package:dairyfarmflow/ReuseableWidgets/reuse_row.dart';
import 'package:dairyfarmflow/ReuseableWidgets/row_withtext_andimage.dart';
import 'package:flutter/material.dart';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:provider/provider.dart';

import '../../../Providers/FeedProviders/feed_provider.dart';
import '../../../Providers/MilkProviders/milk_record.dart';

class DailyRecordScreen extends StatefulWidget {
  const DailyRecordScreen({super.key});

  @override
  State<DailyRecordScreen> createState() => _DailyRecordScreenState();
}

class _DailyRecordScreenState extends State<DailyRecordScreen> {
  String Date='Dec';
  @override
  void initState() {
   
    super.initState();
     Future.microtask(() =>
        Provider.of<MilkRecordProvider>(context, listen: false).fetchMilkCount(context));
       

      
        
  }
  @override
  Widget build(BuildContext context) {
     final milkProvider = Provider.of<MilkRecordProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: darkGreenColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: const Text("Daily Record"),
      ),
      body: Column(
        children: [
          pageHeaderContainer(),
          SizedBox(
            height: screenHeight * .023,
          ),
          Expanded(
  child: FutureBuilder<SoldMilkModel?>(
    future: milkProvider.fetchMilkSold(context),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('An error occurred: ${snapshot.error}'));
      } else if (snapshot.hasData && snapshot.data != null) {
        final soldMilkData = snapshot.data!.monthlyMilkRecord ?? [];
        return ListView.builder(
          itemCount: soldMilkData.length,
          itemBuilder: (context, index) {
            final record = soldMilkData[index];
            return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text1(
                                fontColor: blackColor,
                                fontSize: screenWidth * .055,
                                text: "${record.vendorName}"),
                            Text1(
                                fontColor: blackColor,
                                fontSize: screenWidth * .055,
                                text: "${record.amountSold}ltr")
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * .023,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RowWithTextAndImage(
                                text1: "Morning", imgUrl: "lib/assets/sun.png"),
                            RowWithTextAndImage(
                              imgUrl: "lib/assets/moon.png",
                              text1: "Evening",
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
          },
        );
      } else {
        return Center(child: Text('No data available'));
      }
    },
  ),
)

        ],
      ),
    );
  }
}

Widget pageHeaderContainer() {
  
  return Material(
      elevation: 6,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      child: Container(
          height: screenHeight / 2.2,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: greyGreenColor,
                    blurRadius: 6,
                    offset: const Offset(2, 2))
              ]),
          child: Padding(
            padding: EdgeInsets.only(
                top: screenHeight * .02,
                left: screenWidth * .02,
                right: screenWidth * .02),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * .02,
                ),

                //here is the code for the custom gridview boxes

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * .045),
                      child: Row(
                        children: [
                          Image(
                            image: const AssetImage("lib/assets/milk.png"),
                            width: screenHeight * .040,
                            height: screenHeight * .040,
                          ),
                          SizedBox(
                            width: screenWidth * .015,
                          ),
                          Text1(
                              fontColor: blackColor,
                              fontSize: screenWidth * .055,
                              text: "Milk Record"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .02,
                    ),
                    Consumer<MilkRecordProvider>(
                      builder: (context, milk, child) => 
                       ReuseRow(
                        text1: milk.morningMilk,
                        text2: "Morning",
                        text3: milk.eveningMilk,
                        text4: "Evening",
                        text5: milk.total,
                        text6: "Total",
                        img1: "lib/assets/sun.png",
                        img2: "lib/assets/moon.png",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                      child: Divider(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * .045),
                      child: Row(
                        children: [
                          Image(
                            image: const AssetImage("lib/assets/wanda.png"),
                            width: screenHeight * .040,
                            height: screenHeight * .040,
                          ),
                          SizedBox(
                            width: screenWidth * .015,
                          ),
                          Text1(
                              fontColor: blackColor,
                              fontSize: screenWidth * .055,
                              text: "Feed Record"),
                        ],
                      ),
                    ),
                    ReuseRow(
                      text1: "100",
                      text2: "Available",
                      text3: "66",
                      text4: "Used",
                      text5: "166",
                      text6: "Total",
                    ),
                  ],
                ),
              ],
            ),
          )));
}

// Widget wrapCircleContainer(String text, label) {
//   return
// }
class WrapCircleContainer extends StatelessWidget {
  String text, label;
  String? optional;

  WrapCircleContainer({
    required this.text,
    required this.label,
    this.optional,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: paragraph / 2, horizontal: paragraph / 12),
      padding: EdgeInsets.symmetric(horizontal: paragraph),
      child: Column(
        children: [
          circleContainer(text),
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              optional == null
                  ? const Center()
                  : Image(
                      image: AssetImage(optional.toString()),
                      width: screenHeight * .025,
                      height: screenHeight * .025,
                    ),
              Text1(
                  fontColor: lightBlackColor, fontSize: paragraph, text: label),
            ],
          )
        ],
      ),
    );
  }
}

Widget circleContainer(String text) {
  return Container(
    width: screenWidth / 7,
    height: screenWidth / 7,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(screenWidth / 4),
      boxShadow: [
        BoxShadow(
            color: greyGreenColor,
            offset: const Offset(2, 2),
            blurRadius: 2,
            spreadRadius: 2)
      ],
    ),
    child: Center(
        child: Text1(fontColor: blackColor, fontSize: paragraph, text: text)),
  );
}




