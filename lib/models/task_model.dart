import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../enums/status_enum.dart';

class Task {
  final String? id; // Optional property for Firestore document ID
  final String? title;
  final String? description; // Optional
  final DateTime? startDate; // Required
  final TaskStatus? status; // Using enum to represent task state
  final double? progress; // Optional
  final String? taskText; // Optional
  final int? daysLeft; // Optional
  final String? avatarUrl; // Optional
  final List<Color>? color; // Optional

  Task({
    this.id, // Include id in the constructor
    this.title,
    this.description,
    this.startDate,
    this.status,
    this.progress,
    this.taskText,
    this.daysLeft,
    this.avatarUrl,
    this.color,
  });

  // CopyWith method
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    TaskStatus? status,
    double? progress,
    String? taskText,
    int? daysLeft,
    String? avatarUrl,
    List<Color>? color,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      taskText: taskText ?? this.taskText,
      daysLeft: daysLeft ?? this.daysLeft,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      color: color ?? this.color,
    );
  }

  // Factory method to create a Task from a Map (Firestore document)
  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      id: data['id'] as String?, // Retrieve the ID from the map if available
      title: data['title'] as String?,
      description: data['description'] as String?,
      startDate: data['startDate'] != null 
          ? (data['startDate'] as Timestamp).toDate()
          : null,
      status: data['status'] != null 
          ? TaskStatus.values.firstWhere((status) => status.toString() == data['status'])
          : null,
      progress: (data['progress'] as num?)?.toDouble(),
      taskText: data['taskText'] as String?,
      daysLeft: data['daysLeft'] as int?,
      avatarUrl: data['avatarUrl'] as String?,
      color: (data['color'] as List<dynamic>?)
          ?.map((colorValue) => Color(colorValue as int))
          .toList(),
    );
  }

  // Convert Task instance to Map (for storing in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include id when converting to Map (optional)
      'title': title,
      'description': description,
      'startDate': startDate,
      'status': status?.toString(),
      'progress': progress,
      'taskText': taskText,
      'daysLeft': daysLeft,
      'avatarUrl': avatarUrl,
      'color': color?.map((c) => c.value).toList(),
    };
  }
}
