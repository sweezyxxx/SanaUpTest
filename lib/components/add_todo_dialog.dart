import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _controller = TextEditingController();
  Priority _selectedPriority = Priority.low;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<TodoProvider>().addTodo(text, _selectedPriority);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AlertDialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text('New Task', style: TextStyle(color: colors.onSurface)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            cursorColor: colors.secondary.withValues(alpha: 0.4),
            controller: _controller,
            autofocus: true,
            style: TextStyle(color: colors.onSurface),
            decoration: InputDecoration(
              hintText: 'Task name',
              hintStyle: TextStyle(color: colors.secondary),
              filled: true,
              fillColor: colors.primary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: Priority.values.map((p) {
              final selected = _selectedPriority == p;
              return Expanded(
                child: ChoiceChip(
                  showCheckmark: false,
                  label: Text(p.label, style: const TextStyle(fontSize: 11)),
                  selected: selected,
                  selectedColor: p.color.withValues(alpha: 0.3),
                  backgroundColor: colors.primary,
                  labelStyle: TextStyle(
                    color: selected ? p.color : colors.secondary,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  ),
                  side: BorderSide(
                    color: selected ? p.color : Colors.transparent,
                  ),
                  onSelected: (_) => setState(() => _selectedPriority = p),
                ),
              );
            }).toList(),
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: colors.secondary)),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.tertiary,
            foregroundColor: colors.onTertiary,
          ),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
