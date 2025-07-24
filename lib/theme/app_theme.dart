import 'package:flutter/material.dart';

class AppTheme {
  static const double padding = 16.0;
  static const double spacing = 16.0;
  static const double minTouchSize = 48.0;

  static const Color primaryColor = Colors.green;
  static const Color errorColor = Colors.redAccent;

  static ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      error: errorColor,
    ),
    useMaterial3: true,
  );
}
class AppColors {
  static const primary = Color(0xFF4CAF50);
  static const error = Color(0xFFE53935);

  static Color getTransportColor(String mode) {
    switch (mode) {
      case 'driving': return Colors.blue;
      case 'bicycling': return Colors.green;
      case 'transit': return Colors.purple;
      case 'walking': return Colors.orange;
      default: return Colors.grey;
    }
  }
}

class AppIcons {
  static IconData getTransportIcon(String mode) {
    switch (mode) {
      case 'driving': return Icons.directions_car;
      case 'bicycling': return Icons.directions_bike;
      case 'transit': return Icons.directions_transit;
      case 'walking': return Icons.directions_walk;
      default: return Icons.directions;
    }
  }
}

class AppPadding {
  static const horizontal = 16.0;
  static const vertical = 8.0;
  static const betweenItems = 16.0;
}