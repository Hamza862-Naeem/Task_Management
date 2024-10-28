// lib/data/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/card_model.dart';
import '../models/task_data.dart';
import '../models/task_model.dart';


// Create a provider for the task cards
final taskCardsProvider = Provider<List<TaskCardModel>>((ref) {
  return taskCards; // Return the list of task cards from your task_data.dart
});

final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }
}
