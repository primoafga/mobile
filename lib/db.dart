import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    print(path);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''

                    CREATE TABLE IF NOT EXISTS uas( 
                          id primary key,
                          nim int not null,
                          name varchar(255) not null,
                          alamat varchar(255) not null,
                          no int not null
                      );

                      //create more table here
                  
                  ''');
      print("Table Created");
    });
  }

  Future<Map<dynamic, dynamic>?> getData(int nohp) async {
    List<Map> maps = await db.query('uas', where: 'no = ?', whereArgs: [nohp]);
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
}
