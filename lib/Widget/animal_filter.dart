import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/Filter%20Provider/filter.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class  AnimalFilterWidget extends StatefulWidget {
  const AnimalFilterWidget({super.key});

  @override
  State<AnimalFilterWidget> createState() => _AnimalFilterWidgetState();
}

class _AnimalFilterWidgetState extends State<AnimalFilterWidget> {
  String selectedFilter = "Available";
  String selectedDate = DateFormat("dd MMMM yyyy").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        customFilter(
          "Available",
          whiteColor,
          blackColor,
          darkGreenColor,
          selectedFilter == "Available",
        ),
       const SizedBox(width: 10),
        customFilter(
          "Sold",
          whiteColor,
          blackColor,
          Colors.red,
          selectedFilter == "Sold",
        ),
       const SizedBox(width: 10),
        customFilter(
          "All",
          whiteColor,
          blackColor,
          Colors.amber,
          selectedFilter == "All",
        ),
      ],
    );
  }

  // customFilter
  Widget customFilter(String text, Color backgroundColor, Color selectColor,
      Color iconColor, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = text; // Update the selected filter when tapped
          Provider.of<FilterProvider>(context, listen: false).filter(selectedFilter);
          
        });
      },
      child: Container(
        width: screenWidth / 4,
        height: screenHeight / 22,
        decoration: BoxDecoration(
          color: isSelected
              ? CupertinoColors.systemGrey5
              : backgroundColor, // Change background if selected
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Only show the icon if the filter is not selected
              if (!isSelected)
                Icon(Icons.circle, size: screenWidth / 24, color: iconColor),
              SizedBox(width: screenWidth / 60),
              Text1(
                text: text,
                fontSize: screenWidth / 24,
                fontColor: isSelected
                    ? blackColor
                    : selectColor, // Change text color if selected
              ),
            ],
          ),
        ),
      ),
    );
  }
}
