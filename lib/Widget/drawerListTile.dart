import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatefulWidget {
  MyListTile(
      {super.key,
        required this.iconss,
        required this.title,
        required this.route});
  IconData iconss;
  String title;
  final route;

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  String? prefUid = '';

  Future _getUserDetail() async {

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight/4,
      child: ListTile(
        leading: Icon(
          widget.iconss,
          color: Colors.red.shade900,
          size: screenWidth/22,
        ),
        title: Text(
          widget.title,
          style:
          TextStyle(color: Colors.black, fontSize: screenWidth/22),
        ),
        onTap: () async {
          /*if (widget.title == "Logout") {
            await showDialog(
                context: context,
                builder: (_) => ConfirmationDialog(
                    title: "Logout",
                    description: "Are you Sure do you want to logout?"));
            // _getUserDetail();
            // print('user id = ${prefUid}');
          }
          widget.route != ""
              ? Navigator.pushNamed(context, widget.route)
              : Navigator.pushNamed(context, AppRoutes.homePage);*/
        },
      ),
    );
  }
}
