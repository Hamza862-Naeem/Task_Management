import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/status_enum.dart';
import '../models/task_model.dart';
import '../provider/auth_provider.dart';
import '../provider/task_data_provider.dart';

class AddTaskDialog extends ConsumerStatefulWidget {
  final Function(Task) onTaskAdded; // Callback for task addition

  AddTaskDialog({Key? key, required this.onTaskAdded}) : super(key: key);

  @override
  ConsumerState<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController taskTextController = TextEditingController();
  final TextEditingController daysLeftController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Task Title'),
            maxLines: 1,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Task Description'),
            maxLines: 1,
          ),
          TextField(
            controller: taskTextController,
            decoration: const InputDecoration(labelText: 'Enter the text here'),
            maxLines: 2,
          ),
          TextField(
            controller: daysLeftController,
            decoration: const InputDecoration(labelText: 'Enter the Duration (in days)'),
            keyboardType: TextInputType.number,
            maxLines: 1,
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

  void _submitTask(WidgetRef ref, BuildContext context) async {
    // Validate the input fields
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    // Try to parse daysLeft; show an error if parsing fails
    final int? daysLeft = int.tryParse(daysLeftController.text);
    if (daysLeft == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number for days left')),
      );
      return;
    }

    // Create a new Task object
    final newTask = Task(
      title: titleController.text,
      description: descriptionController.text,
      startDate: DateTime.now(), // Set the current date as start date
      status: TaskStatus.pending, // Use the appropriate status for new tasks
      taskText: taskTextController.text,
      daysLeft: daysLeft, // Correctly assign daysLeft
    );

    print('Creating task: ${newTask.title}, ${newTask.description}');

    // Get the user ID (handle AsyncValue)
    final userAsync = ref.watch(authStateProvider);
    String userId = userAsync.when(
      data: (user) => user?.uid ?? '', // Extract the UID if user exists
      loading: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loading user...')),
        );
        return '';
      },
      error: (err, stack) {
        // Handle error state (log it, show message, etc.)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching user: $err')),
        );
        return '';
      },
    );

    // Check if userId is empty
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not found. Task cannot be added.')),
      );
      return;
    }

    // Use the notifier to add the new task
    await ref.read(tasksProvider.notifier).addTask(newTask, userId); // Pass userId to the addTask method

    Navigator.of(context).pop(); // Close the dialog after adding the task

    // Clear the text fields
    titleController.clear();
    descriptionController.clear();
    taskTextController.clear();
    daysLeftController.clear();
  }
}
