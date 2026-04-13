import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/providers/app_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(todayStatsProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          // Trigger a rebuild of providers
          ref.invalidate(todayStatsProvider);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            // ─── Premium Header with Gradient ────────────────────
            SliverToBoxAdapter(
              child: _HomeHeader(stats: stats, l10n: l10n),
            ),

            // ─── Quick Actions Grid ──────────────────────────────
            SliverToBoxAdapter(
              child: _QuickActionsGrid(l10n: l10n),
            ),

            // ─── Calorie & Water Trackers ────────────────────────
            SliverToBoxAdapter(
              child: _TrackerRow(stats: stats, l10n: l10n),
            ),

            // ─── BMI Card ────────────────────────────────────────
            SliverToBoxAdapter(
              child: _BmiCard(stats: stats, l10n: l10n),
            ),

            // ─── Habits Progress ─────────────────────────────────
            SliverToBoxAdapter(
              child: _HabitsCard(stats: stats, l10n: l10n),
            ),

            // ─── Motivational Insight ────────────────────────────
            SliverToBoxAdapter(
              child: _InsightCard(l10n: l10n),
            ),

            // Bottom safe area padding
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xxl + 80),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// HOME HEADER – Gradient with weight summary
// ═══════════════════════════════════════════════════════════════════
class _HomeHeader extends StatelessWidget {
  final TodayStats stats;
  final AppLocalizations l10n;

  const _HomeHeader({required this.stats, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xl,
          ),
          child: Column(
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: AppTypography.bodyMedium.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.appName,
                        style: AppTypography.headlineMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  _CircleButton(
                    icon: Icons.notifications_outlined,
                    onTap: () => context.push('/settings/notifications'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Weight summary
              Row(
                children: [
                  // Main weight display with progress ring
                  _WeightRing(stats: stats),
                  const SizedBox(width: AppSpacing.xl),
                  Expanded(
                    child: Column(
                      children: [
                        _StatRow(
                          label: l10n.targetWeight,
                          value: '${stats.targetWeight.toStringAsFixed(1)} kg',
                          icon: Icons.flag_outlined,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _StatRow(
                          label: l10n.remaining,
                          value: '${stats.weightDifference.toStringAsFixed(1)} kg',
                          icon: Icons.trending_down_outlined,
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
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorning;
    if (hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }
}

// ═══════════════════════════════════════════════════════════════════
// WEIGHT RING – Large animated progress ring
// ═══════════════════════════════════════════════════════════════════
class _WeightRing extends StatelessWidget {
  final TodayStats stats;
  const _WeightRing({required this.stats});

  @override
  Widget build(BuildContext context) {
    final progress = stats.weightProgress;

    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background ring
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 10,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white.withValues(alpha: 0.2),
              ),
            ),
          ),
          // Progress ring
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              strokeWidth: 10,
              strokeCap: StrokeCap.round,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.transparent,
            ),
          ),
          // Center content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                stats.currentWeight.toStringAsFixed(1),
                style: AppTypography.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'kg',
                style: AppTypography.labelSmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// STAT ROW – Inside header
// ═══════════════════════════════════════════════════════════════════
class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white.withValues(alpha: 0.8)),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
          Text(
            value,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// CIRCLE BUTTON – For header actions
// ═══════════════════════════════════════════════════════════════════
class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// QUICK ACTIONS GRID – 5 action buttons in a grid
// ═══════════════════════════════════════════════════════════════════
class _QuickActionsGrid extends StatelessWidget {
  final AppLocalizations l10n;
  const _QuickActionsGrid({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ActionItem(
            icon: Icons.monitor_weight_outlined,
            label: l10n.addWeight,
            color: AppColors.primary,
            onTap: () => context.push('/add-weight'),
          ),
          _ActionItem(
            icon: Icons.restaurant_outlined,
            label: l10n.addMeal,
            color: AppColors.accent,
            onTap: () => context.push('/add-meal'),
          ),
          _ActionItem(
            icon: Icons.water_drop_outlined,
            label: l10n.addWater,
            color: AppColors.info,
            onTap: () => context.push('/add-water'),
          ),
          _ActionItem(
            icon: Icons.fitness_center_outlined,
            label: l10n.addWorkout,
            color: AppColors.success,
            onTap: () => context.push('/add-workout'),
          ),
          _ActionItem(
            icon: Icons.straighten_outlined,
            label: l10n.addMeasurement,
            color: AppColors.warning,
            onTap: () => context.push('/add-measurement'),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: color.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 58,
            child: Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// TRACKER ROW – Calories & Water side by side
// ═══════════════════════════════════════════════════════════════════
class _TrackerRow extends StatelessWidget {
  final TodayStats stats;
  final AppLocalizations l10n;

  const _TrackerRow({required this.stats, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: _TrackerCard(
              icon: Icons.local_fire_department_rounded,
              iconColor: AppColors.accent,
              bgColor: AppColors.accentSurface,
              title: l10n.calories,
              current: '${stats.caloriesConsumed.toInt()}',
              target: '/ ${stats.dailyCalorieTarget.toInt()} kcal',
              progress: stats.calorieProgress,
              progressColor: AppColors.accent,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _TrackerCard(
              icon: Icons.water_drop_rounded,
              iconColor: AppColors.info,
              bgColor: AppColors.infoLight,
              title: l10n.water,
              current: (stats.waterConsumed / 1000).toStringAsFixed(1),
              target: '/ ${(stats.waterGoal / 1000).toStringAsFixed(1)} L',
              progress: stats.waterProgress,
              progressColor: AppColors.info,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackerCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;
  final String current;
  final String target;
  final double progress;
  final Color progressColor;

  const _TrackerCard({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
    required this.current,
    required this.target,
    required this.progress,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.dark
                ? Colors.black.withValues(alpha: 0.2)
                : AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            current,
            style: AppTypography.headlineMedium.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            target,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.full),
            child: Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: progressColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [progressColor, progressColor.withValues(alpha: 0.8)],
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// BMI CARD – Shows BMI with category and color
// ═══════════════════════════════════════════════════════════════════
class _BmiCard extends StatelessWidget {
  final TodayStats stats;
  final AppLocalizations l10n;

  const _BmiCard({required this.stats, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bmiColor = _getBmiColor(stats.bmi);
    final bmiCategory = _getBmiCategoryText(stats.bmi);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: theme.brightness == Brightness.dark
                  ? Colors.black.withValues(alpha: 0.2)
                  : AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: bmiColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.favorite_rounded,
                    size: 20,
                    color: bmiColor,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  l10n.bmi,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: bmiColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    bmiCategory,
                    style: AppTypography.labelSmall.copyWith(
                      color: bmiColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            // BMI Scale Bar
            _BmiScaleBar(bmi: stats.bmi, color: bmiColor),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stats.bmi.toStringAsFixed(1),
                  style: AppTypography.headlineLarge.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      l10n.targetWeight,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    Text(
                      '${stats.targetWeight.toStringAsFixed(1)} kg',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getBmiColor(double bmi) {
    if (bmi < 18.5) return AppColors.bmiUnderweight;
    if (bmi < 25) return AppColors.bmiNormal;
    if (bmi < 30) return AppColors.bmiOverweight;
    return AppColors.bmiObese;
  }

  String _getBmiCategoryText(double bmi) {
    if (bmi < 18.5) return 'Untergewicht';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Übergewicht';
    return 'Adipositas';
  }
}

// ═══════════════════════════════════════════════════════════════════
// BMI SCALE BAR – Visual BMI indicator
// ═══════════════════════════════════════════════════════════════════
class _BmiScaleBar extends StatelessWidget {
  final double bmi;
  final Color color;

  const _BmiScaleBar({required this.bmi, required this.color});

  @override
  Widget build(BuildContext context) {
    // BMI ranges: <18.5, 18.5-25, 25-30, >30
    // Map to 0.0 - 1.0 where 40 = 1.0
    final position = (bmi / 40).clamp(0.0, 1.0);

    return Stack(
      children: [
        // Background gradient bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: const LinearGradient(
              colors: [
                AppColors.bmiUnderweight,
                AppColors.bmiNormal,
                AppColors.bmiOverweight,
                AppColors.bmiObese,
              ],
              stops: [0.0, 0.46, 0.625, 1.0],
            ),
          ),
        ),
        // Indicator
        Positioned(
          left: position * (MediaQuery.of(context).size.width - 80),
          child: Container(
            width: 4,
            height: 12,
            margin: const EdgeInsets.only(top: -2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// HABITS CARD – Habits tracking progress
// ═══════════════════════════════════════════════════════════════════
class _HabitsCard extends StatelessWidget {
  final TodayStats stats;
  final AppLocalizations l10n;

  const _HabitsCard({required this.stats, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isComplete = stats.habitProgress >= 1.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm,
      ),
      child: GestureDetector(
        onTap: () => context.go('/habits'),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.brightness == Brightness.dark
                    ? Colors.black.withValues(alpha: 0.2)
                    : AppColors.shadow,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Progress ring
              SizedBox(
                width: 56,
                height: 56,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.success.withValues(alpha: 0.12),
                      ),
                    ),
                    CircularProgressIndicator(
                      value: stats.habitProgress.clamp(0.0, 1.0),
                      strokeWidth: 5,
                      strokeCap: StrokeCap.round,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.success,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Text(
                      '${stats.habitsCompleted}',
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.habitsToday,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isComplete
                          ? l10n.allHabitsDone
                          : '${stats.habitsCompleted}/${stats.habitsTotal} ${l10n.habitsCompleted}',
                      style: AppTypography.bodySmall.copyWith(
                        color: isComplete ? AppColors.success : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isComplete
                      ? AppColors.successLight
                      : AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isComplete ? '✓' : l10n.seeAll,
                  style: AppTypography.labelSmall.copyWith(
                    color: isComplete ? AppColors.success : AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// INSIGHT CARD – Motivational daily insight
// ═══════════════════════════════════════════════════════════════════
class _InsightCard extends StatelessWidget {
  final AppLocalizations l10n;
  const _InsightCard({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.08),
              AppColors.primary.withValues(alpha: 0.03),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.lightbulb_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dailyInsight,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.insightMessage,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}