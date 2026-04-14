import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/providers/app_providers.dart';
import '../../core/widgets/app_widgets.dart';
import '../../domain/entities/weight_entry.dart';
import '../../data/datasources/local_storage.dart';

class AddWeightScreen extends ConsumerStatefulWidget {
  const AddWeightScreen({super.key});

  @override
  ConsumerState<AddWeightScreen> createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends ConsumerState<AddWeightScreen> {
  final _weightController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Set initial weight from current user profile if available
    final userProfile = ref.read(userProfileProvider);
    if (userProfile != null && userProfile.currentWeight > 0) {
      _weightController.text = userProfile.currentWeight.toStringAsFixed(1);
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveWeightEntry() async {
    if (_isSaving) return;

    final weightText = _weightController.text.trim();
    if (weightText.isEmpty) {
      _showError('Bitte geben Sie ein Gewicht ein.');
      return;
    }

    final weight = double.tryParse(weightText);
    if (weight == null || weight <= 0) {
      _showError('Bitte geben Sie ein gültiges Gewicht ein.');
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      debugPrint('Starting weight save process...');
      
      // Get user ID from profile or generate one
      final userProfile = ref.read(userProfileProvider);
      final userId = userProfile?.id ?? 'local_user_${DateTime.now().millisecondsSinceEpoch}';
      
      // Create weight entry
      final weightEntry = WeightEntry(
        id: 'weight_${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        weight: weight,
        date: _selectedDate,
        note: _noteController.text.trim().isNotEmpty ? _noteController.text.trim() : null,
        createdAt: DateTime.now(),
      );

      debugPrint('Weight entry created: ${weightEntry.weight} kg on ${weightEntry.date}');
      
      // Save to local storage
      await LocalStorage.saveWeightEntry(weightEntry);
      debugPrint('Weight entry saved to local storage');
      
      // Update user profile with new current weight if it's today's entry
      if (_isToday(_selectedDate) && userProfile != null) {
        final updatedProfile = userProfile.copyWith(
          currentWeight: weight,
          updatedAt: DateTime.now(),
        );
        await LocalStorage.saveUserProfile(updatedProfile);
        ref.read(userProfileProvider.notifier).state = updatedProfile;
        debugPrint('User profile updated with new weight: $weight kg');
      }
      
      // Update weight entries provider
      final currentEntries = ref.read(weightEntriesProvider);
      final newEntries = [weightEntry, ...currentEntries];
      ref.read(weightEntriesProvider.notifier).state = newEntries;
      debugPrint('Weight entries provider updated with ${newEntries.length} entries');
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gewicht von ${weight.toStringAsFixed(1)} kg gespeichert'),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 2),
          ),
        );
        
        // Navigate back after a short delay
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          context.pop();
        }
      }
      
    } catch (e) {
      debugPrint('Error saving weight entry: $e');
      _showError('Fehler beim Speichern: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dateFormat = DateFormat('dd.MM.yyyy');
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addWeight),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _isSaving ? null : () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.monitor_weight_outlined,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            
            // Weight input
            PremiumInputField(
              label: l10n.weightKg,
              hint: '70.0',
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              prefixIcon: const Icon(Icons.scale, size: 20),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // Date selection
            GestureDetector(
              onTap: _isSaving ? null : () => _selectDate(context),
              child: AbsorbPointer(
                absorbing: _isSaving,
                child: PremiumInputField(
                  label: l10n.date,
                  hint: dateFormat.format(_selectedDate),
                  prefixIcon: const Icon(Icons.calendar_today, size: 20),
                  suffixIcon: Icon(
                    Icons.calendar_month,
                    color: _isSaving ? Colors.grey : AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // Note input
            PremiumInputField(
              label: l10n.note,
              hint: l10n.noteHint,
              controller: _noteController,
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.xxl),
            
            // Save button
            PremiumButton(
              label: _isSaving ? 'Speichern...' : l10n.save,
              icon: _isSaving ? Icons.hourglass_top : Icons.check,
              onPressed: _isSaving ? null : _saveWeightEntry,
              isLoading: _isSaving,
            ),
            
            // Debug info (only in debug mode)
            if (const bool.fromEnvironment('dart.vm.product') == false) ...[
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Debug Info:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Selected Date: ${dateFormat.format(_selectedDate)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      'Is Today: ${_isToday(_selectedDate)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      'User Profile: ${ref.read(userProfileProvider) != null ? "Loaded" : "Not loaded"}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}