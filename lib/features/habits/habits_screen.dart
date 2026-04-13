import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final habits = [
      _HabitData(Icons.water_drop, l10n.habitWater, true, 7),
      _HabitData(Icons.directions_walk, l10n.habitWalk, true, 5),
      _HabitData(Icons.no_drinks, l10n.habitNoSugar, false, 3),
      _HabitData(Icons.bedtime, l10n.habitSleep, true, 12),
      _HabitData(Icons.fitness_center, l10n.habitWorkout, false, 2),
    ];
    final completed = habits.where((h) => h.isDone).length;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navHabits), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Summary card
          PremiumCard(
            child: Row(
              children: [
                ProgressRing(
                  progress: completed / habits.length,
                  size: 72, strokeWidth: 6, color: AppColors.success,
                  child: Text('$completed/${habits.length}',
                    style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.habitsToday, style: AppTypography.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      completed == habits.length ? l10n.allHabitsDone : l10n.keepGoing,
                      style: AppTypography.bodySmall.copyWith(
                        color: completed == habits.length ? AppColors.success : AppColors.primary,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(title: l10n.dailyHabits),
          ...habits.map((h) => HabitTile(
            name: h.name,
            iconKey: h.icon.codePoint.toString(),
            streak: h.streak,
            isCompleted: h.isDone,
            onToggle: () {/* TODO: toggle habit */},
          )),
        ],
      ),
    );
  }
}

class _HabitData {
  final IconData icon;
  final String name;
  final bool isDone;
  final int streak;
  _HabitData(this.icon, this.name, this.isDone, this.streak);
}