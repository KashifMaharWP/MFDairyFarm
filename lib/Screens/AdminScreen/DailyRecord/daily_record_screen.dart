// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dairyfarmflow/Model/soldmilk.dart';
import 'package:dairyfarmflow/Providers/FeedProviders/feed_provider.dart';
import 'package:dairyfarmflow/ReuseableWidgets/reuse_row.dart';
import 'package:dairyfarmflow/ReuseableWidgets/row_withtext_andimage.dart';
import 'package:flutter/material.dart';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Providers/MilkProviders/milk_record.dart';
import '../../../Widget/customRoundButton.dart';
import '../../../Widget/textFieldWidget1.dart';
import '../MilkRecordScreen/milk_record.dart';

class DailyRecordScreen extends StatefulWidget {
  const DailyRecordScreen({super.key});

  @override
  State<DailyRecordScreen> createState() => _DailyRecordScreenState();
}

class _DailyRecordScreenState extends State<DailyRecordScreen> {
  final TextEditingController vendorName = TextEditingController();
  final TextEditingController amountSold = TextEditingController();
  final TextEditingController datePicker = TextEditingController();
  final TextEditingController totalPayment = TextEditingController();
  String Date = 'Dec';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){

        Provider.of<MilkRecordProvider>(context, listen: false)
            .fetchMilkCount(context);
    Provider.of<FeedProvider>(context, listen: false).fetchFeedCount(context,"Wed Jan 22 2025");
    //Provider.of<FeedProvider>(context, listen: false).fetchFeed(context, "Jan 2025");
    });
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
              future: milkProvider.fetchMilkSold(context,DateFormat('MMM yyyy').format(DateTime.now())),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.monthlyMilkRecord!.isEmpty) {
                  return Center(
                      child: Text('No Data Available'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  final soldMilkData = snapshot.data!.monthlyMilkRecord ?? [];
                  return ListView.builder(
                    itemCount: soldMilkData.length,
                    itemBuilder: (context, index) {
                      final record = soldMilkData[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Slidable(
                          startActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    vendorName.text =
                                        record.vendorName.toString();
                                    amountSold.text =
                                        record.amountSold.toString();
                                    totalPayment.text =
                                        record.totalPayment.toString();
                                    datePicker.text = record.date.toString();

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: AlertDialog(
                                            title: Center(
                                              child: Text1(
                                                  fontColor: blackColor,
                                                  fontSize: header5,
                                                  text: "Update"),
                                            ),
                                            content: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                customTextFormField(
                                                  "Vendor Name",
                                                ),
                                                TextFieldWidget1(
                                                    keyboardtype:
                                                        TextInputType.number,
                                                    widgetcontroller:
                                                        vendorName,
                                                    fieldName: "Vendor Name",
                                                    isPasswordField: false),
                                                SizedBox(
                                                  height: screenHeight * .025,
                                                ),
                                                customTextFormField(
                                                  "Milk Ltr",
                                                ),
                                                TextFieldWidget1(
                                                    keyboardtype:
                                                        TextInputType.number,
                                                    widgetcontroller:
                                                        amountSold,
                                                    fieldName: "Milk Ltr",
                                                    isPasswordField: false),
                                                SizedBox(
                                                  height: screenHeight * .025,
                                                ),
                                                customTextFormField(
                                                  "Total Payment",
                                                ),
                                                TextFieldWidget1(
                                                    widgetcontroller:
                                                        totalPayment,
                                                    fieldName: "Total Payment",
                                                    isPasswordField: false),
                                                SizedBox(
                                                  height: screenHeight * .025,
                                                ),
                                                customTextFormField(
                                                  "Date",
                                                ),
                                                TextFieldWidget1(
                                                    widgetcontroller:
                                                        datePicker,
                                                    fieldName: "Date",
                                                    isPasswordField: false),
                                                SizedBox(
                                                  height: screenHeight * .025,
                                                ),
                                                Center(
                                                  child: customRoundedButton(
                                                      loading: false,
                                                      title: "Update",
                                                      on_Tap: () async {
                                                        print(record.sId);
                                                        await Provider.of<MilkRecordProvider>(
                                                                context,
                                                                listen: false)
                                                            .upadetMilkSold(
                                                                id: record.sId
                                                                    .toString(),
                                                                vendorName:
                                                                    vendorName
                                                                        .text,
                                                                datePicker:
                                                                    datePicker
                                                                        .text,
                                                                amountSold:
                                                                    int.parse(
                                                                        amountSold
                                                                            .text),
                                                                totalPayment:
                                                                    int.parse(
                                                                        totalPayment
                                                                            .text),
                                                                context:
                                                                    context);
                                                        Navigator.pop(context);
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  backgroundColor: Colors.blue,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                              ]),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  // await Provider.of<MilkRecordProvider>(context,
                                  //         listen: false)
                                  //     .deleteMilkSold(
                                  //         id: record.sId.toString(),
                                  //         context: context);
                                  //deleteRecord(cow.id);
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Delete',
                              )
                            ],
                          ),
                          child: Container(
                            width: double.infinity,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RowWithTextAndImage(
                                        text1: "Morning",
                                        imgUrl: "lib/assets/sun.png"),
                                    RowWithTextAndImage(
                                      imgUrl: "lib/assets/moon.png",
                                      text1: "Evening",
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } 
                else{
                  return const Center(child: Text('No data available',style: TextStyle(
                    fontSize: 16,
                  ),));
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
                      builder: (context, milk, child) => ReuseRow(
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
                    Consumer<FeedProvider>(
                      builder: (context, value, child) => ReuseRow(
                        text1: value.usedFeed.toString(),
                        text2: "Total Used",
                        text3: value.morningFeed.toString(),
                        text4: "Morning",
                        text5: value.eveningFeed.toString(),
                        text6: "Evening",
                      ),
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
