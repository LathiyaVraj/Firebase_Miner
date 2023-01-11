import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("NOTES"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 5),
              Text(
                "Title:",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${res["title"]}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                    softWrap: false,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const SizedBox(width: 5),
              Text(
                "Note:",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${res["note"]}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                    softWrap: false,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
