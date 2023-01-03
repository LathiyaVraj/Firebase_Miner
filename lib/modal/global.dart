import 'package:flutter/cupertino.dart';

class Globle {
  static GlobalKey<FormState> signupuserkey = GlobalKey();
  static GlobalKey<FormState> signInuserkey = GlobalKey();
  static TextEditingController emailcontroller = TextEditingController();
  static TextEditingController passwordcontroller = TextEditingController();

  static String? email;
  static String? password;
}
