import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyMedium = Color(0xFFE0E0E0);
  static const Color greyDark = Color(0xFF757575);
  static const Color errorRed = Color(0xFFD32F2F);
  static const Color successGreen = Color(0xFF388E3C);

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: MaterialColor(0xFF000000, const <int, Color>{
        50: Color(0xFFE0E0E0),
        100: Color(0xFFB3B3B3),
        200: Color(0xFF808080),
        300: Color(0xFF4D4D4D),
        400: Color(0xFF262626),
        500: Color(0xFF000000),
        600: Color(0xFF000000),
        700: Color(0xFF000000),
        800: Color(0xFF000000),
        900: Color(0xFF000000),
      }),
      scaffoldBackgroundColor: primaryWhite,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryWhite,
        foregroundColor: primaryBlack,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: primaryBlack,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: primaryBlack),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlack,
          foregroundColor: primaryWhite,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlack,
          side: const BorderSide(color: primaryBlack),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: greyMedium),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: greyMedium),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlack, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        fillColor: primaryWhite,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      cardTheme: CardThemeData(
        color: primaryWhite,
        elevation: 2,
        shadowColor: primaryBlack.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      iconTheme: const IconThemeData(color: primaryBlack, size: 24),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: primaryBlack,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: primaryBlack,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: primaryBlack,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: primaryBlack,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: primaryBlack,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: primaryBlack,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: primaryBlack,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: primaryBlack,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: greyDark,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          color: primaryBlack,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: greyDark,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: greyDark,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryWhite,
        selectedItemColor: primaryBlack,
        unselectedItemColor: greyDark,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: primaryWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titleTextStyle: const TextStyle(
          color: primaryBlack,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: const TextStyle(color: primaryBlack, fontSize: 16),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: primaryBlack,
        contentTextStyle: const TextStyle(color: primaryWhite, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
