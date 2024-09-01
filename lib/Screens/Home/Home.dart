import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dashboard/Dashboard.dart';

class home extends StatefulWidget {
   home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  List<Widget> screens = [
    Dashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: screens[0]
    );
  }
}
