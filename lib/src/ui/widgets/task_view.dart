import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/global_controller.dart';
import 'package:todo_app/src/models/task.dart';
import 'package:todo_app/src/ui/widgets/task_widget.dart';

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late Future<List<Task>> _value;

  @override
  void initState() {
    _value = context.read<GlobalController>().getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GlobalController>(context, listen: false);
    return FutureBuilder(
      future: _value,
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        final tasks = snapshot.data;
        if (snapshot.hasData) {
          return Column(
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(width: 15),
                  Text(
                    'My Notes',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Flexible(child: Container()),
                  Row(
                    children: [
                      Text('Priority: '),
                      Text('H '),
                      Container(
                        width: 15,
                        height: 15,
                        color: Colors.red.withOpacity(0.3),
                      ),
                      Text('M '),
                      Container(
                        width: 15,
                        height: 15,
                        color: Colors.yellow.withOpacity(0.3),
                      ),
                      Text('L '),
                      Container(
                        width: 15,
                        height: 15,
                        color: Colors.green.withOpacity(0.3),
                      ),
                      SizedBox(width: 15),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks!.length,
                  itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.teal,
                    ),
                    onDismissed: (direction) {
                      controller.deleteTask(tasks[index].id);
                    },
                    child: TaskWidget(
                      task: tasks[index],
                      index: index,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
