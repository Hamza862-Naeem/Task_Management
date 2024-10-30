import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../provider/task_data_provider.dart';
import '../enums/status_enum.dart'; // Ensure you import your TaskStatus enum

class AddTaskDialog extends ConsumerWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Task Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Task Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog on cancel
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _submitTask(ref, context); // Call the method to submit the task
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  void _submitTask(WidgetRef ref, BuildContext context) {
    // Validate the input fields
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    // Create a new Task object
    final newTask = Task(
      title: titleController.text,
      description: descriptionController.text,
      startDate: DateTime.now(), // Set the current date as start date
      status: TaskStatus.pending, // Use the appropriate status for new tasks
    );

    print('Creating task: ${newTask.title}, ${newTask.description}');

    // Use the notifier to add the new task
    ref.read(tasksProvider.notifier).addTask(newTask);
    Navigator.of(context).pop(); // Close the dialog after adding the task

    // Clear the text fields
    titleController.clear();
    descriptionController.clear();
  }
}
