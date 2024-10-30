// lib/data/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../enums/status_enum.dart';
import '../models/card_model.dart';
import '../models/task_data.dart';
import '../models/task_model.dart';

// Create a provider for the task cards
final taskCardsProvider = Provider<List<Task>>((ref) {
  return taskCards; // Return the list of task cards from your task_data.dart
});

final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());
final progressTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksProvider);
  return tasks.where((task) => task.status == TaskStatus.inProgress).toList(); // Filter for in-progress tasks
});


class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(Task task) {
    print('Adding task: ${task.title}');
    state = [...state, task];
    print('Current tasks: $state');
  }

  // Define toggleProgressStatus to toggle the status of the task
  void toggleProgressStatus(int index) {
    // Log the current status of the task
    print('Toggling status for task at index $index: ${state[index].status}');

    final currentTask = state[index];
    Task updatedTask;

    if (currentTask.status == TaskStatus.pending) {
      updatedTask = currentTask.copyWith(status: TaskStatus.inProgress);
      print('Task at index $index is now in progress');
    } else {
      updatedTask = currentTask.copyWith(status: TaskStatus.pending);
      print('Task at index $index is now pending');
    }

    // Update the state
    state[index] = updatedTask;
  }
}
