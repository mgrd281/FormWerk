import '../entities/user_profile.dart';

/// Health calculation utilities – pure business logic
class HealthCalculations {
  HealthCalculations._();

  /// Calculate BMI from weight (kg) and height (cm)
  static double calculateBmi(double weightKg, double heightCm) {
    if (heightCm <= 0 || weightKg <= 0) return 0;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// Get BMI category
  static String bmiCategory(double bmi) {
    if (bmi < 18.5) return 'bmiUnderweight';
    if (bmi < 25) return 'bmiNormal';
    if (bmi < 30) return 'bmiOverweight';
    return 'bmiObese';
  }

  /// Calculate BMR using Mifflin-St Jeor equation
  static double calculateBmr({
    required double weightKg,
    required double heightCm,
    required int age,
    required Gender gender,
  }) {
    if (gender == Gender.male) {
      return (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
    }
    return (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
  }

  /// Activity multiplier
  static double _activityMultiplier(ActivityLevel level) {
    switch (level) {
      case ActivityLevel.sedentary: return 1.2;
      case ActivityLevel.light: return 1.375;
      case ActivityLevel.moderate: return 1.55;
      case ActivityLevel.active: return 1.725;
      case ActivityLevel.veryActive: return 1.9;
    }
  }

  /// Calculate TDEE (Total Daily Energy Expenditure)
  static double calculateTdee({
    required double weightKg,
    required double heightCm,
    required int age,
    required Gender gender,
    required ActivityLevel activityLevel,
  }) {
    final bmr = calculateBmr(
      weightKg: weightKg,
      heightCm: heightCm,
      age: age,
      gender: gender,
    );
    return bmr * _activityMultiplier(activityLevel);
  }

  /// Calculate daily calorie target based on goal
  static double dailyCalorieTarget({
    required double weightKg,
    required double heightCm,
    required int age,
    required Gender gender,
    required ActivityLevel activityLevel,
    required WeightGoal goal,
  }) {
    final tdee = calculateTdee(
      weightKg: weightKg,
      heightCm: heightCm,
      age: age,
      gender: gender,
      activityLevel: activityLevel,
    );
    switch (goal) {
      case WeightGoal.lose: return tdee - 500; // ~0.5kg/week deficit
      case WeightGoal.maintain: return tdee;
      case WeightGoal.gain: return tdee + 300; // lean bulk
    }
  }

  /// Calculate weight progress percentage
  static double progressPercentage({
    required double startWeight,
    required double currentWeight,
    required double targetWeight,
  }) {
    final totalToLose = (startWeight - targetWeight).abs();
    if (totalToLose == 0) return 1.0;
    final lost = (startWeight - currentWeight).abs();
    return (lost / totalToLose).clamp(0.0, 1.0);
  }

  /// Estimate target date based on current trend
  static DateTime? estimateTargetDate({
    required double currentWeight,
    required double targetWeight,
    required double weeklyChangeRate, // kg per week (negative = losing)
  }) {
    if (weeklyChangeRate == 0) return null;
    final remaining = (currentWeight - targetWeight).abs();
    final weeksNeeded = remaining / weeklyChangeRate.abs();
    if (weeksNeeded < 0) return null;
    return DateTime.now().add(Duration(days: (weeksNeeded * 7).round()));
  }

  /// Calculate weekly average from weight entries
  static double weeklyAverage(List<double> weights) {
    if (weights.isEmpty) return 0;
    return weights.reduce((a, b) => a + b) / weights.length;
  }

  /// Calculate streak from habit logs
  static int calculateStreak(List<DateTime> completedDates) {
    if (completedDates.isEmpty) return 0;
    final sorted = completedDates.toList()
      ..sort((a, b) => b.compareTo(a));
    
    int streak = 0;
    DateTime? expectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    
    for (final date in sorted) {
      final logDate = DateTime(date.year, date.month, date.day);
      if (logDate == expectedDate) {
        streak++;
        expectedDate = expectedDate!.subtract(const Duration(days: 1));
      } else if (logDate.isBefore(expectedDate!)) {
        break;
      }
    }
    return streak;
  }

  /// Habit completion rate for a period
  static double completionRate({
    required int completedDays,
    required int totalDays,
  }) {
    if (totalDays == 0) return 0;
    return completedDays / totalDays;
  }

  /// Generate smart insights based on data
  static List<String> generateInsights({
    required double currentWeight,
    required double targetWeight,
    required List<double> recentWeights,
    required double waterConsumed,
    required double waterGoal,
    required int habitStreak,
  }) {
    final insights = <String>[];
    
    // Progress insight
    final diff = (currentWeight - targetWeight).abs();
    if (diff <= 2) {
      insights.add('insightCloseTarget');
    } else if (recentWeights.length >= 7) {
      final firstHalf = recentWeights.take(recentWeights.length ~/ 2).toList();
      final secondHalf = recentWeights.skip(recentWeights.length ~/ 2).toList();
      final avgFirst = firstHalf.reduce((a, b) => a + b) / firstHalf.length;
      final avgSecond = secondHalf.reduce((a, b) => a + b) / secondHalf.length;
      if ((avgFirst - avgSecond).abs() < 0.3) {
        insights.add('insightPlateau');
      } else {
        insights.add('insightProgressing');
      }
    }
    
    // Water insight
    if (waterConsumed < waterGoal * 0.5) {
      insights.add('insightWaterLow');
    }
    
    // Streak insight
    if (habitStreak >= 3) {
      insights.add('insightStreakImproving');
    }
    
    return insights;
  }

  /// Recommended daily water intake in ml
  static double recommendedWaterIntake(double weightKg) {
    return weightKg * 35; // 35ml per kg body weight
  }
}