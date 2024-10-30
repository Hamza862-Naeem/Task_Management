import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final double? progress; // Progress value from 0 to 1
  final String? startDate; // Start date for the task
  final String? taskText; // Description or title of the task
  final int? daysLeft; // Number of days left for the task
  final String? avatarUrl; // URL of the avatar image
  final List<Color>? color;

  const CustomContainer({
    super.key,
    this.height = 220,
    this.width = 150,
     this.progress,
     this.startDate,
     this.taskText,
     this.daysLeft,
     this.avatarUrl,
     this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient:  LinearGradient(
          colors: color!,
          // colors: [
          //   Color.fromRGBO(50, 88, 149, 1.0),
          //   Color.fromRGBO(47, 73, 142, 1.0),
          //   Color.fromRGBO(43, 59, 188, 1.0),
          //   Color.fromRGBO(45, 65, 144, 1.0),
          //   Color.fromRGBO(48, 74, 133, 1.0),
          //   Color.fromRGBO(50, 82, 142, 1.0),
          //   Color.fromRGBO(44, 63, 121, 1.0),
          // ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: const Offset(-5, -5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Inner light overlay for added depth
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Text(
              startDate!,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                taskText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Centered Progress Bar
              Container(
                height: 10,
                width: width - 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3), // Background for the progress bar
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: progress, // Fill according to progress
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent, // Color for the progress
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${(progress! * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Text(
              '$daysLeft days left',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(avatarUrl!),
            ),
          ),
        ],
      ),
    );
  }
}
