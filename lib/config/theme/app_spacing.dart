import 'package:flutter/material.dart';

/// Spacing and dimension system for GewichtsKompass
/// Follows a 4px base grid for consistent, harmonious layouts
class AppSpacing {
  AppSpacing._();

  // ─── Base Spacing (4px grid) ────────────────────────────────
  static const double unit = 4.0;

  static const double xs = 4.0;    // 1 unit
  static const double sm = 8.0;    // 2 units
  static const double md = 12.0;   // 3 units
  static const double base = 16.0; // 4 units
  static const double lg = 20.0;   // 5 units
  static const double xl = 24.0;   // 6 units
  static const double xxl = 32.0;  // 8 units
  static const double xxxl = 48.0; // 12 units
  static const double huge = 64.0; // 16 units

  // ─── Screen Padding ─────────────────────────────────────────
  static const double screenPaddingHorizontal = 20.0;
  static const double screenPaddingVertical = 16.0;
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenPaddingHorizontal,
    vertical: screenPaddingVertical,
  );

  static const double cardPaddingHorizontal = 16.0;
  static const double cardPaddingVertical = 16.0;
  static const EdgeInsets cardPadding = EdgeInsets.symmetric(
    horizontal: cardPaddingHorizontal,
    vertical: cardPaddingVertical,
  );

  static const EdgeInsets listTilePadding = EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 12.0,
  );

  // ─── Section Spacing ────────────────────────────────────────
  static const double sectionGap = 24.0;
  static const double itemGap = 12.0;
  static const double widgetGap = 8.0;

  // ─── Icon Sizes ─────────────────────────────────────────────
  static const double iconXs = 14.0;
  static const double iconSm = 18.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // ─── Button Dimensions ──────────────────────────────────────
  static const double buttonHeight = 52.0;
  static const double buttonHeightSm = 40.0;
  static const double buttonHeightLg = 56.0;
  static const double buttonIconSize = 20.0;
  static const double buttonPaddingHorizontal = 24.0;

  // ─── Input Dimensions ───────────────────────────────────────
  static const double inputHeight = 52.0;
  static const double inputBorderWidth = 1.5;
  static const double inputFocusBorderWidth = 2.0;

  // ─── Avatar Sizes ───────────────────────────────────────────
  static const double avatarSm = 32.0;
  static const double avatarMd = 48.0;
  static const double avatarLg = 72.0;
  static const double avatarXl = 96.0;

  // ─── Progress Ring Sizes ────────────────────────────────────
  static const double progressRingSm = 40.0;
  static const double progressRingMd = 64.0;
  static const double progressRingLg = 100.0;
  static const double progressRingXl = 140.0;
  static const double progressRingLineWidth = 6.0;
  static const double progressRingLineWidthThick = 10.0;
}

/// Border radius system
class AppRadius {
  AppRadius._();

  static const double none = 0.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double full = 999.0;

  // ─── Pre-built BorderRadius ─────────────────────────────────
  static BorderRadius get noneR => BorderRadius.circular(none);
  static BorderRadius get xsR => BorderRadius.circular(xs);
  static BorderRadius get smR => BorderRadius.circular(sm);
  static BorderRadius get mdR => BorderRadius.circular(md);
  static BorderRadius get lgR => BorderRadius.circular(lg);
  static BorderRadius get xlR => BorderRadius.circular(xl);
  static BorderRadius get xxlR => BorderRadius.circular(xxl);
  static BorderRadius get fullR => BorderRadius.circular(full);
}

/// Elevation and shadow system
class AppElevation {
  AppElevation._();

  static const double none = 0.0;
  static const double low = 1.0;
  static const double medium = 3.0;
  static const double high = 6.0;
  static const double elevated = 12.0;

  // ─── Pre-built BoxShadows ───────────────────────────────────
  static List<BoxShadow> shadow(BuildContext context, {double? elevation}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final e = elevation ?? low;
    return [
      BoxShadow(
        color: isDark
            ? const Color(0x1A000000)
            : const Color(0x0A1A1D21),
        blurRadius: e * 4,
        spreadRadius: 0,
        offset: Offset(0, e * 0.5),
      ),
    ];
  }

  static List<BoxShadow> get shadowLow => [
    const BoxShadow(
      color: Color(0x0A1A1D21),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get shadowMedium => [
    const BoxShadow(
      color: Color(0x0F1A1D21),
      blurRadius: 12,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowHigh => [
    const BoxShadow(
      color: Color(0x141A1D21),
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowDarkLow => [
    const BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get shadowDarkMedium => [
    const BoxShadow(
      color: Color(0x24000000),
      blurRadius: 12,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
  ];
}