import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uas/db.dart';

class AddData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddData();
  }
}

class _AddData extends State<AddData> {
  TextEditingController nim = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController nohp = TextEditingController();

  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Isi Bio Data"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nim,
                decoration: InputDecoration(
                  hintText: "Nim",
                ),
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Nama",
                ),
              ),
              TextField(
                controller: alamat,
                decoration: InputDecoration(
                  hintText: "Alamat",
                ),
              ),
              TextField(
                controller: nohp,
                decoration: InputDecoration(
                  hintText: "No HP",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO uas (nim, name, alamat, no) VALUES (?, ?, ?, ?);",
                        [nim.text, name.text, alamat.text, nohp.text]);

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("New Data Added")));

                    nim.text = "";
                    name.text = "";
                    alamat.text = "";
                    nohp.text = "";
                  },
                  child: Text("Save Data")),
            ],
          ),
        ));
  }
}
