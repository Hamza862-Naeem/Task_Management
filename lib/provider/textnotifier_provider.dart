import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notifier to manage text state
class TextNotifier extends StateNotifier<String> {
  TextNotifier() : super('');

  // Method to update the text
  void updateText(String newText) {
    state = newText;
  }

  // Method to clear the text
  void clearText() {
    state = '';
  }

  // Method to reset text to default value
  void resetText([String defaultText = '']) {
    state = defaultText;
  }
}

// Provider for the TextNotifier
final textProvider = StateNotifierProvider<TextNotifier, String>((ref) {
  return TextNotifier();
});
