import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Screens/Login/Screen/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: darkGreenColor
            // gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     colors: [Colors.pinkAccent, Colors.purpleAccent]),
            ),
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: screenHeight * .05,
                    foregroundImage:
                        const AssetImage("lib/assets/farmWorker.png"),
                  ),
                  SizedBox(
                    height: screenHeight * .008,
                  ),
                  Text(
                    'Admin Name',
                    style: TextStyle(
                        fontSize: screenHeight * .03,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
                size: screenHeight * .035,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                    fontSize: screenHeight * .03,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                CupertinoIcons.person_alt,
                size: screenHeight * .035,
                color: Colors.white,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    fontSize: screenHeight * .03,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                CupertinoIcons.chart_bar,
                size: screenHeight * .035,
                color: Colors.white,
              ),
              title: Text(
                'Random',
                style: TextStyle(
                    fontSize: screenHeight * .03,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () async {
                Provider.of<UserDetail>(context, listen: false)
                    .clearUserPreferences();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              leading: Icon(
                CupertinoIcons.square_arrow_left,
                size: screenHeight * .035,
                color: Colors.white,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                    fontSize: screenHeight * .03,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
