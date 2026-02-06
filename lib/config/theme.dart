import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:google_fonts/google_fonts.dart';

class PresentationTheme {
  static const Color backgroundColor = Color(0xFFFFFDF9); // Bright Cream
  static const Color rightBackgroundColor = Color(
    0xFFF0F9FF,
  ); // Very Light Pastel Blue
  static const Color primaryColor = Color(0xFFB3E5FC); // Pastel Blue
  static const Color primaryDarkColor = Color(
    0xFF0288D1,
  ); // Darker Pastel Blue for text
  static const Color accentColor = Color(0xFFF8BBD0); // Pastel Pink
  static const Color accentDarkColor = Color(
    0xFFC2185B,
  ); // Darker Pastel Pink for text
  static const Color warningColor = Color(0xFFFFE0B2); // Pastel Orange
  static const Color warningDarkColor = Color(
    0xFFE65100,
  ); // Darker Orange for text
  static const Color successColor = Color(0xFFC8E6C9); // Pastel Green
  static const Color successDarkColor = Color(
    0xFF2E7D32,
  ); // Darker Green for text
  static const Color textColor = Color(
    0xFF263238,
  ); // Deeper Blue Grey for better contrast
  static const Color secondaryTextColor = Color(0xFF546E7A); // Grey Blue

  static final TextTheme textTheme = GoogleFonts.kiwiMaruTextTheme().apply(
    bodyColor: textColor,
    displayColor: textColor,
  );

  static FlutterDeckTextTheme get _flutterDeckTextTheme => FlutterDeckTextTheme(
    header: GoogleFonts.kiwiMaru(color: textColor, fontWeight: FontWeight.bold),
    title: GoogleFonts.kiwiMaru(color: textColor, fontWeight: FontWeight.bold),
    subtitle: GoogleFonts.kiwiMaru(
      color: secondaryTextColor,
      fontWeight: FontWeight.w500,
    ),
  );

  static FlutterDeckThemeData get lightTheme {
    return FlutterDeckThemeData.light().copyWith(
      slideTheme: const FlutterDeckSlideThemeData(
        backgroundColor: backgroundColor,
        color: textColor,
      ),
      headerTheme: FlutterDeckHeaderThemeData(
        color: textColor,
        textStyle: GoogleFonts.kiwiMaru(color: textColor),
      ),
      splitSlideTheme: const FlutterDeckSplitSlideThemeData(
        leftBackgroundColor: backgroundColor,
        rightBackgroundColor: rightBackgroundColor,
        leftColor: textColor,
        rightColor: textColor,
      ),
      textTheme: _flutterDeckTextTheme,
    );
  }

  static FlutterDeckThemeData get darkTheme {
    const darkTextColor = Color(0xFFECEFF1);
    return FlutterDeckThemeData.dark().copyWith(
      slideTheme: const FlutterDeckSlideThemeData(
        backgroundColor: Color(0xFF263238), // Dark Blue Grey
        color: darkTextColor,
      ),
      headerTheme: FlutterDeckHeaderThemeData(
        color: darkTextColor,
        textStyle: GoogleFonts.kiwiMaru(
          color: darkTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: FlutterDeckTextTheme(
        header: GoogleFonts.kiwiMaru(
          color: darkTextColor,
          fontWeight: FontWeight.bold,
        ),
        title: GoogleFonts.kiwiMaru(
          color: darkTextColor,
          fontWeight: FontWeight.bold,
        ),
        subtitle: GoogleFonts.kiwiMaru(
          color: const Color(0xFFB0BEC5),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
