import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/models/task_model.dart';

class SelectedTaskNotifier extends StateNotifier<Task?> {
  SelectedTaskNotifier() : super(null);

  void selectTask(Task? task) {
    state = task; // Update the selected task
  }
}

// Define the provider
final selectedTaskProvider = StateNotifierProvider<SelectedTaskNotifier, Task?>((ref) {
  return SelectedTaskNotifier();
});
