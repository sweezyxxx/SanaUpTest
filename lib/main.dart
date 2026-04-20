import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanaup_test/theme/theme.dart';
import 'providers/todo_provider.dart';
import 'services/todo_service.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider(TodoService()),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const HomePage(),
    );
  }
}
