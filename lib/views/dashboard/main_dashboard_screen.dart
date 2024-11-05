import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_management/provider/task_data_provider.dart';
import 'package:task_management/views/dashboard/progress_activity.dart';
import 'package:task_management/widgets/custom_container.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import '../../data/constants/app_colors.dart';
import '../../data/constants/progress_color.dart';
import '../../enums/status_enum.dart';
import '../../provider/activity_state_notifier.dart';
import '../../services/firebase_task_service.dart';
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

  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId != null) {
    // Fetch inProgress tasks for this user on screen load
    ref.read(tasksProvider.notifier).fetchInProgressTasks(userId);
  }

  // Timer to update the current time
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    setState(() {
      _currentTime = DateTime.now();
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
      return AddTaskDialog(
        onTaskAdded: (task) async {
          // Get the current user's ID
          final userId = FirebaseAuth.instance.currentUser?.uid;
          if (userId != null) {
            final firestoreService = FirestoreService();
            await firestoreService.addTask(task, userId);
          }
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    // Format the current day name and date
    String dayName = DateFormat.EEEE('en_US').format(_currentTime); // Full day name
    String date = DateFormat.d().format(_currentTime); // Day of the month
    final taskList = ref.watch(tasksProvider);
    final pendingTasks = taskList.where((task) => task.status == TaskStatus.pending).toList();
    final inProgressTasks = taskList.where((task) => task.status == TaskStatus.inProgress).toList();
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
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
            
            // Progress Section
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
                      itemCount: inProgressTasks.length,
                      itemBuilder: (context, index) {
                        final task = inProgressTasks[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 20),
                          child: GestureDetector(
                            // In the onTap method of the GestureDetector
                                      onTap: () {
                        // Update the selectedTaskProvider state with a null check
                       final selectedTaskNotifier = ref.read(selectedTaskProvider.notifier);
                      selectedTaskNotifier.state = task; // This line assumes you have a StateNotifierProvider for selectedTaskProvider
                      Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext) => const ActivityScreen(),
                                   ));
                                        },

                            child: CustomContainer(
                              progress: task.progress ?? 0.0,
                              startDate: DateFormat('yyyy-MM-dd').format(task.startDate ?? DateTime.now()),
                              taskText: task.title?? "",
                              daysLeft: task.daysLeft ?? 0,
                              avatarUrl: task.avatarUrl ?? '',
                              color: getProgressColor(task.progress ?? 0.0),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),

            // Tasks Section
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
    itemCount: pendingTasks.length,
    itemBuilder: (context, index) {
      final task = pendingTasks[index];
      return ListTile(
        title: Text(
          task.title ?? 'Untitled',
          style: TextStyle(color: AppColors.lightGreyColor),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description ?? 'No description',
              style: TextStyle(color: AppColors.lightGreyColor),
            ),
            // Add taskText and daysLeft here
            if (task.taskText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Task: ${task.taskText}',
                  style: TextStyle(color: AppColors.lightGreyColor),
                ),
              ),
            if (task.daysLeft != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Days Left: ${task.daysLeft} days',
                  style: TextStyle(color: AppColors.lightGreyColor),
                ),
              ),
          ],
        ),
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
                color: task.status == TaskStatus.inProgress ? Colors.green : Colors.grey,),),],),);},),)],),),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddTaskDialog(context),
        backgroundColor: AppColors.blueColor,
        child: const Icon(Icons.add, color: Colors.white), ),);  }}
