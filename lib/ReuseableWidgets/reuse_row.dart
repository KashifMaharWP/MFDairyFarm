import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/DailyRecord/daily_record_screen.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class ReuseRow extends StatelessWidget {
  String text1, text2, text3, text4, text5, text6;
  String? img1, img2, img3;
  ReuseRow(
      {super.key,
      this.img1,
      this.img2,
      this.img3,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4,
      required this.text5,
      required this.text6});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WrapCircleContainer(
          text: text1,
          label: text2,
          optional: img1,
        ),
        SizedBox(
          height: paragraph / 4,
        ),
        Container(
          width: 1,
          height: screenWidth / 3.8,
          color: CupertinoColors.systemGrey6,
        ),
        WrapCircleContainer(
          text: text3,
          label: text4,
          optional: img2,
        ),
        SizedBox(
          height: paragraph / 4,
        ),
        Container(
          width: 1,
          height: screenWidth / 3.8,
          color: CupertinoColors.systemGrey6,
        ),
        WrapCircleContainer(
          text: text5,
          label: text6,
          optional: img3,
        ),
        SizedBox(
          height: paragraph / 4,
        ),
        Container(
          width: 0,
          height: screenWidth / 3.8,
          color: CupertinoColors.systemGrey6,
        ),
      ],
    );
  }
}
