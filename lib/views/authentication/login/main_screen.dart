import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/widgets/custom_button.dart';

import '../../../data/constants/app_colors.dart';
import 'login_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            colors: [
              const Color.fromRGBO(23, 27, 29, 1.0), // rgb(23, 27, 29)
        const Color.fromRGBO(46, 26, 83, 1.0), // rgb(46, 26, 83)
              // Colors.grey.shade900,
              // Colors.deepPurpleAccent.shade700,
            ],
          ),
        ),
        child: Center(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              
              // You can keep this padding if you want some space at the top
             Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 100  ),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: const TextSpan(
                  children:[
                    const TextSpan(
          text: 'Manage everything\n', // Add a line break here
          style: TextStyle(fontSize: 28,
          fontWeight: FontWeight.bold,
           color: Colors.white),
        ),
       
        TextSpan(
          text: 'with one hand', // Final part of the text
          style: TextStyle(fontSize: 28,
          fontWeight: FontWeight.bold,
           color: Colors.white),
        ),
                  ]
                  )
                  
                  // Optional: add a welcome message
                ),
              ),
              const SizedBox(height: 20.0,),
               
              // Buttons at the bottom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Optional: add padding around buttons
                child: Column(
                  children: [
                    CustomButton(
                      onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (BuildContext) => const LoginScreen())
                         );
                      },
                      color: Colors.lightBlue,
                      text: "Continue with email",
                      width: double.infinity,
                      height: 60,
                      icon: const Icon(Icons.email_rounded),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          onPressed: () {
                           
                          },
                          color: Colors.transparent,
                          text: "Facebook",
                          icon:  const Icon(Icons.login,color: Colors.white,),
                          height: 50, // Increased height for better appearance
                          width: 150, // Adjust width to fit your design
                        ),
                                              CustomButton(
                          onPressed: () {

                          },
                          color: Colors.transparent,
                          text: "Google",
                          icon: const Icon(Icons.golf_course),
                          height: 50, // Increased height for better appearance
                          width: 150, // Adjust width to fit your design
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0), // Optional space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
