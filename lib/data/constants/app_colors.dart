import 'package:flutter/material.dart';

class AppColors {
  // Basic Colors by Name
  static const Color redColor = Colors.red;         // Red color
  static const Color greenColor = Colors.green;     // Green color
  static const Color blueColor = Colors.blue;       // Blue color
  static const Color yellowColor = Colors.yellow;   // Yellow color
  static const Color orangeColor = Colors.orange;   // Orange color
  static const Color purpleColor = Colors.purple;   // Purple color
  static const Color whiteColor = Colors.white;     // White color
  static const Color blackColor = Colors.black;     // Black color
  static const Color greyColor = Colors.grey;       // Grey color
  static const Color tealColor = Colors.teal;       // Teal color

  // Shades or Variants
  static const Color lightGreenColor = Colors.lightGreen;   // Light green color
  static const Color darkBlueColor = Colors.blueAccent;     // Dark blue accent color
  static  Color lightGreyColor = Colors.grey[300]!;    // Light grey color
  static Color darkRedColor = Colors.red[900]!;       // Dark red color

  // Multi-Color Sets (for gradients, themes, etc.)
  static const List<Color> successColors = [greenColor, lightGreenColor]; // For success indicators
  static const List<Color> warningColors = [orangeColor, yellowColor];    // For warnings
  static List<Color> errorColors = [redColor, darkRedColor];        // For errors
  static const List<Color> infoColors = [blueColor, darkBlueColor];       // For info messages

  // A set of colors to use for status indicators (success, warning, error)
  static  Set<Color> statusColors = {greenColor, orangeColor, redColor};

  // Gradient colors for UI elements
  static const List<Color> buttonGradient = [purpleColor, blueColor];      // Gradient for buttons
  static  List<Color> backgroundGradient = [lightGreyColor, whiteColor]; // Gradient for background

  // Custom Color Methods for flexibility
  static Color getColorByName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return redColor;
      case 'green':
        return greenColor;
      case 'blue':
        return blueColor;
      case 'yellow':
        return yellowColor;
      case 'orange':
        return orangeColor;
      case 'purple':
        return purpleColor;
      case 'white':
        return whiteColor;
      case 'black':
        return blackColor;
      case 'grey':
        return greyColor;
      case 'teal':
        return tealColor;
      default:
        return blackColor; // Default to black if color name not found
    }
  }
}
