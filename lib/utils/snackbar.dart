// lib/utils/snackbar_util.dart

import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green, // Change color based on error or success
      duration: const Duration(seconds: 3),
    ),
  );
}

// Usage examples:
void showLoginSuccessSnackbar(BuildContext context) {
  showSnackbar(context, 'Login successful!');
}

void showLoginFailureSnackbar(BuildContext context) {
  showSnackbar(context, 'Failed to login: Account does not exist.', isError: true);
}

void showRegistrationSuccessSnackbar(BuildContext context) {
  showSnackbar(context, 'Registration successful!');
}

void showRegistrationFailureSnackbar(BuildContext context, ) {
  showSnackbar(context,'Failed to login  :This email has already has account', isError: true); // Use the general snackbar function
}
