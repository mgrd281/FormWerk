import 'package:flutter/material.dart';

/// Premium typography scale for GewichtsKompass
/// Uses Inter for Latin scripts, Cairo for Arabic
class AppTypography {
  AppTypography._();

  // ─── Font Families ──────────────────────────────────────────
  /// Returns the appropriate font family based on locale
  /// (Returns null to use system default when custom fonts aren't available)
  static String? fontFamilyForLocale(Locale locale) {
    return null; // Uses system default fonts
  }

  // ─── Light Theme Text Styles ────────────────────────────────

  /// Display – Large hero headlines, onboarding titles
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  /// Display – Medium hero headlines
  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.3,
  );

  /// Display – Small hero headlines
  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.2,
  );

  /// Headline – Section headers
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.1,
  );

  /// Headline – Card titles
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  /// Headline – Subsection headers
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Title – List item titles, prominent labels
  static const TextStyle titleLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Title – Medium emphasis titles
  static const TextStyle titleMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  /// Title – Small emphasis titles
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  /// Body – Primary body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Body – Standard body text
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Body – Small body text
  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Label – Button labels, form labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.1,
  );

  /// Label – Medium labels, chips
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.2,
  );

  /// Label – Small labels, captions
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.3,
  );

  /// Caption – Overlines, timestamps
  static const TextStyle caption = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // ─── Number Styles (for dashboards, stats) ──────────────────

  /// Large stat number (e.g., current weight on dashboard)
  static const TextStyle statLarge = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -1.0,
  );

  /// Medium stat number
  static const TextStyle statMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  /// Small stat number
  static const TextStyle statSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.2,
  );

  // ─── Build TextTheme ────────────────────────────────────────

  static TextTheme buildTextTheme({bool isDark = false}) {
    final Color defaultColor = isDark
        ? const Color(0xFFF0F2F5)
        : const Color(0xFF1A1D21);
    final Color secondaryColor = isDark
        ? const Color(0xFF9AA5B4)
        : const Color(0xFF5F6B7A);

    return TextTheme(
      displayLarge: displayLarge.copyWith(color: defaultColor),
      displayMedium: displayMedium.copyWith(color: defaultColor),
      displaySmall: displaySmall.copyWith(color: defaultColor),
      headlineLarge: headlineLarge.copyWith(color: defaultColor),
      headlineMedium: headlineMedium.copyWith(color: defaultColor),
      headlineSmall: headlineSmall.copyWith(color: defaultColor),
      titleLarge: titleLarge.copyWith(color: defaultColor),
      titleMedium: titleMedium.copyWith(color: secondaryColor),
      titleSmall: titleSmall.copyWith(color: secondaryColor),
      bodyLarge: bodyLarge.copyWith(color: defaultColor),
      bodyMedium: bodyMedium.copyWith(color: secondaryColor),
      bodySmall: bodySmall.copyWith(color: secondaryColor),
      labelLarge: labelLarge.copyWith(color: defaultColor),
      labelMedium: labelMedium.copyWith(color: secondaryColor),
      labelSmall: labelSmall.copyWith(color: secondaryColor),
    );
  }
}