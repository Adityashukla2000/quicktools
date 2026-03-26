import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ),
  );
}


// ─── Color Palette ────────────────────────────────────────────────────────────
class AppColors {
  static const indigo = Color(0xFF6366F1);
  static const indigoDark = Color(0xFF4F46E5);
  static const sky = Color(0xFF0EA5E9);
  static const skyDark = Color(0xFF0284C7);
  static const emerald = Color(0xFF10B981);
  static const emeraldDark = Color(0xFF059669);
  static const amber = Color(0xFFF59E0B);
  static const amberDark = Color(0xFFD97706);
  static const rose = Color(0xFFF43F5E);
  static const roseDark = Color(0xFFE11D48);
  static const violet = Color(0xFF8B5CF6);
  static const violetDark = Color(0xFF7C3AED);

  // Light mode surfaces
  static const bgLight = Color(0xFFF8FAFC);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const borderLight = Color(0xFFE2E8F0);
  static const textPrimLight = Color(0xFF0F172A);
  static const textSecLight = Color(0xFF64748B);
  static const textHintLight = Color(0xFF94A3B8);

  // Dark mode surfaces
  static const bgDark = Color(0xFF0A0F1C);
  static const surfaceDark = Color(0xFF131929);
  static const surfaceDark2 = Color(0xFF1C2537);
  static const borderDark = Color(0xFF1E2D45);
  static const textPrimDark = Color(0xFFF0F6FF);
  static const textSecDark = Color(0xFF8899AA);
  static const textHintDark = Color(0xFF4A5668);
}
