import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:todo_app/src/models/task.dart';
import 'package:todo_app/src/services/DBServices.dart';

class GlobalController extends ChangeNotifier {
  List<Task> tasks = [];
  Task selectedTask = Task(
    id: 0,
    date: DateTime.now(),
    title: '',
    isDone: false,
    description: '',
  );

  Future<Task> addTask(Task task) async {
    final id = await DBServices.db.addTask(task);

    task.id = id;
    tasks.add(task);
    notifyListeners();
    return task;
  }

  Future<List<Task>> getTasks() async {
    final _tasks = await DBServices.db.getTasks();
    this.tasks = _tasks;
    notifyListeners();
    return _tasks;
  }

  Future<void> deleteTask(int? id) async {
    await DBServices.db.deleteTask(id);
    tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  Future<int> completeTask(Task task) async {
    task.isDone = !task.isDone;
    final response = await DBServices.db.completeTask(task);
    notifyListeners();
    return response;
  }

  Future<int> updateTask(Task task) async {
    final response = await DBServices.db.updateTask(task);
    final oldTaskIndex = tasks.indexWhere((item) => item.id == task.id);
    tasks[oldTaskIndex] = task;
    notifyListeners();
    return response;
  }
}
