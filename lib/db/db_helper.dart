import 'package:fluter_todo_app/models/task.dart';
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
      _db = await openDatabase(
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

      debugPrint('DataBase Created');

    }catch(e){
      print(e.toString());
    }
  }

  static Future<int> insert(Task task) async{
    debugPrint('Start insert');
    return await _db!.insert(_tableName, task.toJson());
  }

  static Future<int> delete(Task task) async{
    debugPrint('Start delete');
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Map<String, dynamic>>> query(Task task) async{
    debugPrint('Start query');
    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async{
    debugPrint('Start update');
    return await _db!.rawUpdate('''
    UPDATE taske set 
    isCompleted = ?
    where id ?
    ''', [1, id]);
  }


}
