import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/weight_entry.dart';

/// Manages local storage using Hive
class LocalStorage {
  static const String _userBoxName = 'user_profile';
  static const String _weightBoxName = 'weight_entries';
  static const String _appSettingsBoxName = 'app_settings';
  
  static late Box _userBox;
  static late Box _weightBox;
  static late Box _settingsBox;
  
  /// Initialize Hive and open boxes
  static Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    
    // Register adapters if needed (simplified for now)
    // In production, create HiveType adapters for UserProfile/WeightEntry
    
    _userBox = await Hive.openBox(_userBoxName);
    _weightBox = await Hive.openBox(_weightBoxName);
    _settingsBox = await Hive.openBox(_appSettingsBoxName);
  }
  
  // ─── User Profile ──────────────────────────────────────────────────────────
  
  /// Save user profile to local storage
  static Future<void> saveUserProfile(UserProfile user) async {
    try {
      final json = user.toJson();
      await _userBox.put('current_user', jsonEncode(json));
      await _userBox.put('is_onboarded', user.isOnboarded);
      
      // Also save some essential info to settings for quick access
      await _settingsBox.put('is_onboarded', user.isOnboarded);
      await _settingsBox.put('user_id', user.id);
    } catch (e) {
      print('Error saving user profile: $e');
      rethrow;
    }
  }
  
  /// Load user profile from local storage
  static Future<UserProfile?> loadUserProfile() async {
    try {
      final userJson = _userBox.get('current_user');
      if (userJson == null) return null;
      
      final jsonMap = jsonDecode(userJson);
      return UserProfile.fromJson(jsonMap);
    } catch (e) {
      print('Error loading user profile: $e');
      return null;
    }
  }
  
  /// Check if user has completed onboarding
  static bool get isOnboarded {
    try {
      return _userBox.get('is_onboarded', defaultValue: false) ||
             _settingsBox.get('is_onboarded', defaultValue: false);
    } catch (e) {
      print('Error checking onboarding status: $e');
      return false;
    }
  }
  
  /// Delete user profile (for logout)
  static Future<void> deleteUserProfile() async {
    await _userBox.clear();
    await _settingsBox.delete('is_onboarded');
    await _settingsBox.delete('user_id');
  }
  
  // ─── Weight Entries ───────────────────────────────────────────────────────
  
  /// Save weight entry
  static Future<void> saveWeightEntry(WeightEntry entry) async {
    try {
      final key = entry.date.toIso8601String();
      final json = entry.toJson();
      await _weightBox.put(key, jsonEncode(json));
      
      // Also update the latest weight reference
      await _userBox.put('latest_weight', entry.weight);
      await _userBox.put('latest_weight_date', entry.date.toIso8601String());
    } catch (e) {
      print('Error saving weight entry: $e');
      rethrow;
    }
  }
  
  /// Load all weight entries
  static Future<List<WeightEntry>> loadWeightEntries() async {
    try {
      final entries = <WeightEntry>[];
      final keys = _weightBox.keys;
      
      for (final key in keys) {
        try {
          final json = _weightBox.get(key);
          if (json != null) {
            final jsonMap = jsonDecode(json);
            entries.add(WeightEntry.fromJson(jsonMap));
          }
        } catch (e) {
          print('Error parsing weight entry for key $key: $e');
        }
      }
      
      // Sort by date (newest first)
      entries.sort((a, b) => b.date.compareTo(a.date));
      return entries;
    } catch (e) {
      print('Error loading weight entries: $e');
      return [];
    }
  }
  
  /// Get the most recent weight entry
  static Future<WeightEntry?> getLatestWeight() async {
    try {
      final entries = await loadWeightEntries();
      if (entries.isNotEmpty) {
        return entries.first;
      }
      return null;
    } catch (e) {
      print('Error getting latest weight: $e');
      return null;
    }
  }
  
  /// Delete weight entry
  static Future<void> deleteWeightEntry(DateTime date) async {
    try {
      final key = date.toIso8601String();
      await _weightBox.delete(key);
    } catch (e) {
      print('Error deleting weight entry: $e');
      rethrow;
    }
  }
  
  /// Clear all weight entries
  static Future<void> clearWeightEntries() async {
    await _weightBox.clear();
  }
  
  // ─── App Settings ─────────────────────────────────────────────────────────
  
  static Future<void> saveSetting(String key, dynamic value) async {
    await _settingsBox.put(key, value);
  }
  
  static dynamic getSetting(String key, {dynamic defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue);
  }
  
  static Future<void> deleteSetting(String key) async {
    await _settingsBox.delete(key);
  }
  
  // ─── Utils ────────────────────────────────────────────────────────────────
  
  /// Close all boxes
  static Future<void> close() async {
    await _userBox.close();
    await _weightBox.close();
    await _settingsBox.close();
  }
}