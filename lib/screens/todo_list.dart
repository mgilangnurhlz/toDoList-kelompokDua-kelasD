import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todolist_kelompokdua_kelasd/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;

  List items = [];
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Todo List')),
        body: Visibility(
          visible: isLoading,
          child: Center(child: CircularProgressIndicator()),
          replacement: RefreshIndicator(
            onRefresh: fetchTodo,
            child: ListView.builder(
              itemsCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(item['title']),
                  title: Text(item['description']),
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: navigateToAddPage, label: Text('add Todo')));
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    Navigator.push(context, route);
  }

  Future<void> fetchTodo() async {
    final url = 'http://api.nstack.in/v1/todos?page=1&limit=10';
    final url = Uri.parse(url);
    final response = http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
