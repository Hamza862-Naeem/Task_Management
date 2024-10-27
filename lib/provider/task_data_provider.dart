// lib/data/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/card_model.dart';
import '../models/task_data.dart';


// Create a provider for the task cards
final taskCardsProvider = Provider<List<TaskCardModel>>((ref) {
  return taskCards; // Return the list of task cards from your task_data.dart
});
