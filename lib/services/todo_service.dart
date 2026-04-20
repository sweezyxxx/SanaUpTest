import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodoService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/todos';
  final _random = Random();

  Priority _randomPriority() {
    final values = Priority.values;
    return values[_random.nextInt(values.length)];
  }

  Future<List<TodoModel>> fetchTodos() async {
    final response = await http
        .get(Uri.parse('$_baseUrl?_limit=15'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map(
            (json) => TodoModel.fromJson(
              json as Map<String, dynamic>,
              _randomPriority(),
            ),
          )
          .toList();
    } else {
      throw Exception('Failed to load todos (${response.statusCode})');
    }
  }
}
