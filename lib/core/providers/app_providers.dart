import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/weight_entry.dart';
import '../../domain/usecases/health_calculations.dart';

// ─── Theme Provider ────────────────────────────────────────────
enum AppThemeMode { light, dark, system }

final themeModeProvider = StateProvider<AppThemeMode>((ref) => AppThemeMode.system);

// ─── Locale Provider ───────────────────────────────────────────
final localeProvider = StateProvider<Locale>((ref) => const Locale('de'));

// ─── Auth State ────────────────────────────────────────────────
enum AuthStatus { unknown, authenticated, unauthenticated, onboarding }

class AuthState {
  final AuthStatus status;
  final UserProfile? user;
  const AuthState({this.status = AuthStatus.unknown, this.user});
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  void setAuthenticated(UserProfile user) {
    if (user.isOnboarded) {
      state = AuthState(status: AuthStatus.authenticated, user: user);
    } else {
      state = AuthState(status: AuthStatus.onboarding, user: user);
    }
  }

  void setUnauthenticated() {
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void signOut() {
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

// ─── User Profile Provider ─────────────────────────────────────
final userProfileProvider = StateProvider<UserProfile?>((ref) => null);

// ─── Weight Entries Provider ───────────────────────────────────
final weightEntriesProvider = StateProvider<List<WeightEntry>>((ref) => []);

// ─── Today's Stats Provider ────────────────────────────────────
class TodayStats {
  final double currentWeight;
  final double targetWeight;
  final double startWeight; // Starting weight for progress calculation
  final double bmi;
  final double dailyCalorieTarget;
  final double caloriesConsumed;
  final double waterConsumed;
  final double waterGoal;
  final int habitsCompleted;
  final int habitsTotal;
  final double workoutMinutes;
  final double workoutCalories;

  const TodayStats({
    this.currentWeight = 0,
    this.targetWeight = 0,
    this.startWeight = 0,
    this.bmi = 0,
    this.dailyCalorieTarget = 0,
    this.caloriesConsumed = 0,
    this.waterConsumed = 0,
    this.waterGoal = 2000,
    this.habitsCompleted = 0,
    this.habitsTotal = 5,
    this.workoutMinutes = 0,
    this.workoutCalories = 0,
  });

  double get calorieProgress => dailyCalorieTarget > 0
      ? (caloriesConsumed / dailyCalorieTarget).clamp(0.0, 1.0) : 0;
  double get waterProgress => waterGoal > 0
      ? (waterConsumed / waterGoal).clamp(0.0, 1.0) : 0;
  double get habitProgress => habitsTotal > 0
      ? habitsCompleted / habitsTotal : 0;
  double get weightDifference => (currentWeight - targetWeight).abs();
  
  /// Progress toward target weight (0.0 to 1.0)
  /// Requires startWeight; if not available, returns 0
  double get weightProgress {
    if (startWeight <= 0 || currentWeight <= 0 || targetWeight <= 0) return 0;
    final totalToLose = (startWeight - targetWeight).abs();
    if (totalToLose == 0) return 1.0;
    final lost = (startWeight - currentWeight).abs();
    return (lost / totalToLose).clamp(0.0, 1.0);
  }
}

final todayStatsProvider = Provider<TodayStats>((ref) {
  final profile = ref.watch(userProfileProvider);
  if (profile == null) return const TodayStats();

  final calorieTarget = HealthCalculations.dailyCalorieTarget(
    weightKg: profile.currentWeight,
    heightCm: profile.height,
    age: profile.age,
    gender: profile.gender,
    activityLevel: profile.activityLevel,
    goal: profile.goal,
  );

  return TodayStats(
    currentWeight: profile.currentWeight,
    targetWeight: profile.targetWeight,
    bmi: profile.bmi,
    dailyCalorieTarget: calorieTarget,
    waterGoal: HealthCalculations.recommendedWaterIntake(profile.currentWeight),
  );
});

// ─── Onboarding State ──────────────────────────────────────────
class OnboardingState {
  final int step;
  final Gender gender;
  final int age;
  final double height;
  final double currentWeight;
  final double targetWeight;
  final WeightGoal goal;
  final ActivityLevel activityLevel;
  final UnitSystem unitSystem;
  final DietaryPreference dietaryPreference;

  const OnboardingState({
    this.step = 0,
    this.gender = Gender.male,
    this.age = 25,
    this.height = 170,
    this.currentWeight = 70,
    this.targetWeight = 65,
    this.goal = WeightGoal.lose,
    this.activityLevel = ActivityLevel.moderate,
    this.unitSystem = UnitSystem.metric,
    this.dietaryPreference = DietaryPreference.none,
  });

  OnboardingState copyWith({
    int? step,
    Gender? gender,
    int? age,
    double? height,
    double? currentWeight,
    double? targetWeight,
    WeightGoal? goal,
    ActivityLevel? activityLevel,
    UnitSystem? unitSystem,
    DietaryPreference? dietaryPreference,
  }) {
    return OnboardingState(
      step: step ?? this.step,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      currentWeight: currentWeight ?? this.currentWeight,
      targetWeight: targetWeight ?? this.targetWeight,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
      unitSystem: unitSystem ?? this.unitSystem,
      dietaryPreference: dietaryPreference ?? this.dietaryPreference,
    );
  }
}

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier();
});

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(const OnboardingState());

  void nextStep() => state = state.copyWith(step: state.step + 1);
  void previousStep() => state = state.copyWith(step: (state.step - 1).clamp(0, 4));
  
  void setGender(Gender g) => state = state.copyWith(gender: g);
  void setAge(int a) => state = state.copyWith(age: a);
  void setHeight(double h) => state = state.copyWith(height: h);
  void setCurrentWeight(double w) => state = state.copyWith(currentWeight: w);
  void setTargetWeight(double w) => state = state.copyWith(targetWeight: w);
  void setGoal(WeightGoal g) => state = state.copyWith(goal: g);
  void setActivityLevel(ActivityLevel l) => state = state.copyWith(activityLevel: l);
  void setUnitSystem(UnitSystem u) => state = state.copyWith(unitSystem: u);
  void setDietaryPreference(DietaryPreference d) => state = state.copyWith(dietaryPreference: d);
}

// ─── Navigation Index Provider ─────────────────────────────────
final navigationIndexProvider = StateProvider<int>((ref) => 0);