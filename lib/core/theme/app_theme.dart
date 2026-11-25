import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryContainer,
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.cardWhite,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.ink),
      ),
      textTheme: TextTheme(
        headlineLarge: AppTypography.headlineLg(),
        headlineMedium: AppTypography.headlineMd(),
        headlineSmall: AppTypography.headlineSm(),
        bodyLarge: AppTypography.bodyLg(),
        bodyMedium: AppTypography.bodyMd(),
        bodySmall: AppTypography.bodySm(),
        labelLarge: AppTypography.labelLg(),
        labelMedium: AppTypography.labelMd(),
        labelSmall: AppTypography.labelSm(),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF191919),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryContainer,
        onPrimary: AppColors.ink,
        surface: Color(0xFF242424),
        onSurface: Color(0xFFF5F5F5),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF191919),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: TextTheme(
        headlineLarge: AppTypography.headlineLg(color: Colors.white),
        headlineMedium: AppTypography.headlineMd(color: Colors.white),
        headlineSmall: AppTypography.headlineSm(color: Colors.white),
        bodyLarge: AppTypography.bodyLg(color: const Color(0xFFE5E2E1)),
        bodyMedium: AppTypography.bodyMd(color: const Color(0xFFE5E2E1)),
        bodySmall: AppTypography.bodySm(color: const Color(0xFFA5A2A1)),
        labelLarge: AppTypography.labelLg(color: Colors.white),
        labelMedium: AppTypography.labelMd(color: Colors.white),
        labelSmall: AppTypography.labelSm(color: Colors.white),
      ),
    );
  }
}
