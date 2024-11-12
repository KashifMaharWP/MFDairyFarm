import 'package:dairyfarmflow/Screens/SampleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Widget/customDashboardButton.dart';

class WorkerDashboardButtons extends StatefulWidget {
  const WorkerDashboardButtons({super.key});

  @override
  State<WorkerDashboardButtons> createState() => _workerDashboardButtons();
}

// ignore: camel_case_types
class _workerDashboardButtons extends State<WorkerDashboardButtons> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            mainAxisExtent: 110),
        children: [
          CustomDashboardButton(
              colors: Colors.cyan,
              btnName: "Morning Milk",
              customIcon: "lib/assets/sun.png",
              ontap: () {}),
          CustomDashboardButton(
              colors: Colors.orange,
              btnName: "Evening Milk",
              customIcon: "lib/assets/moon.png",
              ontap: () {}),
          CustomDashboardButton(
              colors: Colors.green,
              btnName: "Pregenency",
              customIcon: "lib/assets/cow.png",
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const sampleScreen(
                            backgroundColor: Colors.deepOrange)));
              }),
          CustomDashboardButton(
              colors: Colors.pink,
              btnName: "Comments",
              customIcon: "lib/assets/document.png",
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const sampleScreen(backgroundColor: Colors.pink)));
              }),
        ],
      ),
    );
  }
}
