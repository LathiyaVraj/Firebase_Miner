import 'package:fb3/screens/details.dart';
import 'package:fb3/screens/home_page.dart';
import 'package:fb3/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "SplashScreen",
      routes: {
        "HomePage": (context) => const HomePage(),
        "DetailPage": (context) => const DetailPage(),
        "SplashScreen": (context) => const SplashScreen(),
      },
    ),
  );
}
