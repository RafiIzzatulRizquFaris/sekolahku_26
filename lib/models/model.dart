import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Model {
  Database database;

  Future<Database> openDB() async {
    var databaseDirectory = await getDatabasesPath();

    try {
      await Directory(databaseDirectory).create(recursive: true);
    } catch (error) {
      print("Error Database : $error");
    }

    var path = join(databaseDirectory, "siswa_db");

    database = await openDatabase(
      path,
      onCreate: (db, version) {
        String sqlRaw = '''
        
        CREATE TABLE IF NOT EXISTS siswa(
        id_siswa INTEGER PRIMARY KEY NOT NULL,
        first_name TEXT(20),
        last_name TEXT(20),
        gender TEXT(6),
        grade TEXT(3),
        address TEXT(45),
        mobile_phone TEXT(13),
        hobbies TEXT
        );
        
        ''';

        db.execute(sqlRaw);
      },
      version: 1,
    );

    return database;
  }

  Future<void> closeDB(){
    return database.close();
  }
}
