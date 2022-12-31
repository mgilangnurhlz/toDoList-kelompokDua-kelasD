import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todolist_kelompokdua_kelasd/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  final Map? todo;
  const TodoListPage({
    super.key,
    this.todo,
  });

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
        appBar: AppBar(centerTitle: true, title: Text('Daftar Tugas')),
        body: Visibility(
          visible: isLoading,
          child: Center(child: CircularProgressIndicator()),
          replacement: RefreshIndicator(
            onRefresh: fetchTodo,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item['_id'] as String;
                return ListTile(
                    leading: CircleAvatar(
                        backgroundColor: const Color(0xdd000000),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(color: Colors.white),
                        )),
                    title: Text(item['title']),
                    subtitle: Text(item['description']),
                    trailing: PopupMenuButton(onSelected: (value) {
                      if (value == 'delete') {
                        //Delete and remove the item
                        deleteById(id);
                      }
                    }, itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text('Hapus'),
                          value: 'delete',
                        ),
                      ];
                    }));
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: navigateToAddPage,
            backgroundColor: const Color(0xdd000000),
            label: Text('Tambah Tugas')));
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage('Hapus tugas gagal');
    }
  }

  Future<void> fetchTodo() async {
    final url = 'http://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
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

  void showErrorMessage(String s) {}
}