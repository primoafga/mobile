import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uas/db.dart';
import 'package:uas/edit.dart';

class ListData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListData();
  }
}

class _ListData extends State<ListData> {
  List<Map> slist = [];
  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      slist = await mydb.db.rawQuery('SELECT * FROM uas');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.length == 0
              ? Text("No any Data.")
              : Column(
                  children: slist.map((stuone) {
                    return Card(
                      child: ListTile(
                        title: Text(stuone["name"]),
                        subtitle: Text(stuone["nim"].toString() +
                            stuone["alamat"].toString() +
                            stuone["no"].toString()),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return EditData(rollno: stuone["no"]);
                                  }));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  await mydb.db.rawDelete(
                                      "DELETE FROM uas WHERE no = ?",
                                      [stuone["no"]]);
                                  print("Data Deleted");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Data Deleted")));
                                  getdata();
                                },
                                icon: Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
