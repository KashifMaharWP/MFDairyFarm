import 'dart:async';
import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Screens/Dashboard/Dashboard.dart';
import 'package:dairyfarmflow/Screens/Dashboard/UserDashboard/user_dashboard.dart';
import 'package:dairyfarmflow/Screens/Login/Screen/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      checkUserData();
    });
  }

  checkUserData()async{
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final chk = prefs.getString('userId');
    final role = prefs.getString('role');
    
    await Future.delayed(Duration(seconds: 1));
    //checking if the user detail is available then
    if (chk != '' && chk != null) {
      //get user data from the preference and store it in userdetail class
      Provider.of<UserDetail>(context, listen: false)
          .setUserDetailByPreferences();
         
      if (role == 'Admin') {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Dashboard()), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserDashboard()), (route) => false);
      }
          

    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      }
    }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitPouringHourGlass(color: darkGreenColor,size: 80,),
            SizedBox(height: 150,),
            Center(
              child: Image.asset(
                "lib/assets/Logo.png", // Your logo or image
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 10,),
            Text("Welcome to MF Dairy Farm",style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),),
          ],
        ),
      ),
    );
  }
}
