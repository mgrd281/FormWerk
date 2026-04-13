import 'package:flutter/material.dart';

/// Premium color palette for Gewichtskompass
/// Inspired by Apple Health, MyFitnessPal – vibrant, modern, wellness-focused
class AppColors {
  AppColors._();

  // ─── Primary Palette (Vibrant Teal-Green) ──────────────────────
  static const Color primary = Color(0xFF00B894);
  static const Color primaryLight = Color(0xFF55EFC4);
  static const Color primaryDark = Color(0xFF00A381);
  static const Color primarySurface = Color(0xFFE8FFF6);

  // ─── Accent Palette (Warm Coral) ───────────────────────────────
  static const Color accent = Color(0xFFFF6B6B);
  static const Color accentLight = Color(0xFFFF8E8E);
  static const Color accentSurface = Color(0xFFFFECEC);

  // ─── Secondary Accent (Amber) ──────────────────────────────────
  static const Color secondary = Color(0xFFFDCB6E);
  static const Color secondarySurface = Color(0xFFFEF3D0);

  // ─── Semantic Colors ───────────────────────────────────────────
  static const Color success = Color(0xFF00B894);
  static const Color successLight = Color(0xFFE8FFF6);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color warningLight = Color(0xFFFEF3D0);
  static const Color error = Color(0xFFFF6B6B);
  static const Color errorLight = Color(0xFFFFECEC);
  static const Color info = Color(0xFF74B9FF);
  static const Color infoLight = Color(0xFFEBF5FF);

  // ─── Neutral Palette (Light Theme) ─────────────────────────────
  static const Color background = Color(0xFFF8FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F3F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFEEF0F2);

  static const Color textPrimary = Color(0xFF1A1D26);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textDisabled = Color(0xFFD1D5DB);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFFF1F3F5);
  static const Color outline = Color(0xFFE5E7EB);
  static const Color shadow = Color(0x0A1A1D21);

  // ─── Chart Colors ──────────────────────────────────────────────
  static const Color chartWeight = Color(0xFF00B894);
  static const Color chartCalories = Color(0xFFFF6B6B);
  static const Color chartWater = Color(0xFF74B9FF);
  static const Color chartHabits = Color(0xFFFDCB6E);
  static const Color chartProtein = Color(0xFF00B894);
  static const Color chartCarbs = Color(0xFFFDCB6E);
  static const Color chartFat = Color(0xFFFF6B6B);

  // ─── Gradient Definitions ──────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00B894), Color(0xFF55EFC4)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E8E)],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00B894), Color(0xFF00CEC9)],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF8FAFB), Color(0xFFF1F3F5)],
  );

  // ─── BMI Category Colors ──────────────────────────────────────
  static const Color bmiUnderweight = Color(0xFF74B9FF);
  static const Color bmiNormal = Color(0xFF00B894);
  static const Color bmiOverweight = Color(0xFFFDCB6E);
  static const Color bmiObese = Color(0xFFFF6B6B);
}

/// Dark theme color overrides
class AppColorsDark {
  AppColorsDark._();

  static const Color background = Color(0xFF0F1117);
  static const Color surface = Color(0xFF1A1D26);
  static const Color surfaceVariant = Color(0xFF242830);
  static const Color cardBackground = Color(0xFF1E222C);
  static const Color cardBorder = Color(0xFF2E3340);

  static const Color textPrimary = Color(0xFFF1F3F5);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textTertiary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF4B5563);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFF2E3340);
  static const Color outline = Color(0xFF3A4049);
  static const Color shadow = Color(0x1A000000);

  static const Color primarySurface = Color(0xFF0A2E24);
  static const Color accentSurface = Color(0xFF2E1A1A);
  static const Color secondarySurface = Color(0xFF2E2A1A);

  static const Color successLight = Color(0xFF0A2E24);
  static const Color warningLight = Color(0xFF2E2A1A);
  static const Color errorLight = Color(0xFF2E1A1A);
  static const Color infoLight = Color(0xFF1A2A3D);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F1117), Color(0xFF161922)],
  );
}