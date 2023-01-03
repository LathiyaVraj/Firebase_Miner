import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Helpers/firebase_auth_page.dart';
import '../../modal/global.dart';

class signup_page extends StatefulWidget {
  const signup_page({Key? key}) : super(key: key);

  @override
  State<signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup Page"),
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
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: Globle.signupuserkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "SignUp your account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: Globle.emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter your email",
                    label: Text("Email"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter first email";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      Globle.email = val;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: Globle.passwordcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your password",
                    label: Text("Password"),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter password";
                    } else if (val.length < 6) {
                      return "Please enter minimum 6 character";
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      Globle.password = val!;
                    });
                  },
                ),
                ElevatedButton(
                  child: const Text("Sign Up"),
                  onPressed: () async {
                    if (Globle.signupuserkey.currentState!.validate()) {
                      Globle.signupuserkey.currentState!.save();
                      try {
                        User? user = await FirebaseAuthHelpers
                            .firebaseAuthHelpers
                            .sigupuser(
                                email: Globle.email!,
                                password: Globle.password!);

                        if (user != null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Sign up successful"),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ));
                          Navigator.of(context).pushReplacementNamed("HomePage",
                              arguments: user);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Sign up faild"),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        switch (e.code) {
                          case "email-already-in-use":
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("This user already exists"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            break;
                          case "week-password":
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Password must be 6 characters or long"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            break;
                          case "invalid-email":
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Enter valid email address"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            break;
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                ),
                OutlinedButton(
                    onPressed: () {
                      Globle.emailcontroller.clear();
                      Globle.passwordcontroller.clear();
                      setState(() {
                        Globle.email = null;
                        Globle.password = null;
                      });
                    },
                    child: Text("cancel")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have and account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed("login_page");
                      },
                      child: Text("LogIn"),
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
