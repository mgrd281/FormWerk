import 'package:equatable/equatable.dart';

/// Gender options
enum Gender { male, female, other }

/// Weight goal types
enum WeightGoal { lose, maintain, gain }

/// Activity levels
enum ActivityLevel {
  sedentary, // Little or no exercise
  light, // Light exercise 1-3 days/week
  moderate, // Moderate exercise 3-5 days/week
  active, // Hard exercise 6-7 days/week
  veryActive, // Very hard exercise, physical job
}

/// Unit systems
enum UnitSystem { metric, imperial }

/// Dietary preferences
enum DietaryPreference {
  none,
  vegetarian,
  vegan,
  keto,
  paleo,
  mediterranean,
}

/// User profile entity – core user data
class UserProfile extends Equatable {
  final String id;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final Gender gender;
  final int age;
  final double height; // cm
  final double currentWeight; // kg
  final double targetWeight; // kg
  final WeightGoal goal;
  final ActivityLevel activityLevel;
  final UnitSystem unitSystem;
  final DietaryPreference dietaryPreference;
  final bool isOnboarded;
  final String preferredLanguage; // 'de' or 'ar'
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    this.email,
    this.displayName,
    this.photoUrl,
    this.gender = Gender.male,
    this.age = 25,
    this.height = 170,
    this.currentWeight = 70,
    this.targetWeight = 65,
    this.goal = WeightGoal.lose,
    this.activityLevel = ActivityLevel.moderate,
    this.unitSystem = UnitSystem.metric,
    this.dietaryPreference = DietaryPreference.none,
    this.isOnboarded = false,
    this.preferredLanguage = 'de',
    required this.createdAt,
    required this.updatedAt,
  });

  /// Calculate BMI
  double get bmi {
    if (height <= 0) return 0;
    final heightInMeters = height / 100;
    return currentWeight / (heightInMeters * heightInMeters);
  }

  /// Weight difference to target
  double get weightDifference => (currentWeight - targetWeight).abs();

  /// Progress percentage toward target
  double get progressPercentage {
    // This is a simplified calculation
    // In production, you'd use starting weight from first entry
    if (currentWeight == targetWeight) return 1.0;
    return 0.0; // Will be calculated with actual data
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    Gender? gender,
    int? age,
    double? height,
    double? currentWeight,
    double? targetWeight,
    WeightGoal? goal,
    ActivityLevel? activityLevel,
    UnitSystem? unitSystem,
    DietaryPreference? dietaryPreference,
    bool? isOnboarded,
    String? preferredLanguage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      currentWeight: currentWeight ?? this.currentWeight,
      targetWeight: targetWeight ?? this.targetWeight,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
      unitSystem: unitSystem ?? this.unitSystem,
      dietaryPreference: dietaryPreference ?? this.dietaryPreference,
      isOnboarded: isOnboarded ?? this.isOnboarded,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, email, displayName, photoUrl, gender, age, height,
        currentWeight, targetWeight, goal, activityLevel, unitSystem,
        dietaryPreference, isOnboarded, preferredLanguage, createdAt, updatedAt,
      ];

  /// Convert to JSON for serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'gender': gender.name,
      'age': age,
      'height': height,
      'currentWeight': currentWeight,
      'targetWeight': targetWeight,
      'goal': goal.name,
      'activityLevel': activityLevel.name,
      'unitSystem': unitSystem.name,
      'dietaryPreference': dietaryPreference.name,
      'isOnboarded': isOnboarded,
      'preferredLanguage': preferredLanguage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Create from JSON
  static UserProfile fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      gender: Gender.values.firstWhere((e) => e.name == json['gender'], orElse: () => Gender.male),
      age: json['age'] as int,
      height: (json['height'] as num).toDouble(),
      currentWeight: (json['currentWeight'] as num).toDouble(),
      targetWeight: (json['targetWeight'] as num).toDouble(),
      goal: WeightGoal.values.firstWhere((e) => e.name == json['goal'], orElse: () => WeightGoal.lose),
      activityLevel: ActivityLevel.values.firstWhere((e) => e.name == json['activityLevel'], orElse: () => ActivityLevel.moderate),
      unitSystem: UnitSystem.values.firstWhere((e) => e.name == json['unitSystem'], orElse: () => UnitSystem.metric),
      dietaryPreference: DietaryPreference.values.firstWhere((e) => e.name == json['dietaryPreference'], orElse: () => DietaryPreference.none),
      isOnboarded: json['isOnboarded'] as bool,
      preferredLanguage: json['preferredLanguage'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}