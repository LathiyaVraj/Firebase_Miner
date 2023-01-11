import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import '../helpers/fb_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REGISTERED AUTHOR"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown.shade200,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Global.booknamecontroller.clear();
          Global.Authornamecontroller.clear();
          setState(() {
            Global.Bookname = null;
            Global.Authorname = null;
          });
          Navigator.of(context).pushNamed("Add_Book");
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FireStoreHelpers.fireStoreHelpers.fetchalldata(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            QuerySnapshot? querySnapshot = snapshot.data;

            List<QueryDocumentSnapshot> alldata = querySnapshot!.docs;

            return ListView.builder(
                itemCount: alldata.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.brown,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      "Author Name:  ${alldata[i]["authorname"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.white)),
                                  Text(
                                    " Book Name:  ${alldata[i]["bookname"]}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Colors.brown.shade200,
                                                title:
                                                    const Text("Delete record"),
                                                content: const Text("Confirm"),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        String id =
                                                            alldata[i].id;
                                                        FireStoreHelpers
                                                            .fireStoreHelpers
                                                            .deletedata(id: id);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Delete"),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Colors
                                                                  .brown)),
                                                  OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        "cancel",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.brown),
                                                      )),
                                                ],
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Global.UpdateAuthornamecontroller.text =
                                            alldata[i]["authorname"];
                                        Global.Updatebooknamecontroller.text =
                                            alldata[i]["bookname"];
                                        Navigator.of(context).pushNamed(
                                            "Update_Book",
                                            arguments: alldata[i].id);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
