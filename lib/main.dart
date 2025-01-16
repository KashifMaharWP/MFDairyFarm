import 'package:dairyfarmflow/Class/myRoutes.dart';
import 'package:dairyfarmflow/Class/screenMediaQuery.dart';
import 'package:dairyfarmflow/Providers/CowProvider/cows_provider.dart';
import 'package:dairyfarmflow/Providers/FeedProviders/feed_provider.dart';
import 'package:dairyfarmflow/Providers/Filter%20Provider/filter.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_provider.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/milk_record.dart';
import 'package:dairyfarmflow/Providers/MilkProviders/worker_provider.dart';
import 'package:dairyfarmflow/Providers/animal_registratin_provider.dart';
import 'package:dairyfarmflow/Providers/auth_provider.dart';
import 'package:dairyfarmflow/Providers/register_user_provider.dart';
import 'package:dairyfarmflow/Providers/registration_provider.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:dairyfarmflow/Screens/Login/Screen/loginPage.dart';
import 'package:dairyfarmflow/Screens/SplashScreen/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/Medical/add_medical.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width * 0.70;
    screenHeight = MediaQuery.of(context).size.height * 0.70;

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
        ChangeNotifierProvider(create: (context) => WorkerProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => CowsProvider()),
        ChangeNotifierProvider(
          create: (context) => MilkRecordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddMedical(),
        )
      ],
      child: MaterialApp(
        routes: MyRoutes.getRoutes(),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
