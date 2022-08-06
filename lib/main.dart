import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todolist/firebase_options.dart';
import 'package:todolist/utils/constants.dart';
import 'package:todolist/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: kPrimayColor,
          iconTheme: const IconThemeData(color: kPrimayColor),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
          )),
      home: const Splash(),
    );
  }
}
