import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const int _version = 1;
  static const String _tableName = 'task';

  static Database? _db;

  static Future<void> initDB() async{
    if(_db != null){
      debugPrint('not null  Database');
      return;
    }

    try{
      String databasesPath = '${await getDatabasesPath()}task.db';
      var _db = await openDatabase(
        databasesPath,
        version: _version,
        onCreate: (Database db, int version) async{
          String sql = 'CREATE TABLE $_tableName ('
                          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                          'title TEXT,'
                          'date STRING,'
                          'startTime String,'
                          'endTime String,'
                          'remind INTEGER,'
                          'repeat String,'
                          'color INTEGER,'
                          ' isComplete INTEGER,'
                        ')';
          await db.execute(sql);
        },
      );
      // Get a location using getDatabasesPath

    }catch(e){
      print(e.toString());
    }
  }
}
