import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/enums/status_enum.dart';
import '../models/task_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to add a task to Firestore
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
  // Method to fetch only the tasks with 'inProgress' status from Firestore
Future<List<Task>> fetchInProgressTasks(String userId) async {
  final querySnapshot = await _db
      .collection('users')
      .doc(userId)
      .collection('tasks')
      .where('status', isEqualTo: TaskStatus.inProgress.toString()) // Filter for inProgress tasks
      .get();

  return querySnapshot.docs.map((doc) {
    return Task.fromMap(doc.data() as Map<String, dynamic>).copyWith(id: doc.id);
  }).toList();
}


  // Fetch tasks from Firestore
  Future<List<Task>> fetchTasks(String userId) async {
    final querySnapshot = await _db.collection('users').doc(userId).collection('tasks').get();
    return querySnapshot.docs.map((doc) {
      // Add document ID to the Task model
      return Task.fromMap(doc.data() as Map<String, dynamic>).copyWith(id: doc.id);
    }).toList();
  }

  // Update task status in Firestore
  Future<void> updateTaskStatus(Task task, String userId) async {
    final taskRef = _db.collection('users').doc(userId).collection('tasks').doc(task.id); // Use the document ID
    await taskRef.update({
      'status': task.status.toString(),
      'title': task.title,
      'description': task.description,
      'startDate': task.startDate,
      'progress': task.progress,
      'taskText': task.taskText,
      'daysLeft': task.daysLeft,
      'avatarUrl': task.avatarUrl,
      'color': task.color?.map((color) => color.value).toList(),
    });
  }

  // Delete a task from Firestore
  Future<void> deleteTask(String taskId, String userId) async {
    final taskRef = _db.collection('users').doc(userId).collection('tasks').doc(taskId);
    await taskRef.delete();
  }
}
