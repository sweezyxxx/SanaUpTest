import 'package:flutter/material.dart';

enum Priority { low, medium, high }

extension PriorityExtension on Priority {
  String get label {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Middle';
      case Priority.high:
        return 'High';
    }
  }

  Color get color {
    switch (this) {
      case Priority.low:
        return const Color.fromARGB(255, 78, 76, 175);
      case Priority.medium:
        return const Color.fromARGB(255, 255, 160, 0);
      case Priority.high:
        return const Color.fromARGB(255, 239, 83, 80);
    }
  }
}

class TodoModel {
  final String id;
  final String title;
  final bool completed;
  final Priority priority;

  const TodoModel({
    required this.id,
    required this.title,
    required this.completed,
    required this.priority,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    bool? completed,
    Priority? priority,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json, Priority priority) {
    return TodoModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      completed: json['completed'] as bool,
      priority: priority,
    );
  }
}
