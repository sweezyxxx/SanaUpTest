import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';

class TodoProvider extends ChangeNotifier {
  final TodoService _service;
  final _uuid = const Uuid();

  List<TodoModel> _todos = [];
  bool _isLoading = false;
  String? _errorMessage;

  TodoProvider(this._service);

  List<TodoModel> get todos => _todos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTodos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _todos = await _service.fetchTodos();
    } catch (e) {
      _errorMessage = 'No internet connection';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addTodo(String title, Priority priority) {
    final newTodo = TodoModel(
      id: _uuid.v4(),
      title: title,
      completed: false,
      priority: priority,
    );
    _todos = [newTodo, ..._todos];
    notifyListeners();
  }

  void toggleTodo(String id) {
    _todos = [
      for (final todo in _todos)
        if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo,
    ];
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todos = _todos.where((t) => t.id != id).toList();
    notifyListeners();
  }
}
