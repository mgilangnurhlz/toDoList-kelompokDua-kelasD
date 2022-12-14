import 'dart:html';
import 'package:flutter/material.dart';
import 'package:todolist_kelompokdua_kelasd/screens/add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Todo List')),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: navigateToAddPage, label: Text('add Todo')));
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    Navigator.push(context, route);
  }
}
