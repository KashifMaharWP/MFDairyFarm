import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetail extends ChangeNotifier {
  String? id;
  String? name;
  String? email;
  String? role;
  String? token;

//method to set the user pereferences when the user body is get
  void setUserDetail(final userData) {
    id = userData['user_']['_id'].toString();
    name = userData['user_']['name'].toString();
    email = userData['user_']['email'].toString();
    role = userData['user_']['role'].toString();
    token = userData['token'].toString();
   
    //uncomment the below to get the picture
    //picture = userData['picture'].toString();
    //setting the User Preferences into the local store to analyze the user login and then access him through the local storage
    setUserPreferences();
  }

//set user data throught the Preferences;
  void setUserDetailByPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getString("_id");
    name = prefs.getString("name");
    email = prefs.getString("email");
    role = prefs.getString("role");
    token = prefs.getString("token");
    //uncomment the  below to store the picture preferences;
    //picture =
  }

  Future setUserPreferences() async {
    if (kDebugMode) {
      print("Going to store the preferences in the Local Storage: $id");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", id.toString());
    await prefs.setString("name", name.toString());

    await prefs.setString("email", email.toString());

    await prefs.setString("role", role.toString());

    await prefs.setString("token", token.toString());

    //uncomment the below to store the picture preferences
    //await prefs.setString("Picture", "");
  }

//function to clear all the user preferences
  Future clearUserPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", "");
    await prefs.setString("name", "");
    await prefs.setString("email", "");
    await prefs.setString("role", "");
    await prefs.setString("token", "");

    //uncomment the below to clear the picture preferences
    //await prefs.setString("Picture", "");
  }
}
