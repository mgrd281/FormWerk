/// Application-wide constants for GewichtsKompass
class AppConstants {
  AppConstants._();

  static const String appName = 'GewichtsKompass';
  static const String appNameAr = 'بوصلة الوزن';
  static const String appVersion = '1.0.0';

  // Firestore collection names
  static const String usersCollection = 'users';
  static const String weightsCollection = 'weights';
  static const String measurementsCollection = 'body_measurements';
  static const String mealsCollection = 'meals';
  static const String waterLogsCollection = 'water_logs';
  static const String workoutsCollection = 'workouts';
  static const String habitsCollection = 'habits';
  static const String habitLogsCollection = 'habit_logs';
  static const String notificationSettingsCollection = 'notification_settings';
  static const String appSettingsCollection = 'app_settings';
  static const String achievementsCollection = 'achievements';

  // Defaults
  static const double defaultCalorieGoal = 2000.0;
  static const double defaultWaterGoal = 2500.0; // ml
  static const double defaultProteinRatio = 0.30;
  static const double defaultCarbsRatio = 0.40;
  static const double defaultFatRatio = 0.30;

  // BMI Categories
  static const double bmiUnderweight = 18.5;
  static const double bmiNormal = 25.0;
  static const double bmiOverweight = 30.0;

  // Streak
  static const int minStreakForCelebration = 3;

  // Pagination
  static const int pageSize = 20;

  // Animation durations
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 350);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);

  // Supported locales
  static const String localeDe = 'de';
  static const String localeAr = 'ar';
}