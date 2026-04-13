import 'package:flutter/material.dart';

/// Premium color palette for GewichtsKompass
/// Inspired by calm wellness aesthetics with sophisticated accent tones
class AppColors {
  AppColors._();

  // ─── Primary Palette ────────────────────────────────────────
  static const Color primary = Color(0xFF2D6A4F);
  static const Color primaryLight = Color(0xFF40916C);
  static const Color primaryDark = Color(0xFF1B4332);
  static const Color primarySurface = Color(0xFFD8F3DC);

  // ─── Accent Palette ─────────────────────────────────────────
  static const Color accent = Color(0xFFE76F51);
  static const Color accentLight = Color(0xFFF4A261);
  static const Color accentSurface = Color(0xFFFDEBD0);

  // ─── Semantic Colors ────────────────────────────────────────
  static const Color success = Color(0xFF40916C);
  static const Color successLight = Color(0xFFD8F3DC);
  static const Color warning = Color(0xFFF4A261);
  static const Color warningLight = Color(0xFFFDEBD0);
  static const Color error = Color(0xFFE63946);
  static const Color errorLight = Color(0xFFFDE8E8);
  static const Color info = Color(0xFF457B9D);
  static const Color infoLight = Color(0xFFE3EEF5);

  // ─── Neutral Palette (Light Theme) ──────────────────────────
  static const Color background = Color(0xFFFAFBFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F6F8);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFEEF0F2);

  static const Color textPrimary = Color(0xFF1A1D21);
  static const Color textSecondary = Color(0xFF5F6B7A);
  static const Color textTertiary = Color(0xFF9AA5B4);
  static const Color textDisabled = Color(0xFFC4CBD5);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFFEEF0F2);
  static const Color outline = Color(0xFFD8DCE2);
  static const Color shadow = Color(0x0A1A1D21);

  // ─── Chart Colors ───────────────────────────────────────────
  static const Color chartWeight = Color(0xFF2D6A4F);
  static const Color chartCalories = Color(0xFFE76F51);
  static const Color chartWater = Color(0xFF457B9D);
  static const Color chartHabits = Color(0xFFF4A261);
  static const Color chartProtein = Color(0xFF6A994E);
  static const Color chartCarbs = Color(0xFFBC6C25);
  static const Color chartFat = Color(0xFFDDA15E);

  // ─── Gradient Definitions ───────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2D6A4F), Color(0xFF40916C)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE76F51), Color(0xFFF4A261)],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFAFBFC), Color(0xFFF0F2F5)],
  );
}

/// Dark theme color overrides
class AppColorsDark {
  AppColorsDark._();

  static const Color background = Color(0xFF0F1114);
  static const Color surface = Color(0xFF1A1D21);
  static const Color surfaceVariant = Color(0xFF24282E);
  static const Color cardBackground = Color(0xFF1E2228);
  static const Color cardBorder = Color(0xFF2E333A);

  static const Color textPrimary = Color(0xFFF0F2F5);
  static const Color textSecondary = Color(0xFF9AA5B4);
  static const Color textTertiary = Color(0xFF6B7785);
  static const Color textDisabled = Color(0xFF4A5568);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFF2E333A);
  static const Color outline = Color(0xFF3A4049);
  static const Color shadow = Color(0x1A000000);

  static const Color primarySurface = Color(0xFF1B4332);
  static const Color accentSurface = Color(0xFF3D2518);

  static const Color successLight = Color(0xFF1B4332);
  static const Color warningLight = Color(0xFF3D2518);
  static const Color errorLight = Color(0xFF3D1A1A);
  static const Color infoLight = Color(0xFF1A2D3D);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F1114), Color(0xFF16191E)],
  );
}