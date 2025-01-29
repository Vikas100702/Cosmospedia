import 'package:flutter/material.dart';

class AppColors {
  static const Color transparentColor = Colors.transparent;
  // Primary Colors
  static const Color primaryLight = Color(0xFF1E88E5);  // Blue 600
  static const Color primaryDark = Color(0xFF1565C0);   // Blue 800

  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);

  // Surface Colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  //Drawer header
  static const Color drawerHeader = Color(0xFF17203A);
  static const Color drawerHeaderGradient = Color(0xFF2C3E50);

  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2D2D2D);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFF9E9E9E);

  // Error Colors
  static const Color error = Color(0xFFF44336);
  static const Color errorDark = Color(0xFFCF6679);

  // Success Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successDark = Color(0xFF81C784);

  // Warning Colors
  static const Color warning = Color(0xFFFFA000);
  static const Color warningDark = Color(0xFFFFB74D);

  // Info Colors
  static const Color info = Color(0xFF2196F3);
  static const Color infoDark = Color(0xFF64B5F6);

  //Bottom navigation bar colors
  static  Color bottomNavColor = const Color(0xFFFFFFFF).withOpacity(0.2);

  //News Screen Colors
  static List<Color> newsScreenGradient = [
    AppColors.transparentColor,
    AppColors.backgroundDark.withOpacity(0.3),
    AppColors.backgroundDark.withOpacity(0.8),
    AppColors.backgroundDark.withOpacity(0.95),
  ];
  static List<Color> imagePreviewButtonGradient = [
    const Color(0xFF18FFFF).withOpacity(0.4),
    const Color(0xFF448AFF).withOpacity(0.4),
  ];
  static Color newsCalendarIconColor = const Color(0xFF18FFFF);
  static Color newsRocketIconColor = const Color(0xFFFFFFFF);

  //Image Preview Colors
  static List<Color> imagePreviewGradient = [
    AppColors.backgroundDark.withOpacity(0.7),
    AppColors.transparentColor
  ];

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF1E88E5),
    Color(0xFF1565C0),
  ];

  static const List<Color> darkGradient = [
    Color(0xFF2D2D2D),
    Color(0xFF1E1E1E),
  ];
}