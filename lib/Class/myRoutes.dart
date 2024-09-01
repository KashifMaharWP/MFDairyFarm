import 'package:dairyfarmflow/Screens/AdminScreen/AnimalRegistration/animalRegistrationPage.dart';
import 'package:dairyfarmflow/Screens/AdminScreen/FeedEntry/feedEntryPage.dart';
import 'package:dairyfarmflow/Screens/Dashboard/Dashboard.dart';
import 'package:dairyfarmflow/Screens/Home/Home.dart';
import 'package:dairyfarmflow/Screens/Login/Screen/loginPage.dart';
import 'package:flutter/cupertino.dart';

import '../Screens/Home/Home.dart';

class myRoutes{
  static const String login="/login";
  static const String homePage="/home";
  static const String dashboard="/dashboard";
  static const String animalRegistration="/animalRegistration";
  static const String feedEntry="/feedEntry";

  static Map<String, WidgetBuilder> getRoutes(){
    return {
      login: (context) => const loginPage(),
      homePage: (context) =>  home(),
      dashboard: (context) =>  Dashboard(),
      animalRegistration: (context) => const animalRegistrationPage(),
      feedEntry: (context) => const feedEntryPage(),

    };
  }
}
