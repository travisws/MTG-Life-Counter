import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background - pure black
  static const Color background = Color(0xFF000000);
  static const Color overlay = Color(0xCC000000);

  // Accent colors - purple only
  static const Color purple = Color(0xFF6B5B95);
  static const Color purpleLight = Color(0xFF8B7BB5);
  static const Color purpleDark = Color(0xFF4A3D6F);

  // Border colors
  static const Color border = Color(0xFF6B5B95);

  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B0B0);

  // Panel colors for players - different shades of purple
  static const List<Color> playerColors = [
    Color(0xFF6B5B95),
    Color(0xFF8B7BB5),
    Color(0xFF4A3D6F),
    Color(0xFF9F8FBF),
  ];
}

class AppTextStyles {
  AppTextStyles._();

  // Section headers: uppercase, medium weight, tracking slightly wider
  static const TextStyle sectionHeader = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    color: AppColors.textSecondary,
  );

  // Segment numbers: large, bold
  static const TextStyle segmentText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Life total: very large, bold, centered
  static const TextStyle lifeTotal = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Button text
  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // +/- button text
  static const TextStyle lifeDelta = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.purple,
        secondary: AppColors.purpleLight,
        surface: AppColors.background,
      ),
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.lifeTotal,
        titleMedium: AppTextStyles.sectionHeader,
        bodyLarge: AppTextStyles.segmentText,
        labelLarge: AppTextStyles.buttonText,
      ),
    );
  }
}
