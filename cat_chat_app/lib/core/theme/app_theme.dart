import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 貓談社品牌色 - 鵝黃/暖色調
  static const Color primaryColor = Color(0xFFF7D154); // 貓談黃
  static const Color primaryDarkColor = Color(0xFFD6A414);
  static const Color secondaryColor = Color(0xFFFFF2D0); // 暖白/淺黃
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFE57373);
  
  // 文字顏色
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        background: backgroundColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: textPrimary,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: GoogleFonts.notoSansTcTextTheme().copyWith(
        displayLarge: GoogleFonts.notoSansTc(color: textPrimary, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.notoSansTc(color: textPrimary, fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.notoSansTc(color: textPrimary, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.notoSansTc(color: textPrimary),
        bodyMedium: GoogleFonts.notoSansTc(color: textPrimary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.notoSansTc(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: textPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      cardTheme: const CardThemeData(
        color: surfaceColor,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
