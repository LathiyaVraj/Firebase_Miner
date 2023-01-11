import 'dart:io';

import 'package:flutter/cupertino.dart';

class Global {
  static TextEditingController booknamecontroller = TextEditingController();
  static TextEditingController Authornamecontroller = TextEditingController();
  static GlobalKey<FormState> keyUpdate = GlobalKey();
  static GlobalKey<FormState> keyDataInsert = GlobalKey();
  static TextEditingController UpdateAuthornamecontroller =
      TextEditingController();
  static TextEditingController Updatebooknamecontroller =
      TextEditingController();

  File? image;
  static String? Bookname;
  static String? UpdateAuthorname;
  static String? Authorname;
  static String? UpdateBookname;
}
