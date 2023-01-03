import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Helpers/firebase_auth_page.dart';
import '../../modal/global.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed("/");
            },
            icon: const Icon(Icons.home),
          ),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: Form(
        key: Globle.signInuserkey,
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: Globle.emailcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Email First ",
                    label: Text("Email"),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter your email";
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      Globle.email = val!;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: Globle.passwordcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter password First ",
                    label: Text("Password"),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter your email";
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      Globle.password = val!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (Globle.signInuserkey.currentState!.validate()) {
                      Globle.signInuserkey.currentState!.save();
                      try {
                        User? user = await FirebaseAuthHelpers
                            .firebaseAuthHelpers
                            .signInUser(
                                email: Globle.email!,
                                password: Globle.password!);
                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sign in successfully"),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.of(context).pushReplacementNamed("HomePage",
                              arguments: user);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("signIn failed"),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        switch (e.code) {
                          case "wrong-password":
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Your password is wrong"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            break;
                          case "user-not-found":
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("use not found"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            break;
                        }
                        Globle.emailcontroller.clear();
                        Globle.passwordcontroller.clear();
                        setState(() {
                          Globle.email = null;
                          Globle.password = null;
                        });
                      }
                    }
                  },
                  child: const Text("Sign In"),
                  style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                ),
                OutlinedButton(
                  onPressed: () async {
                    Globle.emailcontroller.clear();
                    Globle.passwordcontroller.clear();
                    setState(() {
                      Globle.email = null;
                      Globle.password = null;
                    });
                  },
                  child: Text("cancel"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have and account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed("signup_page");
                      },
                      child: Text("Signup"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
