import '../entities/user_profile.dart';
import '../entities/weight_entry.dart';

/// Repository interfaces – contracts for data operations

abstract class UserProfileRepository {
  Future<UserProfile?> getProfile(String userId);
  Future<void> saveProfile(UserProfile profile);
  Future<void> updateProfile(String userId, Map<String, dynamic> data);
  Stream<UserProfile?> watchProfile(String userId);
}

abstract class WeightRepository {
  Future<List<WeightEntry>> getWeights(String userId, {DateTime? startDate, DateTime? endDate});
  Future<WeightEntry?> getLatestWeight(String userId);
  Future<void> addWeight(WeightEntry entry);
  Future<void> updateWeight(WeightEntry entry);
  Future<void> deleteWeight(String userId, String entryId);
  Stream<List<WeightEntry>> watchWeights(String userId);
}

abstract class MeasurementRepository {
  Future<List<BodyMeasurement>> getMeasurements(String userId, {DateTime? startDate, DateTime? endDate});
  Future<BodyMeasurement?> getLatestMeasurement(String userId);
  Future<void> addMeasurement(BodyMeasurement measurement);
  Future<void> deleteMeasurement(String userId, String measurementId);
}

abstract class MealRepository {
  Future<List<MealEntry>> getMeals(String userId, {DateTime? date});
  Future<void> addMeal(MealEntry entry);
  Future<void> deleteMeal(String userId, String entryId);
  Future<List<MealEntry>> getFavoriteMeals(String userId);
}

abstract class WaterRepository {
  Future<List<WaterLog>> getWaterLogs(String userId, {DateTime? date});
  Future<double> getTodayWaterTotal(String userId);
  Future<void> addWaterLog(WaterLog log);
  Future<void> deleteWaterLog(String userId, String logId);
}

abstract class WorkoutRepository {
  Future<List<WorkoutEntry>> getWorkouts(String userId, {DateTime? startDate, DateTime? endDate});
  Future<void> addWorkout(WorkoutEntry entry);
  Future<void> deleteWorkout(String userId, String entryId);
}

abstract class HabitRepository {
  Future<List<Habit>> getHabits(String userId);
  Future<void> addHabit(Habit habit);
  Future<void> updateHabit(Habit habit);
  Future<void> deleteHabit(String userId, String habitId);
  Future<List<HabitLog>> getHabitLogs(String userId, {DateTime? date});
  Future<void> logHabitCompletion(HabitLog log);
  Stream<List<Habit>> watchHabits(String userId);
}

abstract class AuthRepository {
  Future<UserProfile?> signInWithEmail(String email, String password);
  Future<UserProfile?> signUpWithEmail(String email, String password);
  Future<UserProfile?> signInWithGoogle();
  Future<UserProfile?> signInWithApple();
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Stream<UserProfile?> get authStateChanges;
  UserProfile? get currentUser;
}