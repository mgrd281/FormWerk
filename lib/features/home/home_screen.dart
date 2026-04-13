import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/providers/app_providers.dart';
import '../../core/widgets/app_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(todayStatsProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── Premium Header ──────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primaryDark,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.xxl + 16, AppSpacing.lg, AppSpacing.xxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.goodMorning, style: AppTypography.bodyMedium.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          )),
                          const SizedBox(height: 4),
                          Text(l10n.appName, style: AppTypography.headlineSmall.copyWith(
                            color: Colors.white,
                          )),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                          onPressed: () => context.push('/settings/notifications'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Weight summary row
                  Row(
                    children: [
                      // Current weight ring
                      ProgressRing(
                        progress: stats.weightDifference > 0 ? 0.35 : 1.0,
                        size: 100,
                        strokeWidth: 8,
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              stats.currentWeight.toStringAsFixed(1),
                              style: AppTypography.titleLarge.copyWith(
                                color: Colors.white, fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text('kg', style: AppTypography.caption.copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HeaderStat(
                              label: l10n.targetWeight,
                              value: '${stats.targetWeight.toStringAsFixed(1)} kg',
                              color: Colors.white,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _HeaderStat(
                              label: l10n.bmi,
                              value: stats.bmi.toStringAsFixed(1),
                              color: Colors.white,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _HeaderStat(
                              label: l10n.remaining,
                              value: '${stats.weightDifference.toStringAsFixed(1)} kg',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ─── Quick Actions ───────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    QuickActionChip(
                      icon: Icons.monitor_weight_outlined,
                      label: l10n.addWeight,
                      color: AppColors.primary,
                      onTap: () => context.push('/add-weight'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    QuickActionChip(
                      icon: Icons.restaurant_outlined,
                      label: l10n.addMeal,
                      color: AppColors.accent,
                      onTap: () => context.push('/add-meal'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    QuickActionChip(
                      icon: Icons.water_drop_outlined,
                      label: l10n.addWater,
                      color: AppColors.info,
                      onTap: () => context.push('/add-water'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    QuickActionChip(
                      icon: Icons.fitness_center_outlined,
                      label: l10n.addWorkout,
                      color: AppColors.success,
                      onTap: () => context.push('/add-workout'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    QuickActionChip(
                      icon: Icons.straighten_outlined,
                      label: l10n.addMeasurement,
                      color: AppColors.warning,
                      onTap: () => context.push('/add-measurement'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ─── Calorie & Water Row ─────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: PremiumCard(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_fire_department, size: 20, color: AppColors.accent),
                              const SizedBox(width: AppSpacing.xs),
                              Text(l10n.calories, style: AppTypography.bodySmall.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              )),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ProgressRing(
                            progress: stats.calorieProgress,
                            size: 64,
                            strokeWidth: 5,
                            color: AppColors.accent,
                            child: Text(
                              '${(stats.caloriesConsumed).toInt()}',
                              style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            '/ ${(stats.dailyCalorieTarget).toInt()} kcal',
                            style: AppTypography.caption.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: PremiumCard(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.water_drop, size: 20, color: AppColors.info),
                              const SizedBox(width: AppSpacing.xs),
                              Text(l10n.water, style: AppTypography.bodySmall.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              )),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ProgressRing(
                            progress: stats.waterProgress,
                            size: 64,
                            strokeWidth: 5,
                            color: AppColors.info,
                            child: Text(
                              (stats.waterConsumed / 1000).toStringAsFixed(1),
                              style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            '/ ${(stats.waterGoal / 1000).toStringAsFixed(1)} L',
                            style: AppTypography.caption.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Habits Progress ─────────────────────────────────
          SliverToBoxAdapter(
            child: SectionHeader(
              title: l10n.habitsToday,
              actionLabel: l10n.seeAll,
              onAction: () => context.go('/habits'),
            ),
          ),
          SliverToBoxAdapter(
            child: PremiumCard(
              child: Row(
                children: [
                  ProgressRing(
                    progress: stats.habitProgress,
                    size: 56,
                    strokeWidth: 4,
                    color: AppColors.success,
                    child: Text(
                      '${stats.habitsCompleted}/${stats.habitsTotal}',
                      style: AppTypography.caption.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.habitsCompleted, style: AppTypography.bodyMedium),
                        const SizedBox(height: 4),
                        Text(
                          stats.habitProgress >= 1.0
                              ? l10n.allHabitsDone
                              : l10n.keepGoing,
                          style: AppTypography.caption.copyWith(
                            color: stats.habitProgress >= 1.0 ? AppColors.success : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
                ],
              ),
            ),
          ),

          // ─── Motivational Insight ────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.08),
                      AppColors.accent.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: const Icon(Icons.lightbulb_outline, color: AppColors.primary, size: 24),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.dailyInsight, style: AppTypography.bodySmall.copyWith(
                            fontWeight: FontWeight.w600, color: AppColors.primary,
                          )),
                          const SizedBox(height: 4),
                          Text(l10n.insightMessage, style: AppTypography.bodySmall.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
        ],
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _HeaderStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.bodySmall.copyWith(
          color: color.withValues(alpha: 0.7),
        )),
        Text(value, style: AppTypography.bodyMedium.copyWith(
          color: color, fontWeight: FontWeight.w600,
        )),
      ],
    );
  }
}