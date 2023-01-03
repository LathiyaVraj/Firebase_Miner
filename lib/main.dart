import 'package:firebase_app/view/screens/HomePage.dart';
import 'package:firebase_app/view/screens/login_page.dart';
import 'package:firebase_app/view/screens/signup_page.dart';
import 'package:firebase_app/view/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash_screen",
      routes: {
        "/": (context) => LogInPage(),
        "HomePage": (context) => HomePage(),
        "signup_page": (context) => signup_page(),
        "login_page": (context) => login_page(),
        "splash_screen": (context) => SplashScreen(),
      },
    ),
  );
}

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("signup_page");
                },
                child: Text("sign up")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("login_page");
                },
                child: const Text("sign In")),
          ],
        ),
      ),
    );
  }
}
