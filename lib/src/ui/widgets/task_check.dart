import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/global_controller.dart';
import 'package:todo_app/src/models/task.dart';

class TaskCheck extends StatelessWidget {
  const TaskCheck({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GlobalController>(context);

    return IconButton(
        onPressed: () {
          controller.completeTask(task);
        },
        icon: const Icon(Icons.check_circle),
        color: (task.isDone == true)
            ? const Color.fromRGBO(0, 172, 0, 1)
            : Colors.grey);
  }
}
