import 'package:flutter/material.dart';

import '../global.dart';
import '../helpers/fb_helper.dart';

class Update_Book extends StatefulWidget {
  const Update_Book({Key? key}) : super(key: key);

  @override
  State<Update_Book> createState() => _Update_BookState();
}

class _Update_BookState extends State<Update_Book> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("EDIT"),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      backgroundColor: Colors.brown.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: Global.keyUpdate,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: Global.UpdateAuthornamecontroller,
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
                          Global.UpdateAuthorname = val!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: Global.Updatebooknamecontroller,
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
                          Global.UpdateBookname = val!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (Global.keyUpdate.currentState!.validate()) {
                          Global.keyUpdate.currentState!.save();

                          Map<String, dynamic> data = {
                            "authorname":
                                Global.UpdateAuthornamecontroller.text,
                            "bookname": Global.Updatebooknamecontroller.text,
                            // "image": imagestring
                          };

                          FireStoreHelpers.fireStoreHelpers
                              .updatedata(data: data, id: res);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "HomePage", (route) => false);
                        }
                      },
                      child: const Text("UPDATE BOOK"),
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
