import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/activity_state_notifier.dart';
import '../../provider/task_data_provider.dart'; // Import the provider

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the selected task from the provider
    final task = ref.watch(selectedTaskProvider);

    return Scaffold(
      
      body: Container(
        width: double.infinity, // Ensure it covers the full width
        height: MediaQuery.of(context).size.height, // Ensure it covers the full height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(23, 27, 29, 1.0),
              Color.fromRGBO(46, 26, 83, 1.0),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView( // Add this for scrolling
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task != null) ...[
                  Text(
                    'Task Title: ${task.title}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Adjust color for better readability
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Description: ${task.description ?? 'No description'}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Adjust color for better readability
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Days Left: ${task.daysLeft ?? 0} days',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Adjust color for better readability
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Task Progress: ${task.progress?.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Adjust color for better readability
                    ),
                  ),
                ] 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
