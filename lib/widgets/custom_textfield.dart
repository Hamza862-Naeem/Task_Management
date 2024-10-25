import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/textnotifier_provider.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

class RoundedTextFormField extends ConsumerWidget {
  final String hintText;
  final IconData? icon;  // Leading icon (optional)
  final bool isPasswordField;
  final TextInputType? keyboardType;  // Added for keyboard type
  final List<TextInputFormatter>? inputFormatters;  // Added for input restrictions
  final TextEditingController controller;

  const RoundedTextFormField({
    Key? key,
    required this.hintText,
    this.icon,
    this.isPasswordField = false,
    this.keyboardType, // Initialize keyboardType
    this.inputFormatters, // Initialize inputFormatters
    required this.controller, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textNotifier = ref.read(textProvider.notifier);
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);

    return TextFormField(
      controller: controller,
      style: TextStyle(color: const Color(0xFFECEFF1)), // Consistent styling
      onChanged: (value) {
        textNotifier.updateText(value);
      },
      obscureText: isPasswordField && !isPasswordVisible,
      keyboardType: keyboardType,  // Set the keyboard type
      inputFormatters: inputFormatters, // Set the input restrictions
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: const Color(0xFFB0BEC5)),
        filled: true,
        fillColor: const Color(0xFF2D2D37).withOpacity(0.8),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Color(0xFF7C4DFF), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Color(0xFF616161), width: 1.0),
        ),
        prefixIcon: icon != null ? Icon(icon, color: const Color(0xFFB0BEC5)) : null,
        suffixIcon: isPasswordField
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFFB0BEC5),
                ),
                onPressed: () {
                  ref.read(passwordVisibilityProvider.notifier).state =
                      !isPasswordVisible;
                },
              )
            : null,
      ),
    );
  }
}
