import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Helpers/firebase_auth_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController updateemailcontroller = TextEditingController();

  String updateemail = "";

  @override
  Widget build(BuildContext context) {
    User? user = ModalRoute.of(context)?.settings.arguments as User?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuthHelpers.firebaseAuthHelpers.logout();
                Navigator.of(context).pushReplacementNamed("/");
              },
              icon: Icon(Icons.logout_outlined))
        ],
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
