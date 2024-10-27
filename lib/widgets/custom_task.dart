import 'package:flutter/material.dart';

class CustomTask extends StatelessWidget {
  final String taskText;
  final int daysLeft;
  final String avatarUrl; // Optional, for user avatar

  const CustomTask({
    Key? key,
    required this.taskText,
    required this.daysLeft,
    this.avatarUrl = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        leading: avatarUrl.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
              )
            : null,
        title: Text(taskText),
        subtitle: Text('Due in $daysLeft days'),
        trailing: Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }
}
