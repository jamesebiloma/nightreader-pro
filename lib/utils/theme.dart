import 'package:flutter/material.dart';

class AppTheme {
  // Dark theme colors optimized for night reading
  static const Color darkBackground = Color(0xFF0D0D0D);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF242424);
  static const Color primaryDark = Color(0xFFE8B86D);
  static const Color accentDark = Color(0xFF64B5F6);
  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  
  // Light theme colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFAFAFA);
  static const Color primaryLight = Color(0xFF2C3E50);
  static const Color accentLight = Color(0xFF1976D2);
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: primaryDark,
        secondary: accentDark,
        surface: darkSurface,
        background: darkBackground,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textPrimaryDark),
        titleTextStyle: TextStyle(
          color: textPrimaryDark,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: darkCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      iconTheme: const IconThemeData(color: textPrimaryDark),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: textPrimaryDark, fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: textPrimaryDark, fontSize: 28, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(color: textPrimaryDark, fontSize: 24, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: textPrimaryDark, fontSize: 20, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: textPrimaryDark, fontSize: 16),
        bodyMedium: TextStyle(color: textSecondaryDark, fontSize: 14),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryDark,
        foregroundColor: darkBackground,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: primaryDark,
        unselectedItemColor: textSecondaryDark,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      colorScheme: const ColorScheme.light(
        primary: primaryLight,
        secondary: accentLight,
        surface: lightSurface,
        background: lightBackground,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textPrimaryLight),
        titleTextStyle: TextStyle(
          color: textPrimaryLight,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: lightCard,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      iconTheme: const IconThemeData(color: textPrimaryLight),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: textPrimaryLight, fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: textPrimaryLight, fontSize: 28, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(color: textPrimaryLight, fontSize: 24, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: textPrimaryLight, fontSize: 20, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: textPrimaryLight, fontSize: 16),
        bodyMedium: TextStyle(color: textSecondaryLight, fontSize: 14),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryLight,
        foregroundColor: lightSurface,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightSurface,
        selectedItemColor: accentLight,
        unselectedItemColor: textSecondaryLight,
      ),
    );
  }
}
