import 'package:cosmospedia/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

class AppTheme{
  static ThemeData get lightTheme {
      return ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primaryLight,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.primaryLight,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          color: AppColors.cardLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: AppTextStyles.h1,
          headlineMedium: AppTextStyles.h2,
          headlineSmall: AppTextStyles.h3,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          labelLarge: AppTextStyles.button,
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryLight,
          error: AppColors.error,
          surface: AppColors.surfaceLight,
        ),
      );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        color: AppColors.cardDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.h1.copyWith(color: AppColors.textPrimaryDark),
        headlineMedium: AppTextStyles.h2.copyWith(color: AppColors.textPrimaryDark),
        headlineSmall: AppTextStyles.h3.copyWith(color: AppColors.textPrimaryDark),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimaryDark),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimaryDark),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimaryDark),
        labelLarge: AppTextStyles.button.copyWith(color: AppColors.textPrimaryDark),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        error: AppColors.errorDark,
        surface: AppColors.surfaceDark,
      ),
    );
  }
}