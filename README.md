<div align="center">

# 🧭 GewichtsKompass

**Premium Weight Management & Wellness App**

[![Flutter](https://img.shields.io/badge/Flutter-3.27+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![iOS](https://img.shields.io/badge/iOS-16+-000000?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com/ios/)
[![Android](https://img.shields.io/badge/Android-API%2021+-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://developer.android.com)

[🌐 Deutsch](#) · [🇸🇦 العربية](#) · [📱 iOS Setup](#-opening-in-xcode--ios) · [🤖 Android Setup](#-android-setup)

</div>

---

## 📱 About

GewichtsKompass (بوصلة الوزن) is a premium, production-ready Flutter application for holistic weight management and wellness. Track your weight, body measurements, nutrition, water intake, workouts, and daily habits — all in one beautifully designed app with full bilingual support (German + Arabic RTL).

---

## ✨ Features

| Category | Features |
|----------|----------|
| 🏠 **Dashboard** | Current weight, BMI, calories, water, habits — all at a glance |
| ⚖️ **Weight Tracking** | Log, edit, delete entries with trend charts & milestones |
| 📏 **Body Measurements** | Waist, chest, hips, arms, thighs, neck, body fat % |
| 🍽️ **Meal Logging** | Breakfast / lunch / dinner / snacks with macros tracking |
| 💧 **Water Tracking** | Quick logging with daily goals & reminders |
| 🏋️ **Workout Logging** | Running, walking, strength, cycling & more |
| ✅ **Habit Tracking** | Daily habits with streaks & celebrations |
| 📊 **Analytics** | Premium charts, trends, smart insights & goal forecasts |
| 🌍 **Bilingual** | German (default, LTR) + Arabic (full RTL support) |
| 🌙 **Themes** | Light, Dark, System — all premium quality |
| 🔔 **Notifications** | Customizable reminders for weight, water, meals, workouts |
| 🔐 **Authentication** | Email, Google, Apple sign-in + guest mode |

---

## 🏗️ Architecture

```
Clean Architecture + Feature-First
├── config/          # Theme, routing, localization, Firebase
├── core/            # Shared widgets, constants, providers
├── data/            # Models, repositories impl, data sources
├── domain/          # Entities, repository interfaces, use cases
└── features/        # Feature screens organized by domain
```

| Layer | Technology |
|-------|-----------|
| **State Management** | Riverpod (`flutter_riverpod` + `riverpod_annotation`) |
| **Routing** | go_router with `ShellRoute` for bottom navigation |
| **Backend** | Firebase (Auth, Firestore, Analytics, Crashlytics, FCM) |
| **Local Cache** | Hive (ready for offline-first integration) |
| **Charts** | fl_chart for premium analytics visualizations |
| **Localization** | Flutter's built-in `gen-l10n` with ARB files |

---

## 🚀 Getting Started

### Prerequisites

| Tool | Minimum Version | Purpose |
|------|----------------|---------|
| [Flutter](https://docs.flutter.dev/get-started/install) | 3.27+ | Framework |
| [Dart](https://dart.dev/get-dart) | 3.6+ | Language |
| [Xcode](https://developer.apple.com/xcode/) | 16+ | iOS builds |
| [CocoaPods](https://cocoapods.org/) | Latest | iOS dependencies |
| [Android Studio](https://developer.android.com/studio) | Latest | Android builds |
| [Firebase CLI](https://firebase.google.com/docs/cli) | Latest | Firebase setup |

### Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/mgrd281/FormWerk.git
cd FormWerk

# 2. Install Flutter dependencies
flutter pub get

# 3. Generate localization files
flutter gen-l10n

# 4. Run the app (choose your platform)
flutter run
```

---

## 🍎 Opening in Xcode / iOS

> **Note:** GitHub's "Open with Xcode" button only works for native iOS projects (`.xcodeproj` at root). Flutter projects require a few extra steps — but it's straightforward!

### Step-by-Step: Open in Xcode

```bash
# 1. Navigate to the iOS directory
cd ios

# 2. Install CocoaPods dependencies
pod install

# 3. Open the WORKSPACE (not .xcodeproj!)
open Runner.xcworkspace
```

> ⚠️ **Important:** Always open `Runner.xcworkspace`, NOT `Runner.xcodeproj`. The workspace includes CocoaPods dependencies.

### Step-by-Step: Run on iPhone

**Option A: Via Xcode**
1. Open `Runner.xcworkspace` as described above
2. Connect your iPhone via USB (or select a simulator)
3. Select **Runner** scheme → your device as the target
4. Click ▶️ **Run** (or press `⌘R`)

**Option B: Via Flutter CLI (Recommended)**
```bash
# List available devices
flutter devices

# Run on a specific iOS device
flutter run -d <device-id>

# Or run on iOS simulator
flutter run -d ios
```

### Common iOS Issues & Fixes

| Issue | Solution |
|-------|---------|
| `pod install` fails | Run `pod repo update` then `pod install` again |
| Signing error in Xcode | Select **Runner** → **Signing & Capabilities** → choose your Team |
| Build fails with module errors | Run `flutter clean && flutter pub get && cd ios && pod install` |
| "No device" in Xcode | Ensure your iPhone is trusted: Settings → General → Device Management |
| CocoaPods version mismatch | Run `sudo gem install cocoapods` to update |

### iOS Build for Release

```bash
# Build IPA for App Store / TestFlight
flutter build ipa --release

# The output will be at:
# build/ios/ipa/gewichtskompass.ipa
```

---

## 🤖 Android Setup

```bash
# Run on Android emulator or device
flutter run -d android

# Build release AAB for Play Store
flutter build appbundle --release

# Build release APK
flutter build apk --release
```

---

## 🔥 Firebase Setup

The project uses Firebase for authentication, database, analytics, and more. Follow these steps to configure:

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project named **GewichtsKompass**
3. Enable the following services:
   - **Authentication** → Email/Password, Google, Apple
   - **Cloud Firestore** → Start in test mode
   - **Analytics** → Enable
   - **Crashlytics** → Enable
   - **Cloud Messaging** → Enable

### 2. Register Apps

| Platform | Bundle ID / Package Name |
|----------|------------------------|
| iOS | `de.gewichtskompass.app` |
| Android | `de.gewichtskompass.app` |

### 3. Download Config Files

| Platform | File | Destination |
|----------|------|-------------|
| iOS | `GoogleService-Info.plist` | `ios/Runner/GoogleService-Info.plist` |
| Android | `google-services.json` | `android/app/google-services.json` |

> 📝 Both config files are already in `.gitignore` — they will NOT be committed to the repository.

### 4. Update Firebase Options

Edit `lib/config/firebase/firebase_options.dart` and replace the placeholder values:

```dart
static FirebaseOptions get currentPlatform {
  return const FirebaseOptions(
    apiKey: 'YOUR_ACTUAL_API_KEY',        // ← Replace
    appId: 'YOUR_ACTUAL_APP_ID',          // ← Replace
    messagingSenderId: 'YOUR_SENDER_ID',  // ← Replace
    projectId: 'gewichtskompass',
    storageBucket: 'gewichtskompass.appspot.com',
    iosBundleId: 'de.gewichtskompass.app',
  );
}
```

> 💡 **Pro Tip:** Use `flutterfire configure` CLI to auto-generate `firebase_options.dart`:
> ```bash
> dart pub global activate flutterfire_cli
> flutterfire configure
> ```

---

## 📂 Project Structure

```
lib/
├── main.dart                          # App entry point
├── config/
│   ├── theme/
│   │   ├── app_colors.dart            # 🎨 Color palette (light + dark)
│   │   ├── app_typography.dart        # 🔤 Inter + Cairo font scale
│   │   ├── app_spacing.dart           # 📐 4px base spacing system
│   │   └── app_theme.dart             # 🌗 ThemeData (light + dark)
│   ├── router/
│   │   └── app_router.dart            # 🧭 go_router + ShellRoute
│   ├── localization/
│   │   └── app_localizations.dart     # 🌍 de + ar locale logic
│   └── firebase/
│       └── firebase_options.dart      # 🔥 Firebase config + schema docs
├── core/
│   ├── constants/
│   │   └── app_constants.dart         # ⚙️ App-wide constants
│   ├── widgets/
│   │   └── app_widgets.dart           # 🧩 PremiumCard, PremiumButton, etc.
│   └── providers/
│       └── app_providers.dart         # 🔄 Riverpod providers
├── data/
│   ├── models/
│   │   └── models.dart                # 📦 Firestore data models
│   ├── repositories/                  # 🗄️ Repository implementations
│   ├── datasources/                   # 🔌 Remote + local data sources
│   └── mappers/                       # 🔄 Entity ↔ Model mappers
├── domain/
│   ├── entities/
│   │   ├── user_profile.dart          # 👤 User entity
│   │   └── weight_entry.dart          # ⚖️ Weight entry entity
│   ├── repositories/
│   │   └── repositories.dart          # 📋 Repository interfaces
│   └── usecases/
│       └── health_calculations.dart   # 🧮 BMI, TDEE, insights
├── features/
│   ├── splash/                        # 🚀 Splash screen
│   ├── onboarding/                    # 📋 Multi-step onboarding
│   ├── auth/                          # 🔐 Login + Signup
│   ├── home/                          # 🏠 Premium dashboard
│   ├── progress/                      # 📈 Progress overview
│   ├── log/                           # ➕ Central logging hub
│   ├── habits/                        # ✅ Habit tracking
│   ├── profile/                       # 👤 Profile & settings
│   ├── weight/                        # ⚖️ Weight entry
│   ├── measurements/                  # 📏 Body measurements
│   ├── meals/                         # 🍽️ Meal logging
│   ├── water/                         # 💧 Water tracking
│   ├── workout/                       # 🏋️ Workout logging
│   ├── analytics/                     # 📊 Charts & insights
│   ├── settings/                      # ⚙️ App settings
│   └── static/                        # 📄 About, Privacy, Terms
└── l10n/
    ├── app_de.arb                     # 🇩🇪 German strings (189 keys)
    └── app_ar.arb                     # 🇸🇦 Arabic strings
```

---

## 🎨 Design System

### Color Palette

| Role | Light | Dark | Hex |
|------|-------|------|-----|
| **Primary** | 🟢 | 🟢 | `#2D6A4F` |
| **Primary Light** | 🟢 | — | `#40916C` |
| **Primary Dark** | 🟢 | — | `#1B4332` |
| **Accent** | 🟠 | 🟠 | `#E76F51` |
| **Accent Light** | 🟡 | — | `#F4A261` |
| **Error** | 🔴 | 🔴 | `#E63946` |
| **Info** | 🔵 | 🔵 | `#457B9D` |
| **Background** | ⬜ | ⬛ | `#FAFBFC` / `#0F1114` |
| **Surface** | ⬜ | ⬛ | `#FFFFFF` / `#1A1D21` |

### Typography

| Font | Usage | Weights |
|------|-------|---------|
| **Inter** | Latin text (DE, EN) | Thin → Black (100–900) |
| **Cairo** | Arabic text (AR) | Light → Bold (300–700) |

### Spacing System

Base unit: **4px**

```
4 · 8 · 12 · 16 · 20 · 24 · 32 · 40 · 48
```

### Border Radius

```
8 · 12 · 16 · 20 · 24
```

---

## 🌍 Localization

| Code | Language | Direction | Font | Status |
|------|----------|-----------|------|--------|
| `de` | Deutsch | LTR ← | Inter | ✅ Complete (189 strings) |
| `ar` | العربية | RTL → | Cairo | ✅ Complete |

### Adding a New Language

1. Create `lib/l10n/app_<locale>.arb` with all 189 string keys
2. Add the locale to `AppLocalizations.supportedLocales`
3. Run `flutter gen-l10n`
4. Add font support in `pubspec.yaml` if needed

---

## 🗄️ Firestore Schema

All data is stored under `users/{userId}/` subcollections:

<details>
<summary>📋 View Full Schema</summary>

```
users/{userId}
  uid, email, displayName, photoUrl
  gender, age, heightCm, currentWeightKg, targetWeightKg
  activityLevel, goal, unitSystem, dietaryPreference
  dailyCalorieTarget, dailyWaterGoalMl
  locale, themeMode, createdAt, updatedAt

users/{userId}/weights/{entryId}
  date, weightKg, note, createdAt

users/{userId}/body_measurements/{entryId}
  date, waistCm, chestCm, hipsCm, armsCm, thighsCm, neckCm
  bodyFatPercent, createdAt

users/{userId}/meals/{entryId}
  date, mealType, name, caloriesKcal
  proteinG, carbsG, fatG, isFavorite, createdAt

users/{userId}/water_logs/{entryId}
  date, amountMl, createdAt

users/{userId}/workouts/{entryId}
  date, category, durationMin, caloriesBurned, notes, createdAt

users/{userId}/habits/{habitId}
  name, iconKey, isActive, createdAt

users/{userId}/habit_logs/{logId}
  habitId, date, isCompleted

users/{userId}/notification_settings/{id}
  weightReminder, waterReminder, mealReminder, workoutReminder
  motivationReminder, streakReminder
  weightReminderTime, waterReminderIntervalMin

users/{userId}/app_settings/{id}
  locale, themeMode, unitSystem, onboardingCompleted
```

</details>

---

## 🧪 Testing

```bash
# Run all unit & widget tests
flutter test

# Run with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/

# Run a specific test file
flutter test test/unit/health_calculations_test.dart
```

---

## 🛠️ Useful Commands

```bash
# Clean build artifacts
flutter clean

# Rebuild everything from scratch
flutter clean && flutter pub get && flutter gen-l10n

# Regenerate code (freezed, json_serializable, etc.)
dart run build_runner build --delete-conflicting-outputs

# Watch for code generation changes
dart run build_runner watch --delete-conflicting-outputs

# Check for dependency issues
flutter pub outdated

# Analyze code for issues
flutter analyze

# Format code
dart format lib/ test/

# Run on specific device
flutter devices                    # List all devices
flutter run -d <device-id>        # Run on specific device
flutter run -d all                # Run on all connected devices
```

---

## 🗺️ App Navigation Flow

```
Splash → Onboarding → Login/Signup → Home (authenticated)
                                          │
                    ┌─────────────────────┼─────────────────────┐
                    │                     │                     │
               Progress               Log (+)              Profile
                    │              │  │  │  │  │               │
                    │              │  │  │  │  │          Settings
                    │              │  │  │  │  │          │  │  │
               Analytics     Weight Meal Water Workout   Theme Lang Notif
               Insights      Measure
```

---

## 🔮 Roadmap

- [ ] 📱 Barcode scanning for meal logging
- [ ] 🤖 AI-powered health coach
- [ ] ⌚ Apple Health & Google Fit integration
- [ ] 💎 Premium subscriptions (in-app purchases)
- [ ] 🥗 Nutrition API integration (Open Food Facts)
- [ ] 📊 Export data as PDF/CSV
- [ ] 🏆 Achievements & gamification
- [ ] 👥 Social features (friends, challenges)
- [ ] 📸 Progress photos with comparison
- [ ] 🍽️ Recipe suggestions based on dietary preferences

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

---

## 📄 License

Proprietary — © 2026 GewichtsKompass. All rights reserved.

---

<div align="center">

**Built with ❤️ using Flutter**

[⬆ Back to Top](#-gewichtskompass)

</div>