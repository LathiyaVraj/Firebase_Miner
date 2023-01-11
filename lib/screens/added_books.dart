import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import '../helpers/fb_helper.dart';

class Add_Book extends StatefulWidget {
  const Add_Book({Key? key}) : super(key: key);

  @override
  State<Add_Book> createState() => _Add_BookState();
}

class _Add_BookState extends State<Add_Book> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("REGISTRATION"),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      backgroundColor: Colors.brown.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: Global.keyDataInsert,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: Global.Authornamecontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter author name",
                        label: Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.brown, fontWeight: FontWeight.bold),
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter author name";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          Global.Authorname = val!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: Global.booknamecontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book name",
                        label: Text(
                          "Book",
                          style: TextStyle(
                              color: Colors.brown, fontWeight: FontWeight.bold),
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter book Name";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          Global.Bookname = val!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (Global.keyDataInsert.currentState!.validate()) {
                          Global.keyDataInsert.currentState!.save();

                          Map<String, dynamic> data = {
                            "authorname": Global.Authornamecontroller.text,
                            "bookname": Global.booknamecontroller.text,
                          };
                          DocumentReference docref = await FireStoreHelpers
                              .fireStoreHelpers
                              .insertdata(data: data);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "HomePage", (route) => false);
                        }
                      },
                      child: const Text("ADD BOOK"),
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
