import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRegistration/animalRegistrationPage.dart';
import 'package:dairyfarmflow/Screens/Dashboard/Dashboard.dart';
import 'package:dairyfarmflow/Screens/Home/Home.dart';
import 'package:dairyfarmflow/Screens/Login/Screen/loginPage.dart';
import 'package:flutter/cupertino.dart';

class MyRoutes {
  static const String login = "/login";
  static const String homePage = "/home";
  static const String dashboard = "/dashboard";
  static const String animalRegistration = "/animalRegistration";
  static const String feedEntry = "/feedEntry";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginPage(),
      homePage: (context) => home(),
      dashboard: (context) => const Dashboard(),
      animalRegistration: (context) => const AnimalRegistrationPage(),
      // feedEntry: (context) => const feedEntryPage(),
    };
  }
}
