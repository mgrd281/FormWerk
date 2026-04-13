import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});
  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  String _category = 'running';
  final _durationController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _notesController = TextEditingController();

  static const _categories = [
    ('running', Icons.directions_run, AppColors.primary),
    ('walking', Icons.directions_walk, AppColors.success),
    ('strength', Icons.fitness_center, AppColors.accent),
    ('cycling', Icons.pedal_bike, AppColors.info),
    ('home', Icons.home, AppColors.warning),
    ('other', Icons.sports, AppColors.primaryLight),
  ];

  @override
  void dispose() { _durationController.dispose(); _caloriesController.dispose(); _notesController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addWorkout), centerTitle: true, leading: IconButton(
        icon: const Icon(Icons.close), onPressed: () => context.pop(),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(children: [
          Center(child: Container(width: 80, height: 80, decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(24),
          ), child: const Icon(Icons.fitness_center_outlined, size: 40, color: AppColors.success))),
          const SizedBox(height: AppSpacing.xl),
          // Category grid
          Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm, children: _categories.map((c) {
            final selected = _category == c.$1;
            return GestureDetector(
              onTap: () => setState(() => _category = c.$1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: selected ? c.$3.withValues(alpha: 0.1) : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: selected ? c.$3 : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(c.$2, size: 16, color: selected ? c.$3 : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
                  const SizedBox(width: 6),
                  Text(c.$1, style: AppTypography.bodySmall.copyWith(
                    color: selected ? c.$3 : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  )),
                ]),
              ),
            );
          }).toList()),
          const SizedBox(height: AppSpacing.xl),
          Row(children: [
            Expanded(child: PremiumInputField(label: l10n.durationMin, hint: '30', controller: _durationController, keyboardType: TextInputType.number)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: PremiumInputField(label: l10n.caloriesBurned, hint: '250', controller: _caloriesController, keyboardType: TextInputType.number)),
          ]),
          const SizedBox(height: AppSpacing.lg),
          PremiumInputField(label: l10n.notes, hint: l10n.notesHint, controller: _notesController, maxLines: 2),
          const SizedBox(height: AppSpacing.xxl),
          PremiumButton(label: l10n.save, icon: Icons.check, onPressed: () => context.pop()),
        ]),
      ),
    );
  }
}