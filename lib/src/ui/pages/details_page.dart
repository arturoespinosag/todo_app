import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/global_controller.dart';
import 'package:todo_app/src/models/task.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isEnabled = true;
  final _formKey = GlobalKey<FormState>();
  Task _selectedTask = Task(
    id: 0,
    date: DateTime.now(),
    title: '',
    isDone: false,
    description: '',
  );

  String? _validator(String? text) {
    if (text!.length < 1) {
      return 'Required field';
    } else {
      return null;
    }
  }

  void _submit(BuildContext context) {
    final controller = Provider.of<GlobalController>(context, listen: false);
    final isValidated = _formKey.currentState!.validate();
    _selectedTask = controller.selectedTask;
    if (isValidated) {
      print(_selectedTask.id);
      if (_selectedTask.id == 0) {
        controller.addTask(_selectedTask);
        Navigator.pop(context);
      } else {
        controller.updateTask(_selectedTask);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GlobalController>(context, listen: false);
    final _task = controller.selectedTask;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: controller.selectedTask.title,
                      decoration: InputDecoration(labelText: 'Title'),
                      onChanged: (text) => controller.selectedTask.title = text,
                      validator: _validator,
                    ),
                    TextFormField(
                      initialValue: controller.selectedTask.description,
                      decoration: InputDecoration(labelText: 'Description'),
                      onChanged: (text) =>
                          controller.selectedTask.description = text,
                      validator: _validator,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CalendarDatePicker(
                      initialDate: _task.date,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2050),
                      onDateChanged: (newDate) {
                        controller.selectedTask.date = newDate;
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: isEnabled ? Colors.blue : Colors.grey),
                      onPressed: () {
                        _submit(context);
                      },
                      child: Text(
                        'Save',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
