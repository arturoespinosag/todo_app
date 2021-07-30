import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/global_controller.dart';

import 'package:todo_app/src/models/task.dart';
import 'package:todo_app/src/routes/pages.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task, required this.index})
      : super(key: key);

  final Task task;
  final int index;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GlobalController>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(5),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: Text(task.id.toString()),
        title: Text('${task.title}'),
        subtitle: Text(
            '${task.description} - ${task.date.day}/${task.date.month}/${task.date.year}'),
        trailing: TaskCheck(task: task),
        tileColor: (task.date.difference(DateTime.now()).inDays < 7)
            ? Colors.red.withOpacity(0.3)
            : ((task.date.difference(DateTime.now()).inDays < 30)
                ? Colors.yellow.withOpacity(0.3)
                : Colors.green.withOpacity(0.3)),
        onTap: () {
          controller.selectedTask = task;
          Navigator.pushNamed(context, Pages.details);
        },
      ),
    );
  }
}

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
