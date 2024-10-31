// lib/data/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/services/firebase_task_service.dart';
import '../enums/status_enum.dart';
import '../models/task_model.dart';



final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());
class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);
  final FirestoreService _firestoreService = FirestoreService();
  Future<void> addTask(Task task, String userId) async{
    await _firestoreService.addTask(task, userId);
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
