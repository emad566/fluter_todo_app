import 'package:fluter_todo_app/models/task.dart';
import 'package:fluter_todo_app/services/notification_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const int _version = 10;
  static const String _tableName = 'task';

  static Database? _db;

  static Future<void> initDB() async{
    try{
      String databasesPath = '${await getDatabasesPath()}tasks2.db';
      _db = await openDatabase(
        databasesPath,
        version: _version,
        onCreate: (Database db, int version) async{
          if(_db != null){
            debugPrint('not null  Database');
            return;
          }
          String sql = 'CREATE TABLE $_tableName ('
                          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                          'title TEXT,'
                          'note TEXT,'
                          'date STRING,'
                          'startTime String,'
                          'endTime String,'
                          'remind INTEGER,'
                          'repeat String,'
                          'color INTEGER,'
                          'isCompleted INTEGER'
                        ')';
          await db.execute(sql);
        },
      );

      debugPrint('DataBase opened/Created');

    }catch(e){
      print(e.toString());
    }
  }

  static Future<int> insert(Task task) async{
    debugPrint('Start insert');
    return await _db!.insert(_tableName, task.toJson());
  }

  static Future<int> delete(int taskId) async{
    debugPrint('Start delete');
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [taskId]);
  }

  static Future<void> deleteAll() async{
    debugPrint('Start deleteAll');
    await _db!.delete(_tableName);
    await NotifyHelper().cancelAllNotification();
  }

  static Future<List<Map<String, dynamic>>> query() async{
    debugPrint('Start query');
    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async{
    debugPrint('Start update');
    return await _db!.rawUpdate('''
    UPDATE $_tableName set 
    isCompleted = ?
    where id = ?
    ''', [1, id]);
  }


}
