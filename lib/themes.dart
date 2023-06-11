import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
// 1
  static TextTheme lightTextTheme = TextTheme(
      bodyText1: GoogleFonts.poppins(
        color: Colors.black,
      ),
      headline1: GoogleFonts.poppins(
        color: Colors.black,
      ),
      headline2: GoogleFonts.poppins(
        color: Colors.black,
      ),
      headline3: GoogleFonts.poppins(
        color: Colors.black,
      ),
      headline6: GoogleFonts.poppins(
        color: Colors.black,
      ));
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.poppins(
      color: Colors.white,
    ),
    headline1: GoogleFonts.poppins(
      color: Colors.white,
    ),
    headline2: GoogleFonts.poppins(
      color: Colors.white,
    ),
    headline3: GoogleFonts.poppins(
      color: Colors.white,
    ),
    headline6: GoogleFonts.poppins(
      color: Colors.white,
    ),
  );

  // Dark
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey.shade900,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.black87,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.white,
          elevation: 5.0),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }

  // light
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        foregroundColor: Colors.black54,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: lightTextTheme,
    );
  }
}
