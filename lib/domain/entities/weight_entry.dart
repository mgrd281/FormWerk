import 'package:equatable/equatable.dart';

/// Weight entry entity
class WeightEntry extends Equatable {
  final String id;
  final String userId;
  final double weight; // kg
  final DateTime date;
  final String? note;
  final DateTime createdAt;

  const WeightEntry({
    required this.id,
    required this.userId,
    required this.weight,
    required this.date,
    this.note,
    required this.createdAt,
  });

  WeightEntry copyWith({
    String? id,
    String? userId,
    double? weight,
    DateTime? date,
    String? note,
    DateTime? createdAt,
  }) {
    return WeightEntry(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weight: weight ?? this.weight,
      date: date ?? this.date,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, weight, date, note, createdAt];
}

/// Body measurement entity
class BodyMeasurement extends Equatable {
  final String id;
  final String userId;
  final double? waist;
  final double? chest;
  final double? hips;
  final double? arms;
  final double? thighs;
  final double? neck;
  final double? bodyFatPercentage;
  final DateTime date;
  final DateTime createdAt;

  const BodyMeasurement({
    required this.id,
    required this.userId,
    this.waist,
    this.chest,
    this.hips,
    this.arms,
    this.thighs,
    this.neck,
    this.bodyFatPercentage,
    required this.date,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id, userId, waist, chest, hips, arms, thighs, neck,
        bodyFatPercentage, date, createdAt,
      ];
}

/// Meal type
enum MealType { breakfast, lunch, dinner, snack }

/// Meal entry entity
class MealEntry extends Equatable {
  final String id;
  final String userId;
  final String name;
  final MealType mealType;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final bool isFavorite;
  final DateTime date;
  final DateTime createdAt;

  const MealEntry({
    required this.id,
    required this.userId,
    required this.name,
    required this.mealType,
    required this.calories,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.isFavorite = false,
    required this.date,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id, userId, name, mealType, calories, protein, carbs, fat,
        isFavorite, date, createdAt,
      ];
}

/// Water log entity
class WaterLog extends Equatable {
  final String id;
  final String userId;
  final double amount; // ml
  final DateTime date;
  final DateTime createdAt;

  const WaterLog({
    required this.id,
    required this.userId,
    required this.amount,
    required this.date,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, amount, date, createdAt];
}

/// Workout category
enum WorkoutCategory { walking, running, strength, cycling, homeWorkout, other }

/// Workout entry entity
class WorkoutEntry extends Equatable {
  final String id;
  final String userId;
  final String? name;
  final WorkoutCategory category;
  final int durationMinutes;
  final double caloriesBurned;
  final String? notes;
  final DateTime date;
  final DateTime createdAt;

  const WorkoutEntry({
    required this.id,
    required this.userId,
    this.name,
    required this.category,
    required this.durationMinutes,
    this.caloriesBurned = 0,
    this.notes,
    required this.date,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id, userId, name, category, durationMinutes, caloriesBurned,
        notes, date, createdAt,
      ];
}

/// Habit entity
class Habit extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String iconKey;
  final bool isActive;
  final int currentStreak;
  final int longestStreak;
  final DateTime createdAt;

  const Habit({
    required this.id,
    required this.userId,
    required this.name,
    required this.iconKey,
    this.isActive = true,
    this.currentStreak = 0,
    this.longestStreak = 0,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id, userId, name, iconKey, isActive, currentStreak,
        longestStreak, createdAt,
      ];
}

/// Habit log entry (completion record)
class HabitLog extends Equatable {
  final String id;
  final String habitId;
  final String userId;
  final DateTime date;
  final bool completed;
  final DateTime createdAt;

  const HabitLog({
    required this.id,
    required this.habitId,
    required this.userId,
    required this.date,
    required this.completed,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, habitId, userId, date, completed, createdAt];
}