import 'package:dairyfarmflow/Class/myRoutes.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/auth_provider.dart';
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
      ],
      child: MaterialApp(
        routes: myRoutes.getRoutes(),
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}
