import '../../domain/entities/user_profile.dart';
import '../../domain/entities/weight_entry.dart';

// ─── User Profile Model ───────────────────────────────────────────
class UserProfileModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final Gender gender;
  final int age;
  final double heightCm;
  final double currentWeightKg;
  final double targetWeightKg;
  final ActivityLevel activityLevel;
  final WeightGoal goal;
  final UnitSystem unitSystem;
  final DietaryPreference dietaryPreference;
  final double dailyCalorieTarget;
  final int dailyWaterGoalMl;
  final String locale;
  final String themeMode;
  final bool isOnboarded;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfileModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.gender,
    required this.age,
    required this.heightCm,
    required this.currentWeightKg,
    required this.targetWeightKg,
    required this.activityLevel,
    required this.goal,
    required this.unitSystem,
    this.dietaryPreference = DietaryPreference.none,
    required this.dailyCalorieTarget,
    required this.dailyWaterGoalMl,
    required this.locale,
    required this.themeMode,
    this.isOnboarded = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> data) {
    return UserProfileModel(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'],
      gender: _parseGender(data['gender']),
      age: data['age'] ?? 25,
      heightCm: (data['heightCm'] ?? 170).toDouble(),
      currentWeightKg: (data['currentWeightKg'] ?? 70).toDouble(),
      targetWeightKg: (data['targetWeightKg'] ?? 65).toDouble(),
      activityLevel: _parseActivityLevel(data['activityLevel']),
      goal: _parseWeightGoal(data['goal']),
      unitSystem: _parseUnitSystem(data['unitSystem']),
      dietaryPreference: _parseDietaryPreference(data['dietaryPreference']),
      dailyCalorieTarget: (data['dailyCalorieTarget'] ?? 2000).toDouble(),
      dailyWaterGoalMl: data['dailyWaterGoalMl'] ?? 2500,
      locale: data['locale'] ?? 'de',
      themeMode: data['themeMode'] ?? 'system',
      isOnboarded: data['isOnboarded'] ?? false,
      createdAt: data['createdAt'] is DateTime
          ? data['createdAt']
          : DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: data['updatedAt'] is DateTime
          ? data['updatedAt']
          : DateTime.tryParse(data['updatedAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'displayName': displayName,
        'photoUrl': photoUrl,
        'gender': gender.name,
        'age': age,
        'heightCm': heightCm,
        'currentWeightKg': currentWeightKg,
        'targetWeightKg': targetWeightKg,
        'activityLevel': activityLevel.name,
        'goal': goal.name,
        'unitSystem': unitSystem.name,
        'dietaryPreference': dietaryPreference.name,
        'dailyCalorieTarget': dailyCalorieTarget,
        'dailyWaterGoalMl': dailyWaterGoalMl,
        'locale': locale,
        'themeMode': themeMode,
        'isOnboarded': isOnboarded,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  UserProfile toEntity() => UserProfile(
        id: uid,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
        gender: gender,
        age: age,
        height: heightCm,
        currentWeight: currentWeightKg,
        targetWeight: targetWeightKg,
        goal: goal,
        activityLevel: activityLevel,
        unitSystem: unitSystem,
        dietaryPreference: dietaryPreference,
        isOnboarded: isOnboarded,
        preferredLanguage: locale,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static Gender _parseGender(dynamic value) {
    if (value is Gender) return value;
    return Gender.values.firstWhere(
      (e) => e.name == value.toString(),
      orElse: () => Gender.male,
    );
  }

  static ActivityLevel _parseActivityLevel(dynamic value) {
    if (value is ActivityLevel) return value;
    return ActivityLevel.values.firstWhere(
      (e) => e.name == value.toString(),
      orElse: () => ActivityLevel.moderate,
    );
  }

  static WeightGoal _parseWeightGoal(dynamic value) {
    if (value is WeightGoal) return value;
    return WeightGoal.values.firstWhere(
      (e) => e.name == value.toString(),
      orElse: () => WeightGoal.maintain,
    );
  }

  static UnitSystem _parseUnitSystem(dynamic value) {
    if (value is UnitSystem) return value;
    return UnitSystem.values.firstWhere(
      (e) => e.name == value.toString(),
      orElse: () => UnitSystem.metric,
    );
  }

  static DietaryPreference _parseDietaryPreference(dynamic value) {
    if (value is DietaryPreference) return value;
    return DietaryPreference.values.firstWhere(
      (e) => e.name == value.toString(),
      orElse: () => DietaryPreference.none,
    );
  }
}

// ─── Weight Entry Model ───────────────────────────────────────────
class WeightEntryModel {
  final String id;
  final String userId;
  final DateTime date;
  final double weightKg;
  final String? note;
  final DateTime createdAt;

  const WeightEntryModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.weightKg,
    this.note,
    required this.createdAt,
  });

  factory WeightEntryModel.fromJson(Map<String, dynamic> data) {
    return WeightEntryModel(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      date: data['date'] is DateTime
          ? data['date']
          : DateTime.tryParse(data['date']?.toString() ?? '') ?? DateTime.now(),
      weightKg: (data['weightKg'] ?? 0).toDouble(),
      note: data['note'],
      createdAt: data['createdAt'] is DateTime
          ? data['createdAt']
          : DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'date': date.toIso8601String(),
        'weightKg': weightKg,
        'note': note,
        'createdAt': createdAt.toIso8601String(),
      };

  WeightEntry toEntity() => WeightEntry(
        id: id,
        userId: userId,
        weight: weightKg,
        date: date,
        note: note,
        createdAt: createdAt,
      );
}

// ─── Body Measurement Model ───────────────────────────────────────
class BodyMeasurementModel {
  final String id;
  final String userId;
  final DateTime date;
  final double? waistCm, chestCm, hipsCm, armsCm, thighsCm, neckCm, bodyFatPercent;
  final DateTime createdAt;

  const BodyMeasurementModel({
    required this.id,
    required this.userId,
    required this.date,
    this.waistCm,
    this.chestCm,
    this.hipsCm,
    this.armsCm,
    this.thighsCm,
    this.neckCm,
    this.bodyFatPercent,
    required this.createdAt,
  });

  factory BodyMeasurementModel.fromJson(Map<String, dynamic> data) {
    return BodyMeasurementModel(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      date: data['date'] is DateTime
          ? data['date']
          : DateTime.tryParse(data['date']?.toString() ?? '') ?? DateTime.now(),
      waistCm: (data['waistCm'] as num?)?.toDouble(),
      chestCm: (data['chestCm'] as num?)?.toDouble(),
      hipsCm: (data['hipsCm'] as num?)?.toDouble(),
      armsCm: (data['armsCm'] as num?)?.toDouble(),
      thighsCm: (data['thighsCm'] as num?)?.toDouble(),
      neckCm: (data['neckCm'] as num?)?.toDouble(),
      bodyFatPercent: (data['bodyFatPercent'] as num?)?.toDouble(),
      createdAt: data['createdAt'] is DateTime
          ? data['createdAt']
          : DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'date': date.toIso8601String(),
        'waistCm': waistCm,
        'chestCm': chestCm,
        'hipsCm': hipsCm,
        'armsCm': armsCm,
        'thighsCm': thighsCm,
        'neckCm': neckCm,
        'bodyFatPercent': bodyFatPercent,
        'createdAt': createdAt.toIso8601String(),
      };

  BodyMeasurement toEntity() => BodyMeasurement(
        id: id,
        userId: userId,
        waist: waistCm,
        chest: chestCm,
        hips: hipsCm,
        arms: armsCm,
        thighs: thighsCm,
        neck: neckCm,
        bodyFatPercentage: bodyFatPercent,
        date: date,
        createdAt: createdAt,
      );
}

// ─── Meal Model ───────────────────────────────────────────────────
class MealModel {
  final String id;
  final String userId;
  final DateTime date;
  final MealType mealType;
  final String name;
  final double caloriesKcal;
  final double proteinG, carbsG, fatG;
  final bool isFavorite;
  final DateTime createdAt;

  const MealModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.mealType,
    required this.name,
    required this.caloriesKcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    this.isFavorite = false,
    required this.createdAt,
  });

  factory MealModel.fromJson(Map<String, dynamic> data) {
    return MealModel(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      date: data['date'] is DateTime
          ? data['date']
          : DateTime.tryParse(data['date']?.toString() ?? '') ?? DateTime.now(),
      mealType: MealType.values.firstWhere(
        (e) => e.name == (data['mealType'] ?? 'snack').toString(),
        orElse: () => MealType.snack,
      ),
      name: data['name'] ?? '',
      caloriesKcal: (data['caloriesKcal'] ?? 0).toDouble(),
      proteinG: (data['proteinG'] ?? 0).toDouble(),
      carbsG: (data['carbsG'] ?? 0).toDouble(),
      fatG: (data['fatG'] ?? 0).toDouble(),
      isFavorite: data['isFavorite'] ?? false,
      createdAt: data['createdAt'] is DateTime
          ? data['createdAt']
          : DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'date': date.toIso8601String(),
        'mealType': mealType.name,
        'name': name,
        'caloriesKcal': caloriesKcal,
        'proteinG': proteinG,
        'carbsG': carbsG,
        'fatG': fatG,
        'isFavorite': isFavorite,
        'createdAt': createdAt.toIso8601String(),
      };

  MealEntry toEntity() => MealEntry(
        id: id,
        userId: userId,
        name: name,
        mealType: mealType,
        calories: caloriesKcal,
        protein: proteinG,
        carbs: carbsG,
        fat: fatG,
        isFavorite: isFavorite,
        date: date,
        createdAt: createdAt,
      );
}

// ─── Water Log Model ──────────────────────────────────────────────
class WaterLogModel {
  final String id;
  final String userId;
  final DateTime date;
  final double amountMl;
  final DateTime createdAt;

  const WaterLogModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.amountMl,
    required this.createdAt,
  });

  factory WaterLogModel.fromJson(Map<String, dynamic> data) {
    return WaterLogModel(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      date: data['date'] is DateTime
          ? data['date']
          : DateTime.tryParse(data['date']?.toString() ?? '') ?? DateTime.now(),
      amountMl: (data['amountMl'] ?? 0).toDouble(),
      createdAt: data['createdAt'] is DateTime
          ? data['createdAt']
          : DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'date': date.toIso8601String(),
        'amountMl': amountMl,
        'createdAt': createdAt.toIso8601String(),
      };

  WaterLog toEntity() => WaterLog(
        id: id,
        userId: userId,
        amount: amountMl,
        date: date,
        createdAt: createdAt,
      );
}

// ─── Workout Model ────────────────────────────────────────────────
class WorkoutModel {
  final String id;
  final String userId;
  final DateTime date;
  final WorkoutCategory category;
  final int durationMin;
  final double? caloriesBurned;
  final String? notes;
  final DateTime createdAt;

  const WorkoutModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.category,
    required this.durationMin,
    this.caloriesBurned,
    this.notes,
    required this.createdAt,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> data) {
    return WorkoutModel(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      date: data['date'] is DateTime
          ? data['date']
          : DateTime.tryParse(data['date']?.toString() ?? '') ?? DateTime.now(),
      category: WorkoutCategory.values.firstWhere(
        (e) => e.name == (data['category'] ?? 'other').toString(),
        orElse: () => WorkoutCategory.other,
      ),
      durationMin: data['durationMin'] ?? 0,
      caloriesBurned: (data['caloriesBurned'] as num?)?.toDouble(),
      notes: data['notes'],
      createdAt: data['createdAt'] is DateTime
          ? data['createdAt']
          : DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'date': date.toIso8601String(),
        'category': category.name,
        'durationMin': durationMin,
        'caloriesBurned': caloriesBurned,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
      };

  WorkoutEntry toEntity() => WorkoutEntry(
        id: id,
        userId: userId,
        category: category,
        durationMinutes: durationMin,
        caloriesBurned: caloriesBurned ?? 0,
        notes: notes,
        date: date,
        createdAt: createdAt,
      );
}