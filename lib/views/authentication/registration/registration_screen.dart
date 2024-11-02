import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management/routes/routes.dart';
import 'package:task_management/utils/snackbar.dart';
import 'package:task_management/widgets/custom_button.dart';
import 'package:task_management/widgets/custom_textfield.dart';

import '../../../data/constants/app_colors.dart';
import '../../../provider/auth_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  
  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free resources
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    cityController.dispose();
    super.dispose();
  }
     
  void signUp() async {
    final authService = ref.read(firebaseAuthServiceProvider);
    final user = await authService.signUpWithEmail(
      emailController.text.trim(),
      passwordController.text.trim(),
      phoneController.text.trim(), // Include phone number
      cityController.text.trim(),  // Include city
      nameController.text.trim(),
    );
    if (user != null) {
      // ignore: use_build_context_synchronously
      showRegistrationSuccessSnackbar(context); 
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, AppRoutes.login);
    } else {
      // ignore: use_build_context_synchronously
      showRegistrationFailureSnackbar(context);
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
          title: Text('Sign Up',style: TextStyle(color: AppColors.lightGreyColor),),
          
        ),
      ),
      body: SafeArea(
      
           
            child:  Container(
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
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundedTextFormField(
                            controller: nameController,
                            hintText: 'Full Name',
                            icon: Icons.account_circle,
                          ),
                          const SizedBox(height: 20),
                          RoundedTextFormField(
                            controller: emailController,
                            hintText: 'Enter email',
                            icon: Icons.email,
                          ),
                          const SizedBox(height: 20),
                          RoundedTextFormField(
                            controller: passwordController,
                            hintText: 'Enter Password',
                            icon: Icons.lock,
                            isPasswordField: true,
                          ),
                          const SizedBox(height: 20),
                          RoundedTextFormField(
                            controller: phoneController,
                            hintText: 'Phone Number',
                            icon: Icons.phone_android,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                          ),
                          const SizedBox(height: 20),
                          RoundedTextFormField(
                            controller: cityController,
                            hintText: 'City',
                            icon: Icons.location_city_rounded,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                            ],
                          ),
                          const SizedBox(height: 30.0),
                          CustomButton(
                            onPressed: signUp,
                            color: AppColors.darkBlueColor,
                            text: "Sign Up",
                            icon: const Icon(Icons.login),
                            width: 200,
                            height: 50,
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
