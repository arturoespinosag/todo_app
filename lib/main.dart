import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/global_controller.dart';
import 'package:todo_app/src/routes/pages.dart';
import 'package:todo_app/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalController>(
      create: (context) => GlobalController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: Pages.home,
        routes: Routes.routes,
      ),
    );
  }
}
