
import 'package:flutter/material.dart';

import '../views/authentication/login/login.dart';
import '../views/authentication/login/main_screen.dart';
import '../views/authentication/registration/registration_screen.dart';
import '../views/dashboard/main_dashboard_screen.dart';
import '../views/dashboard/progress_activity.dart';

// Centralized routes class
class AppRoutes {
  // Route names as constants
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String main = '/main';
  static const String mainDashboard = '/mainDashboard';
  static const String activity = '/activity';

  // Route generation method (use this in MaterialApp)
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
       case mainDashboard:
         return MaterialPageRoute(builder: (_) =>  MainDashboardScreen());
       case activity:
         return MaterialPageRoute(builder: (_) => const ActivityScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
