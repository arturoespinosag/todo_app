import 'package:flutter/widgets.dart';
import 'package:todo_app/src/routes/pages.dart';
import 'package:todo_app/src/ui/pages/details_page.dart';
import 'package:todo_app/src/ui/pages/home_page.dart';

abstract class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    Pages.home: (_) => HomePage(),
    Pages.details: (_) => DetailsPage(),
  };
}
