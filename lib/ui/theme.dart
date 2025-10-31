import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _loadTheme();
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void toggleTheme() async {
    setDarkMode(!isDarkMode);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  void _loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool('isDarkMode');
    if (isDarkMode == null) {
      final Brightness brightness =
          WidgetsBinding.instance.window.platformBrightness;
      isDarkMode = brightness == Brightness.dark;
    }
    setDarkMode(isDarkMode);
  }

  ThemeData get currentTheme {
    return isDarkMode ? darkTheme : lightTheme;
  }

  // Light Theme
  final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: textTheme,
    colorScheme: const ColorScheme.light(
      primary: TurfitColors.primaryLight,
      secondary: TurfitColors.secondaryLight,
      onPrimary: TurfitColors.onPrimaryLight,
      surface: TurfitColors.surfaceLight,
      onSurface: TurfitColors.onSurfaceLight,
      outline: TurfitColors.outlineLight,
    ),
    scaffoldBackgroundColor: TurfitColors.surfaceLight,
    appBarTheme: const AppBarTheme(backgroundColor: TurfitColors.surfaceLight),
    cardTheme: CardThemeData(
      color: TurfitColors.surfaceLight,
      surfaceTintColor: TurfitColors.primaryLight,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: TurfitColors.surfaceLight,
      surfaceTintColor: TurfitColors.primaryLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: textTheme.titleLarge!.copyWith(
        color: TurfitColors.onSurfaceLight,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: textTheme.bodyMedium!.copyWith(
        color: TurfitColors.onSurfaceLight,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: textTheme.bodyLarge,
      border: const OutlineInputBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return TurfitColors.outlineLight;
          }
          return TurfitColors.primaryLight;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return TurfitColors.surfaceLight;
          }
          return TurfitColors.surfaceLight;
        }),
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: textTheme.bodyLarge!.copyWith(
        color: TurfitColors.onPrimaryLight,
      ),
      iconColor: TurfitColors.onPrimaryLight,
    ),
  );

  // Dark Theme
  final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: textTheme,
    colorScheme: const ColorScheme.dark(
      primary: TurfitColors.primaryDark,
      secondary: TurfitColors.secondaryDark,
      onPrimary: TurfitColors.onPrimaryDark,
      surface: TurfitColors.surfaceDark,
      onSurface: TurfitColors.onSurfaceDark,
      outline: TurfitColors.outlineDark,
    ),
    scaffoldBackgroundColor: TurfitColors.surfaceDark,
    appBarTheme: const AppBarTheme(backgroundColor: TurfitColors.surfaceDark),
    cardTheme: CardThemeData(
      color: TurfitColors.surfaceDark,
      surfaceTintColor: TurfitColors.primaryDark,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: TurfitColors.surfaceDark,
      surfaceTintColor: TurfitColors.primaryDark,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: textTheme.titleLarge!.copyWith(
        color: TurfitColors.onSurfaceDark,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: textTheme.bodyMedium!.copyWith(
        color: TurfitColors.onSurfaceDark,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: textTheme.bodyLarge,
      border: const OutlineInputBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return TurfitColors.outlineDark;
          }
          return TurfitColors.primaryDark;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return TurfitColors.surfaceDark;
          }
          return TurfitColors.surfaceDark;
        }),
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: textTheme.bodyLarge!.copyWith(
        color: TurfitColors.onPrimaryDark,
      ),
      iconColor: TurfitColors.onPrimaryDark,
    ),
  );
}

// TextTheme
const TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 57,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.25,
  ),
  displayMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 45,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  ),
  displaySmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 36,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  ),
  headlineLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 28,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  ),
  headlineSmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  ),
  titleLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  ),
  titleMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  titleSmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  labelLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  labelMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
  labelSmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
  ),
);
