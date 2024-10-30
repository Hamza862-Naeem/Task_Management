import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_management/provider/task_data_provider.dart';
import 'package:task_management/widgets/custom_container.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import '../../data/constants/app_colors.dart';
import '../../enums/status_enum.dart';
import '../../widgets/add_task_dialog.dart';

class MainDashboardScreen extends ConsumerStatefulWidget {
  MainDashboardScreen({super.key});

  @override
  ConsumerState<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends ConsumerState<MainDashboardScreen> {
  final String userName = 'Hamza';
  final TextEditingController searchController = TextEditingController();
  late Timer _timer;
  DateTime _currentTime = DateTime.now(); // Initialize current time
  
  @override
  void initState() {
    super.initState();
    // Start a timer to update the current time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now(); // Update the current time
      });
    });
  }
   
  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when disposing the widget
    super.dispose();
  }

  void _openAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format the current day name and date
    String dayName = DateFormat.EEEE('en_US').format(_currentTime); // Full day name
    String date = DateFormat.d().format(_currentTime); // Day of the month
    final taskCards = ref.watch(taskCardsProvider); // Get task cards
    final tasks = ref.watch(tasksProvider); // Get tasks

    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          // You can add items in the drawer here
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(23, 27, 29, 1.0),
              Color.fromRGBO(46, 26, 83, 1.0),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: AppColors.lightGreyColor),
                          children: [
                            TextSpan(
                              text: 'Hi $userName\n',
                              style: TextStyle(fontSize: 16),
                            ),
                            TextSpan(
                              text: '$date, $dayName',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.greenColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
              child: RoundedTextFormField(
                hintText: 'search',
                controller: searchController,
                icon: Icons.search,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress',
                    style: TextStyle(color: AppColors.lightGreyColor, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: taskCards.length,
                      itemBuilder: (context, index) {
                        final task = taskCards[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 20),
                          child: InkWell(
                            onTap: () {
                              // Handle tap if needed
                            },
                           child: CustomContainer(
  progress: task.progress ?? 0.0, // Provide a default value of 0.0 if null
  startDate: DateFormat('yyyy-MM-dd').format(task.startDate ?? DateTime.now()), // Format the date to string
  taskText: task.taskText ?? 'No task description', // Default string if taskText is null
  daysLeft: task.daysLeft ?? 0, // Default value of 0 if null
  avatarUrl: task.avatarUrl ?? '', // Default string if avatarUrl is null
  color: task.color ?? [Colors.blue], // Default color list if null
),

                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 20),
              child: Text(
                'Tasks',
                style: TextStyle(color: AppColors.lightGreyColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title ?? 'Untitled', style: TextStyle(color: AppColors.lightGreyColor)),
                    subtitle: Text(task.description ?? 'No description', style: TextStyle(color: AppColors.lightGreyColor)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(DateFormat.yMMMd().format(task.startDate ?? DateTime.now())),
                        IconButton(
                          onPressed: () {
                            ref.read(tasksProvider.notifier).toggleProgressStatus(index);
                          },
                          icon: Icon(
                            task.status == TaskStatus.pending ? Icons.play_circle : Icons.check_circle,
                            color: task.status == TaskStatus.inProgress ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddTaskDialog(context),
        backgroundColor: AppColors.blueColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
