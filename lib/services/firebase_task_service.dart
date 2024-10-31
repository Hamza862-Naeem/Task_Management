import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/models/task_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTask(Task task, String userId) async {
    await _db.collection('users').doc(userId).collection('tasks').add({
      'title': task.title,
      'description': task.description,
      'startDate': task.startDate,
      'status': task.status.toString(),
      'progress': task.progress,
      'taskText': task.taskText,
      'daysLeft': task.daysLeft,
      'avatarUrl': task.avatarUrl,
      'color': task.color?.map((color) => color.value).toList(),
    });
  }

  // Additional methods for retrieving and managing tasks can be added here
}
