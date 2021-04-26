import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/welcome_screen.dart';
import 'package:medhouse_project/authentication/registration.dart';
import 'package:medhouse_project/model/cart.dart';
import 'package:provider/provider.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => Cart(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedHouse',
      theme: new ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xFF0FB8B3),
          accentColor: Colors.white
      ),
      home: WelcomeScreen(),
    );
  }
}

