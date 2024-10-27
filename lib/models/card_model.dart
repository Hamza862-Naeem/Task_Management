import 'dart:ui';

class TaskCardModel {
  final double progress;
  final String startDate;
  final String taskText;
  final int daysLeft;
  final String avatarUrl;
   final List<Color> color;

  TaskCardModel({
    required this.progress,
    required this.startDate,
    required this.taskText,
    required this.daysLeft,
    required this.avatarUrl,
    required this.color,
    
  });
}
