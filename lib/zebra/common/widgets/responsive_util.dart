// responsive_util.dart
import 'package:flutter/widgets.dart';

class ResponsiveUtil {
  // Method to get the screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Method to get the screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Example: Method to adjust font size based on screen width
  static double fontSize(BuildContext context, double baseFontSize) {
    // Adjust the base font size based on the screen width
    return baseFontSize * screenWidth(context) / 375.0; // You can adjust the base value as needed
  }
}
