import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/firebase_options.dart';
import 'package:task_management/views/authentication/login/main_screen.dart';
import 'package:task_management/views/authentication/registration/registration_screen.dart';

import 'routes/routes.dart';
import 'views/authentication/login/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(  
       debugShowCheckedModeBanner: false,
      title: 'Task Management App',
      
      // Provide initial route or main screen directly
      initialRoute: AppRoutes.mainDashboard,
      
      // Define your route generation function here
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
