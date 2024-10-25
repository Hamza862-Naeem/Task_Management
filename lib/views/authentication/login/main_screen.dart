// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/widgets/custom_button.dart';

import 'login.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(23, 27, 29, 1.0),
              Color.fromRGBO(46, 26, 83, 1.0),

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
                padding:
                    const EdgeInsets.only(left: 50.0, right: 50.0,),
                child: RichText(
                    textAlign: TextAlign.start,
                    text: const TextSpan(children: [
                      TextSpan(
                        text: 'Management everything\n', // Add a line break here
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      TextSpan(
                        text: 'with one hand', // Final part of the text
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ])

                    // Optional: add a welcome message
                    ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              // Buttons at the bottom
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), // Optional: add padding around buttons
                child: Column(
                  children: [
                    CustomButton(
                      onPressed: () {
                        // ignore: non_constant_identifier_names
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext) =>
                                    const LoginScreen ()));
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
                          onPressed: () {},
                          color: Colors.transparent,
                          text: "Facebook",
                          icon: Image.asset(
                            'assets/images/fb.png',
                            width: 24, // Adjust the width of the image
                            height: 24, // Adjust the height of the image
                          ),
                          height: 50, // Increased height for better appearance
                          width: 150, // Adjust width to fit your design
                        ),
                        CustomButton(
                          onPressed: () {},
                          color: Colors.transparent,
                          text: "Google",
                          icon: Image.asset(
                            'assets/images/google_logo.webp', // Path to the image asset
                            width: 24,
                            height: 24,
                          ),
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
