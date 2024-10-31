// lib/data/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../enums/status_enum.dart';
import '../models/task_model.dart';



final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());
class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(Task task) {
   
    state = [...state, task];
    
  }

  void toggleProgressStatus(int index) {
    
    final currentTask = state[index];
    Task updatedTask;

    if (currentTask.status == TaskStatus.pending) {
      updatedTask = currentTask.copyWith(status: TaskStatus.inProgress);
     
    } else {
      updatedTask = currentTask.copyWith(status: TaskStatus.pending);
    
    }

        state[index] = updatedTask;
  }
}
