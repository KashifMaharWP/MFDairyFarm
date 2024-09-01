import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Screens/Dashboard/adminDashboard/adminDashboard.dart';
import 'package:dairyfarmflow/Screens/Dashboard/workerDashboard/workerDashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String role="1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: [
        pageHeaderContainer()
      ],
    ),
    );
  }

  Widget pageHeaderContainer() {
    return Material(
        elevation: 6,
        borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        child: Container(
          height: screenHeight / 2.5,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight/40,
                ),
                //here is the code for the custom gridview boxes
                gridButtons()
               // Text("data")

              ],
            ),
          )));
  }

  Widget gridButtons() {
    return role == "1"
        ? const AdminDashboardButtons()
        : const workerDashboardButtons();
  }
}
