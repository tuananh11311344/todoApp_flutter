import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/src/models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db;

  DatabaseHelper._instance();

  String taskTable = 'task_table';
  String colId = 'id';
  String colname = 'name';
  String colDescription = 'description';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  Future<Database?> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}todo_list.db';
    final todoListDB =
        await openDatabase(path, version: 1, onCreate: _createDb,);
    return todoListDB;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $taskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colname TEXT, $colDescription TEXT, $colDate TEXT, $colPriority TEXT, $colStatus INTEGER)");
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(taskTable);
    return result;
  }
  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();

    final List<Task> taskList = [];
    for (var taskMap in taskMapList) {
      taskList.add(Task.fromMap(taskMap));
    }
    // taskList.sort((taskA, taskB)=> taskA.date !.compareTo(taskB.date!));
    return taskList;
  }

  Future<int> insertTask(Task task) async {
    Database? db = await this.db;
    final int result = await db!.insert(
      taskTable,
      task.toMap(),
    );
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database? db = await this.db;
    final int result = await db!.update(
      taskTable,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );
    return result;
  }

  Future<int> deleteTask(int id) async {
    Database? db = await this.db;
    final int result = await db!.delete(
      taskTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result =
        await db!.rawQuery('SELECT * FROM $taskTable');
    return result;
  }
}
