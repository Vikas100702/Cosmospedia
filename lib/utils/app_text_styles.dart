import 'package:flutter/material.dart';

class AppTextStyles {
  // Headings
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -1.5,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
  );

  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    letterSpacing: 0.4,
  );

  // Button Text
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  );

  // Caption Text
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    letterSpacing: 0.4,
  );
}