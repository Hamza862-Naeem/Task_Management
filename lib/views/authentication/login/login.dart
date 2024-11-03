// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management/views/authentication/registration/registration_screen.dart';
import 'package:task_management/widgets/custom_textfield.dart';

import '../../../data/constants/app_colors.dart';
import '../../../provider/auth_provider.dart';
import '../../../routes/routes.dart';
import '../../../utils/snackbar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    final authService = ref.read(firebaseAuthServiceProvider);
    final user = await authService.signInWithEmail(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (user != null) {
        // Show success snackbar
        showLoginSuccessSnackbar(context);
       
        Navigator.pushNamed(context, AppRoutes.mainDashboard);
      } else {
        // Show error snackbar
        showLoginFailureSnackbar(context);
        print('Failed to sign in');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: PreferredSize(
  preferredSize: const Size.fromHeight(50),
  child: AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(23, 27, 29, 1.0),
            Color.fromRGBO(46, 26, 83, 1.0),
          ],
        ),
      ),
    ),
    title: Text(
      'Login',
      style: TextStyle(color: AppColors.lightGreyColor),
    ),
    
    iconTheme: IconThemeData(
      color: AppColors.lightGreyColor, // Set back icon color
    ),
  ),
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
            child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                  Container(
              height: 300,
              width: double.infinity,
              child: Lottie.asset('assets/animation/new.json'),
            ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 50 ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedTextFormField(
                        hintText: 'Enter email',
                        icon: Icons.email,
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      RoundedTextFormField(
                        hintText: 'Enter Password',
                        isPasswordField: true,
                        icon: Icons.lock,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: login, // Use the login function
                        child: const Text('Login'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: AppColors.tealColor),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: const Text('SignUp'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
