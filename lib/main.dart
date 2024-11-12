import 'package:dairyfarmflow/Class/myRoutes.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/FeedProviders/feed_provider.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:dairyfarmflow/Providers/animal_registratin_provider.dart';
import 'package:dairyfarmflow/Providers/auth_provider.dart';
import 'package:dairyfarmflow/Providers/register_user_provider.dart';
import 'package:dairyfarmflow/Providers/registration_provider.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Screens/Login/Screen/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserDetail(),
        ),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
            create: (context) => AnimalRegistratinProvider()),
        ChangeNotifierProvider(create: (context) => FeedProvider()),
        ChangeNotifierProvider(create: (context) => MilkProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider(create: (context) => RegisterUserProvider()),
      ],
      child: MaterialApp(
        routes: MyRoutes.getRoutes(),
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}
