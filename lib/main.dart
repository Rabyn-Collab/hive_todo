import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_todo/model/todo.dart';
import 'package:hive_todo/screens/todo_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todos');
runApp(Home());
}


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}
