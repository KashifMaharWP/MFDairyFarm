import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRegistration/animalRegistrationPage.dart';
import 'package:dairyfarmflow/Screens/SampleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Widget/customDashboardButton.dart';


class AdminDashboardButtons extends StatefulWidget {
  const AdminDashboardButtons({super.key});

  @override
  State<AdminDashboardButtons> createState() => _AdminDashboardButtons();
}

class _AdminDashboardButtons extends State<AdminDashboardButtons> {
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
                colors: Colors.orange,
                btnName: "Add Animal",
                customIcon: "lib/assets/cow.png",
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => animalRegistrationPage()));

                }),
            CustomDashboardButton(
                colors: Colors.pink,
                btnName: "Add Feed",
                customIcon: "lib/assets/wanda.png",
                ontap: () {

                }),

            CustomDashboardButton(
                colors: Colors.green,
                btnName: "Dairy Record",
                customIcon: "lib/assets/dairyfarm.png",
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => sampleScreen(backgroundColor: Colors.deepOrange)));

                }),
            CustomDashboardButton(
                colors: Colors.cyan,
                btnName: "Medical Record",
                customIcon: "lib/assets/medical.png",
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => sampleScreen(backgroundColor: Colors.cyan)));
                }),

          ],
        ),
      );
  }
}
