import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/weight_entry.dart';

// ─── User Profile Model ───────────────────────────────────────────
class UserProfileModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String gender;
  final int age;
  final double heightCm;
  final double currentWeightKg;
  final double targetWeightKg;
  final String activityLevel;
  final String goal;
  final String unitSystem;
  final String? dietaryPreference;
  final double dailyCalorieTarget;
  final int dailyWaterGoalMl;
  final String locale;
  final String themeMode;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfileModel({
    required this.uid, required this.email, required this.displayName,
    this.photoUrl, required this.gender, required this.age,
    required this.heightCm, required this.currentWeightKg,
    required this.targetWeightKg, required this.activityLevel,
    required this.goal, required this.unitSystem,
    this.dietaryPreference, required this.dailyCalorieTarget,
    required this.dailyWaterGoalMl, required this.locale,
    required this.themeMode, required this.createdAt, required this.updatedAt,
  });

  factory UserProfileModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfileModel(
      uid: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'],
      gender: data['gender'] ?? 'male',
      age: data['age'] ?? 25,
      heightCm: (data['heightCm'] ?? 170).toDouble(),
      currentWeightKg: (data['currentWeightKg'] ?? 70).toDouble(),
      targetWeightKg: (data['targetWeightKg'] ?? 65).toDouble(),
      activityLevel: data['activityLevel'] ?? 'moderate',
      goal: data['goal'] ?? 'maintain',
      unitSystem: data['unitSystem'] ?? 'metric',
      dietaryPreference: data['dietaryPreference'],
      dailyCalorieTarget: (data['dailyCalorieTarget'] ?? 2000).toDouble(),
      dailyWaterGoalMl: data['dailyWaterGoalMl'] ?? 2500,
      locale: data['locale'] ?? 'de',
      themeMode: data['themeMode'] ?? 'system',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'email': email, 'displayName': displayName, 'photoUrl': photoUrl,
    'gender': gender, 'age': age, 'heightCm': heightCm,
    'currentWeightKg': currentWeightKg, 'targetWeightKg': targetWeightKg,
    'activityLevel': activityLevel, 'goal': goal, 'unitSystem': unitSystem,
    'dietaryPreference': dietaryPreference, 'dailyCalorieTarget': dailyCalorieTarget,
    'dailyWaterGoalMl': dailyWaterGoalMl, 'locale': locale, 'themeMode': themeMode,
    'createdAt': FieldValue.serverTimestamp(), 'updatedAt': FieldValue.serverTimestamp(),
  };

  UserProfile toEntity() => UserProfile(
    uid: uid, email: email, displayName: displayName, photoUrl: photoUrl,
    gender: gender, age: age, heightCm: heightCm, currentWeightKg: currentWeightKg,
    targetWeightKg: targetWeightKg, activityLevel: activityLevel, goal: goal,
    unitSystem: unitSystem, dietaryPreference: dietaryPreference,
    dailyCalorieTarget: dailyCalorieTarget, dailyWaterGoalMl: dailyWaterGoalMl,
    locale: locale, themeMode: themeMode,
  );
}

// ─── Weight Entry Model ───────────────────────────────────────────
class WeightEntryModel {
  final String id;
  final DateTime date;
  final double weightKg;
  final String? note;
  final DateTime createdAt;

  const WeightEntryModel({
    required this.id, required this.date, required this.weightKg,
    this.note, required this.createdAt,
  });

  factory WeightEntryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WeightEntryModel(
      id: doc.id,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      weightKg: (data['weightKg'] ?? 0).toDouble(),
      note: data['note'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'date': Timestamp.fromDate(date), 'weightKg': weightKg, 'note': note,
    'createdAt': FieldValue.serverTimestamp(),
  };

  WeightEntry toEntity() => WeightEntry(
    id: id, date: date, weightKg: weightKg, note: note,
  );
}

// ─── Body Measurement Model ───────────────────────────────────────
class BodyMeasurementModel {
  final String id;
  final DateTime date;
  final double? waistCm, chestCm, hipsCm, armsCm, thighsCm, neckCm, bodyFatPercent;
  final DateTime createdAt;

  const BodyMeasurementModel({
    required this.id, required this.date, this.waistCm, this.chestCm,
    this.hipsCm, this.armsCm, this.thighsCm, this.neckCm,
    this.bodyFatPercent, required this.createdAt,
  });

  factory BodyMeasurementModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return BodyMeasurementModel(
      id: doc.id,
      date: (d['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      waistCm: (d['waistCm'] as num?)?.toDouble(),
      chestCm: (d['chestCm'] as num?)?.toDouble(),
      hipsCm: (d['hipsCm'] as num?)?.toDouble(),
      armsCm: (d['armsCm'] as num?)?.toDouble(),
      thighsCm: (d['thighsCm'] as num?)?.toDouble(),
      neckCm: (d['neckCm'] as num?)?.toDouble(),
      bodyFatPercent: (d['bodyFatPercent'] as num?)?.toDouble(),
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'date': Timestamp.fromDate(date), 'waistCm': waistCm, 'chestCm': chestCm,
    'hipsCm': hipsCm, 'armsCm': armsCm, 'thighsCm': thighsCm,
    'neckCm': neckCm, 'bodyFatPercent': bodyFatPercent,
    'createdAt': FieldValue.serverTimestamp(),
  };
}

// ─── Meal Model ───────────────────────────────────────────────────
class MealModel {
  final String id;
  final DateTime date;
  final String mealType;
  final String name;
  final double caloriesKcal;
  final double proteinG, carbsG, fatG;
  final bool isFavorite;
  final DateTime createdAt;

  const MealModel({
    required this.id, required this.date, required this.mealType,
    required this.name, required this.caloriesKcal,
    required this.proteinG, required this.carbsG, required this.fatG,
    this.isFavorite = false, required this.createdAt,
  });

  factory MealModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return MealModel(
      id: doc.id,
      date: (d['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      mealType: d['mealType'] ?? 'breakfast',
      name: d['name'] ?? '',
      caloriesKcal: (d['caloriesKcal'] ?? 0).toDouble(),
      proteinG: (d['proteinG'] ?? 0).toDouble(),
      carbsG: (d['carbsG'] ?? 0).toDouble(),
      fatG: (d['fatG'] ?? 0).toDouble(),
      isFavorite: d['isFavorite'] ?? false,
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'date': Timestamp.fromDate(date), 'mealType': mealType, 'name': name,
    'caloriesKcal': caloriesKcal, 'proteinG': proteinG, 'carbsG': carbsG,
    'fatG': fatG, 'isFavorite': isFavorite, 'createdAt': FieldValue.serverTimestamp(),
  };
}

// ─── Water Log Model ──────────────────────────────────────────────
class WaterLogModel {
  final String id;
  final DateTime date;
  final double amountMl;
  final DateTime createdAt;

  const WaterLogModel({required this.id, required this.date, required this.amountMl, required this.createdAt});

  factory WaterLogModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return WaterLogModel(
      id: doc.id,
      date: (d['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      amountMl: (d['amountMl'] ?? 0).toDouble(),
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'date': Timestamp.fromDate(date), 'amountMl': amountMl,
    'createdAt': FieldValue.serverTimestamp(),
  };
}

// ─── Workout Model ────────────────────────────────────────────────
class WorkoutModel {
  final String id;
  final DateTime date;
  final String category;
  final int durationMin;
  final double? caloriesBurned;
  final String? notes;
  final DateTime createdAt;

  const WorkoutModel({
    required this.id, required this.date, required this.category,
    required this.durationMin, this.caloriesBurned, this.notes, required this.createdAt,
  });

  factory WorkoutModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return WorkoutModel(
      id: doc.id,
      date: (d['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      category: d['category'] ?? 'other',
      durationMin: d['durationMin'] ?? 0,
      caloriesBurned: (d['caloriesBurned'] as num?)?.toDouble(),
      notes: d['notes'],
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'date': Timestamp.fromDate(date), 'category': category,
    'durationMin': durationMin, 'caloriesBurned': caloriesBurned,
    'notes': notes, 'createdAt': FieldValue.serverTimestamp(),
  };
}