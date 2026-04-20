import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../components/todo_card.dart';
import '../components/add_todo_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoProvider>().fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Taskly',
          style: TextStyle(
            color: colors.tertiary,
            fontWeight: FontWeight.w900,
            fontSize: 26,
          ),
        ),
        backgroundColor: colors.surface,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: colors.tertiary),
            );
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.errorMessage!,
                    style: TextStyle(color: colors.onSurface, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => provider.fetchTodos(),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.tertiary,
                      foregroundColor: colors.onTertiary,
                    ),
                  ),
                ],
              ),
            );
          }

          if (provider.todos.isEmpty) {
            return Center(
              child: Text(
                'Create your first task',
                style: TextStyle(color: colors.secondary, fontSize: 16),
              ),
            );
          }

          final todos = provider.todos;
          final completed = todos.where((t) => t.completed).length;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$completed / ${todos.length} completed',
                      style: TextStyle(color: colors.secondary, fontSize: 13),
                    ),
                    Text(
                      '${(completed / todos.length * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: colors.tertiary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: todos.length,
                  itemBuilder: (context, index) => TodoCard(todo: todos[index]),
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddTodoDialog(),
        ),
        backgroundColor: colors.tertiary,
        child: Icon(Icons.add, color: colors.onTertiary),
      ),
    );
  }
}
