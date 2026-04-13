// Placeholder Firebase options – replace with actual values when setting up Firebase.
//
// When ready, add `firebase_core` to pubspec.yaml and run:
//   flutterfire configure
//
// Then replace this file with the generated one.

class DefaultFirebaseOptions {
  static Map<String, dynamic> get currentPlatform => const {
        'apiKey': 'YOUR_API_KEY',
        'appId': 'YOUR_APP_ID',
        'messagingSenderId': 'YOUR_SENDER_ID',
        'projectId': 'gewichtskompass',
        'storageBucket': 'gewichtskompass.appspot.com',
        'iosBundleId': 'de.gewichtskompass',
      };
}

/// Firestore Collection Schema:
///
/// users/{userId}
///   - uid: String
///   - email: String
///   - displayName: String
///   - photoUrl: String?
///   - gender: String (male/female/other)
///   - age: int
///   - heightCm: double
///   - currentWeightKg: double
///   - targetWeightKg: double
///   - activityLevel: String (sedentary/light/moderate/active/veryActive)
///   - goal: String (lose/maintain/gain)
///   - unitSystem: String (metric/imperial)
///   - dietaryPreference: String?
///   - dailyCalorieTarget: double
///   - dailyWaterGoalMl: int
///   - locale: String (de/ar)
///   - themeMode: String (light/dark/system)
///   - isOnboarded: bool
///   - createdAt: Timestamp
///   - updatedAt: Timestamp
///
/// users/{userId}/weights/{entryId}
///   - date: Timestamp
///   - weightKg: double
///   - note: String?
///   - createdAt: Timestamp
///
/// users/{userId}/body_measurements/{entryId}
///   - date: Timestamp
///   - waistCm: double?
///   - chestCm: double?
///   - hipsCm: double?
///   - armsCm: double?
///   - thighsCm: double?
///   - neckCm: double?
///   - bodyFatPercent: double?
///   - createdAt: Timestamp
///
/// users/{userId}/meals/{entryId}
///   - date: Timestamp
///   - mealType: String (breakfast/lunch/dinner/snack)
///   - name: String
///   - caloriesKcal: double
///   - proteinG: double
///   - carbsG: double
///   - fatG: double
///   - isFavorite: bool
///   - createdAt: Timestamp
///
/// users/{userId}/water_logs/{entryId}
///   - date: Timestamp
///   - amountMl: double
///   - createdAt: Timestamp
///
/// users/{userId}/workouts/{entryId}
///   - date: Timestamp
///   - category: String (running/walking/strength/cycling/homeWorkout/other)
///   - durationMin: int
///   - caloriesBurned: double?
///   - notes: String?
///   - createdAt: Timestamp
///
/// users/{userId}/habits/{habitId}
///   - name: String
///   - iconKey: String
///   - isActive: bool
///   - createdAt: Timestamp
///
/// users/{userId}/habit_logs/{logId}
///   - habitId: String
///   - date: Timestamp
///   - isCompleted: bool
///
/// users/{userId}/notification_settings/{id}
///   - weightReminder: bool
///   - waterReminder: bool
///   - mealReminder: bool
///   - workoutReminder: bool
///   - motivationReminder: bool
///   - streakReminder: bool
///
/// users/{userId}/app_settings/{id}
///   - locale: String
///   - themeMode: String
///   - unitSystem: String
///   - onboardingCompleted: bool