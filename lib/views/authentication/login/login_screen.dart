

import 'package:flutter/material.dart';
import 'package:task_management/widgets/custom_button.dart';

import '../../../data/constants/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login '),
      ),
      body: SafeArea(child: Column(
        children: [
          
          TextField(
            decoration: InputDecoration(
              
            ),
          ),
           SizedBox(height: 20.0),
          TextField(),
          SizedBox(height: 20.0),
          CustomButton(onPressed: (){}, color: AppColors.darkBlueColor, text: "Login", icon: Icon(Icons.login), width: 250, height: 50)
        ],
      )
      ),
    );
  }
}