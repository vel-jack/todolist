import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/utils/constants.dart';
import 'package:todolist/view/edit_todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: kPrimayColor,
          iconTheme: const IconThemeData(color: kPrimayColor),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
          )),
      home: const EditTodo(),
    );
  }
}
