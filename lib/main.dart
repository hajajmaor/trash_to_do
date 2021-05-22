import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trash_to_do/views/main_page.dart';

import 'models/to_do.dart';

const kToDoBoxName = "todos";

Future<void> main() async {
  try {
    final path = Directory.current.path;
    await Hive.initFlutter(path);
  } catch (e) {
    await Hive.initFlutter();
  }

  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox<ToDo>(kToDoBoxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trash To Do',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          brightness: Brightness.dark,
        ),
        home: MainPage(),
      );
}
