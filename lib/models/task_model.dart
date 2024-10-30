import 'dart:ui';
import '../enums/status_enum.dart';

class Task {
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
}
