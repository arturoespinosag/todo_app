import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/src/models/task.dart';

class DBServices {
  static Database? _database;
  static final DBServices db = DBServices._();
  DBServices._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database?> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'tasks.db');
    print(path);
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY,
            date TEXT,
            title TEXT,
            isDone INTEGER,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<int> addTask(Task task) async {
    final db = await database;
    final id = await db!.insert('tasks', task.toJson());
    return id;
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final response = await db?.query('tasks');
    final _tasks = (response!.map((task) => Task.fromJson(task))).toList();
    return _tasks;
  }

  Future<int> updateTask(Task newTask) async {
    final db = await database;
    final response = await db!.update('tasks', newTask.toJson(),
        where: 'id = ?', whereArgs: [newTask.id]);
    return response;
  }

  Future<int> deleteTask(int? id) async {
    final db = await database;
    final response =
        await db!.delete('tasks', where: 'id = ?', whereArgs: [id]);
    return response;
  }

  Future<int> completeTask(Task task) async {
    final db = await database;
    final response = await db!
        .update('tasks', task.toJson(), where: 'id = ?', whereArgs: [task.id]);
    return response;
  }
}
