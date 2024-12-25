import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:flutter/material.dart';

import '../Dashboard/Dashboard.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<Widget> screens = [
    const Dashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: whiteColor, body: screens[0]);
  }
}
