import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_management/provider/task_data_provider.dart';
import 'package:task_management/widgets/custom_container.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import '../../data/constants/app_colors.dart';
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
  // Add the _openAddTaskDialog method within the MainDashboardScreenState
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
     final taskCards =ref.watch(taskCardsProvider);
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
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start (left side)
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20), // Add padding to the container
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Drawer Icon
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white), // Menu icon
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Open the drawer when tapped
                    },
                  ),
                  // Center Text
                  Expanded(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: AppColors.lightGreyColor),
                          children: [
                            TextSpan(
                              text: 'Hi $userName\n', // Normal text for username
                              style: TextStyle(fontSize: 16), // Set a specific font size for username
                            ),
                            TextSpan(
                              text: '$date, $dayName', // Bold and larger text for date and day name
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Circle Avatar
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
              padding: const EdgeInsets.only(left: 40), // Align Progress text and container to the left
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
                    child: 
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                  
                    itemCount: taskCards.length,
                    itemBuilder: (context, index){
                      final task = taskCards[index];
                      
                      return Padding(padding: EdgeInsets.only(bottom: 20, right: 20),
                      child: InkWell(
                        onTap: () {
                          
                        },
                        child: CustomContainer(
                          progress: task.progress,
                             startDate:task.startDate,
                            taskText: task.taskText,
                             daysLeft: task.daysLeft,
                              avatarUrl: task.avatarUrl,
                              color: task.color,
                             ),
                      ));

                    }
                    ))
                 
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top:20 ),
              child: Text('Tasks',style: TextStyle(
                color: AppColors.lightGreyColor,
                fontSize: 18,
               fontWeight: FontWeight.bold)
                       ),
            ) ,
            const SizedBox(height: 10),
Expanded(
  child: Consumer(
    builder: (context, ref, child) {
      final tasks = ref.watch(tasksProvider);
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title, style: TextStyle(color: AppColors.lightGreyColor)),
            subtitle: Text(task.description, style: TextStyle(color: AppColors.lightGreyColor)),
            trailing: Text(DateFormat.yMMMd().format(task.startDate),style: TextStyle(color: AppColors.lightGreyColor),),
          );
        },
      );
    },
  ),
),
            
            ],
            
        )
        
        ),
         floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddTaskDialog(context),
        backgroundColor: AppColors.blueColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );

  }}

  