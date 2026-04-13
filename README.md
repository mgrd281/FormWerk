# GewichtsKompass 🧭

Premium weight management app built with Flutter — German primary, Arabic RTL support.

## Overview

GewichtsKompass is a premium, production-ready mobile application for holistic weight management. Track weight, body measurements, nutrition, workouts, and habits with an elegant, motivating experience.

## Features

- 🏠 **Premium Dashboard** — Current weight, BMI, calories, water, habits at a glance
- ⚖️ **Weight Tracking** — Log, edit, delete entries with trend charts & milestones
- 📏 **Body Measurements** — Waist, chest, hips, arms, thighs, neck, body fat %
- 🍽️ **Meal Logging** — Breakfast/lunch/dinner/snacks with macros tracking
- 💧 **Water Tracking** — Quick logging with daily goals
- 🏋️ **Workout Logging** — Running, walking, strength, cycling & more
- ✅ **Habit Tracking** — Daily habits with streaks & celebrations
- 📊 **Analytics** — Premium charts, trends, smart insights
- 🌍 **Bilingual** — German (default) + Arabic (full RTL)
- 🌙 **Themes** — Light, Dark, System — all premium quality
- 🔔 **Notifications** — Customizable reminders
- 🔐 **Auth** — Email, Google, Apple sign-in + guest mode

## Architecture

```
Clean Architecture + Feature-First
├── config/          # Theme, routing, localization, Firebase
├── core/            # Shared widgets, constants, providers
├── data/            # Models, repositories impl, data sources
├── domain/          # Entities, repository interfaces, use cases
└── features/        # Feature screens organized by domain
```

**State Management:** Riverpod  
**Routing:** go_router with ShellRoute for bottom nav  
**Backend:** Firebase (Auth, Firestore, Analytics, Crashlytics, FCM)  
**Local Cache:** Hive (ready for integration)

## Setup

### Prerequisites
- Flutter 3.27+ / Dart 3.6+
- Xcode 16+ (iOS)
- Android Studio / SDK (Android)
- Firebase project

### Installation

```bash
# 1. Clone & install dependencies
cd FormWerk
flutter pub get

# 2. Configure Firebase
#    - Create Firebase project at console.firebase.google.com
#    - Add iOS & Android apps
#    - Download google-services.json → android/app/
#    - Download GoogleService-Info.plist → ios/Runner/
#    - Update lib/config/firebase/firebase_options.dart

# 3. Generate localization files (if modifying)
flutter gen-l10n

# 4. Run the app
flutter run
```

### Build Release

```bash
# Android
flutter build appbundle --release

# iOS
flutter build ipa --release
```

## Project Structure

```
lib/
├── main.dart
├── config/
│   ├── theme/          # AppColors, AppTypography, AppSpacing, AppTheme
│   ├── router/         # go_router configuration
│   ├── localization/   # AppLocalizations (de + ar)
│   └── firebase/       # Firebase options & schema docs
├── core/
│   ├── constants/      # App constants
│   ├── widgets/        # PremiumCard, PremiumButton, PremiumInputField, etc.
│   └── providers/      # Riverpod providers
├── data/
│   └── models/         # Firestore data models with mappers
├── domain/
│   ├── entities/       # Business entities
│   ├── repositories/   # Repository interfaces
│   └── usecases/       # HealthCalculations (BMI, TDEE, insights)
└── features/
    ├── splash/         # Splash screen
    ├── onboarding/     # Multi-step onboarding
    ├── auth/           # Login, Signup
    ├── home/           # Premium dashboard
    ├── progress/       # Progress overview
    ├── log/            # Central logging hub
    ├── habits/         # Habit tracking
    ├── profile/        # Profile & settings
    ├── weight/         # Weight entry
    ├── measurements/   # Body measurements
    ├── meals/          # Meal logging
    ├── water/          # Water tracking
    ├── workout/        # Workout logging
    ├── analytics/      # Charts & insights
    ├── settings/       # App settings
    └── static/         # About, Privacy, Terms
```

## Localization

| Code | Language | Direction |
|------|----------|-----------|
| `de` | Deutsch  | LTR       |
| `ar` | العربية  | RTL       |

All strings are in `lib/config/localization/app_localizations.dart`. To add English, extend the locale map and add `en` support.

## Design System

- **Primary Color:** `#1A3C34` (Deep Teal)
- **Accent:** `#C8956C` (Warm Gold)
- **Typography:** Inter font family with 8-level scale
- **Spacing:** 4px base unit (4, 8, 12, 16, 20, 24, 32, 40, 48)
- **Border Radius:** 8, 12, 16, 20, 24
- **Cards:** Subtle shadow, 16px radius, 20px padding

## Firestore Schema

See `lib/config/firebase/firebase_options.dart` for complete schema documentation.

## Testing Strategy

- **Unit Tests:** Business logic (BMI, TDEE, insights)
- **Widget Tests:** Reusable components
- **Integration Tests:** Critical user flows

```bash
flutter test                    # Unit & widget tests
flutter test integration_test/  # Integration tests
```

## Future Extensions

- 📱 Barcode scanning for meals
- 🤖 AI health coach
- ⌚ Wearable integration (Apple Health, Google Fit)
- 💎 Premium subscriptions
- 🥗 Nutrition API integration
- 📊 Health platform integrations

## License

Proprietary — © 2026 GewichtsKompass