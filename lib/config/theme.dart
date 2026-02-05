import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:google_fonts/google_fonts.dart';

class PresentationTheme {
  static const Color backgroundColor = Color(0xFF121212);
  static const Color primaryColor = Color(0xFF1976D2); // Deep Blue
  static const Color warningColor = Color(0xFFFF5722); // Red/Orange
  static const Color successColor = Color(0xFF4CAF50); // Green
  static const Color textColor = Color(0xFFFFFFFF); // White
  static const Color secondaryTextColor = Color(0xFFBDBDBD); // Light Grey

  static final TextTheme textTheme = GoogleFonts.notoSansJpTextTheme().apply(
    bodyColor: textColor,
    displayColor: textColor,
  );

  static FlutterDeckThemeData get darkTheme {
    return FlutterDeckThemeData.dark().copyWith(
      slideTheme: const FlutterDeckSlideThemeData(
        backgroundColor: backgroundColor,
        color: textColor,
      ),
    );
  }
}
