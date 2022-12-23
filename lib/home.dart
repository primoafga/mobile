import 'package:flutter/material.dart';
import 'package:uas/add.dart';
import 'package:uas/list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddData()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: Column(children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ListData();
              }));
            },
            child: Text("List Data"),
          ),
        ]),
      ),
    );
    debugShowCheckedModeBanner:
    false;
  }
}
