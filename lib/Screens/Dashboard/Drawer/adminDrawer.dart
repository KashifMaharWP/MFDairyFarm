import 'package:dairyfarmflow/Screens/SampleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Widget/drawerListTile.dart';

class AdminOption extends StatefulWidget {
  const AdminOption({super.key});

  @override
  State<AdminOption> createState() => _AdminOptionState();
}

class _AdminOptionState extends State<AdminOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyListTile(
            iconss: CupertinoIcons.bus,
            title: "Manage User",
            route: Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const sampleScreen(backgroundColor: Colors.red)))),
        MyListTile(
            iconss: CupertinoIcons.doc_chart,
            title: "View Leave",
            route: Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const sampleScreen(backgroundColor: Colors.red)))),
        MyListTile(
            iconss: CupertinoIcons.doc_fill,
            title: "Create Project",
            route: Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const sampleScreen(backgroundColor: Colors.red)))),
        MyListTile(
            iconss: CupertinoIcons.share,
            title: "Share App",
            route: Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const sampleScreen(backgroundColor: Colors.red)))),
        MyListTile(
            iconss: CupertinoIcons.circle_fill,
            title: "Logout",
            route: Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const sampleScreen(backgroundColor: Colors.red)))),
      ],
    );
  }
}
