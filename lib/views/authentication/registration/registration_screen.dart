import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/widgets/custom_button.dart';
import 'package:task_management/widgets/custom_textfield.dart';

import '../../../data/constants/app_colors.dart';
import '../../../provider/auth_provider.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(firebaseAuthServiceProvider);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    void signUp() async {
      final user = await authService.signUpWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
        phoneController.text.trim(), // Include phone number
        cityController.text.trim(),  // Include city
        nameController.text.trim(),
      );
      if (user != null) {
        // Navigate to the next screen on successful signup
        print('User signed up: ${user.email}');
      } else {
        // Show error message
        print('Failed to sign up');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(23, 27, 29, 1.0),
                Color.fromRGBO(46, 26, 83, 1.0),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   RoundedTextFormField(
                    controller: nameController, // Added phone controller
                    hintText: 'Full Name',
                    icon: Icons.account_circle,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11), // Phone number limit
                    ],
                  ),
                   const SizedBox(height: 20),
                  RoundedTextFormField(
                    controller: emailController, // Added email controller
                    hintText: 'Enter email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  RoundedTextFormField(
                    controller: passwordController, // Added password controller
                    hintText: 'Enter Password',
                    icon: Icons.lock,
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 20),
                  RoundedTextFormField(
                    controller: phoneController, // Added phone controller
                    hintText: 'Phone Number',
                    icon: Icons.phone_android,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11), // Phone number limit
                    ],
                  ),
                  const SizedBox(height: 20),
                  RoundedTextFormField(
                    controller: cityController, // Added city controller
                    hintText: 'City',
                    icon: Icons.location_city_rounded,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  CustomButton(
                    onPressed: signUp, // Updated to call signUp method
                    color: AppColors.darkBlueColor,
                    text: "Sign Up",
                    icon: const Icon(Icons.login),
                    width: 250,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
