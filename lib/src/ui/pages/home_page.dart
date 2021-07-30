import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/global_controller.dart';
import 'package:todo_app/src/models/task.dart';
import 'package:todo_app/src/routes/pages.dart';

import 'package:todo_app/src/ui/widgets/task_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GlobalController>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TaskView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_outlined),
        onPressed: () async {
          controller.selectedTask = Task(
            id: 0,
            date: DateTime.now(),
            title: '',
            isDone: false,
            description: '',
          );
          Navigator.pushNamed(context, Pages.details);
        },
      ),
    );
  }
}
