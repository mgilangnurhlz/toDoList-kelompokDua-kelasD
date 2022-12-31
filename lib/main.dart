import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist_kelompokdua_kelasd/screens/todo_list.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: const Color(0xFF303030),
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: const Color(0xFFFFA000),
          )),
      home: TodoListPage(),
    );
  }
}
