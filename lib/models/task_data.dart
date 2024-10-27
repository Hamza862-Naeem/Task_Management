import 'package:flutter/material.dart';
import 'card_model.dart'; // Import the TaskCardModel

// Function to get colors based on progress
List<Color> getGradientColors(double progress) {
  if (progress < 0.25) {
    // Red gradient for progress below 25%
    return [
      Colors.red.shade700,
      Colors.red.shade400,
    ];
  } else if (progress < 0.5) {
    // Green gradient for progress between 25% and 50%
    return [
      Color.fromRGBO(39, 149, 20, 1),
      Color.fromRGBO(27, 142, 94, 1),
      Color.fromRGBO(23, 188, 34, 1),
      Color.fromRGBO(25, 144, 81, 1),
      Color.fromRGBO(48, 133, 91, 1),
      Color.fromRGBO(71, 142, 50, 1),
      Color.fromRGBO(44, 121, 75, 1),
    ];
  } else if (progress < 0.9) {
    // Blue gradient for progress between 50% and 90%
    return [
      Color.fromRGBO(50, 88, 149, 1.0),
      Color.fromRGBO(47, 73, 142, 1.0),
      Color.fromRGBO(43, 59, 188, 1.0),
      Color.fromRGBO(45, 65, 144, 1.0),
      Color.fromRGBO(48, 74, 133, 1.0),
      Color.fromRGBO(50, 82, 142, 1.0),
      Color.fromRGBO(44, 63, 121, 1.0),
    ];
  } else {
    // Purple gradient for progress above 90%
    return [
      Colors.purple.shade700,
      Colors.purple.shade400,
    ];
  }
}

// Updated TaskCardModel list
final List<TaskCardModel> taskCards = [
  TaskCardModel(
    progress: 0.9,
    startDate: '12 June 2024',
    taskText: 'Web Design',
    daysLeft: 2,
    avatarUrl: '',
    color: getGradientColors(0.9), // Use actual progress value
  ),
  TaskCardModel(
    progress: 0.6,
    startDate: '15 May 2024',
    taskText: 'App Development',
    daysLeft: 5,
    avatarUrl: '',
    color: getGradientColors(0.6), // Use actual progress value
  ),
  TaskCardModel(
    progress: 0.3,
    startDate: '22 June 2024',
    taskText: 'Bike Design',
    daysLeft: 2,
    avatarUrl: '',
    color: getGradientColors(0.3), // Use actual progress value
  ),
  TaskCardModel(
    progress: 0.4,
    startDate: '19 May 2024',
    taskText: 'Car Development',
    daysLeft: 5,
    avatarUrl: '',
    color: getGradientColors(0.4), // Use actual progress value
  ),
  TaskCardModel(
    progress: 0.5,
    startDate: '22 June 2024',
    taskText: 'House Design',
    daysLeft: 2,
    avatarUrl: '',
    color: getGradientColors(0.5), // Use actual progress value
  ),
  TaskCardModel(
    progress: 0.2,
    startDate: '19 May 2024',
    taskText: 'Bus Development',
    daysLeft: 5,
    avatarUrl: '',
    color: getGradientColors(0.2), // Use actual progress value
  ),
  TaskCardModel(
    progress: 0.1,
    startDate: '22 June 2024',
    taskText: 'Cardio',
    daysLeft: 2,
    avatarUrl: '',
    color: getGradientColors(0.1), // Use actual progress value
  ),
  TaskCardModel(
    progress: 0.8,
    startDate: '19 May 2024',
    taskText: 'Charity',
    daysLeft: 5,
    avatarUrl: '',
    color: getGradientColors(0.8), // Use actual progress value
  ),
];

// No duplication of task details here, ensure each task has unique data
