import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blueAccent,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: Colors.blueAccent,
        secondary: Colors.purpleAccent,
        surface: Colors.white,
        onSurface: Colors.black87,
        tertiaryFixed: Colors.white70,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.blue[900]!,
      scaffoldBackgroundColor: Colors.grey[900]!,
      colorScheme: ColorScheme.dark(
        primary: Colors.blue[900]!, // Darker blue
        secondary: Colors.purple[900]!, // Darker purple
        surface: Colors.grey[900]!,
        onSurface: Colors.white70,
        tertiaryFixed: Colors.black54,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: Colors.white70,
        displayColor: Colors.white70,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.blue[900]!,
          foregroundColor: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // Gradient for HomeScreen background
  static LinearGradient getBackgroundGradient(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [
        colorScheme.primary.withOpacity(0.6), // Darker blue, lower opacity
        colorScheme.secondary.withOpacity(0.6), // Darker purple, lower opacity
      ]
          : [
        colorScheme.primary, // Vibrant blue
        colorScheme.secondary, // Vibrant purple
      ],
    );
  }
}