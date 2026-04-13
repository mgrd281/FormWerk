import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navLog), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.logAction, style: AppTypography.headlineSmall.copyWith(
              color: theme.colorScheme.onSurface,
            )),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.logActionDesc, style: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            )),
            const SizedBox(height: AppSpacing.xl),
            _LogActionCard(
              icon: Icons.monitor_weight_outlined,
              title: l10n.addWeight,
              subtitle: l10n.addWeightDesc,
              color: AppColors.primary,
              onTap: () => context.push('/add-weight'),
            ),
            const SizedBox(height: AppSpacing.md),
            _LogActionCard(
              icon: Icons.restaurant_outlined,
              title: l10n.addMeal,
              subtitle: l10n.addMealDesc,
              color: AppColors.accent,
              onTap: () => context.push('/add-meal'),
            ),
            const SizedBox(height: AppSpacing.md),
            _LogActionCard(
              icon: Icons.water_drop_outlined,
              title: l10n.addWater,
              subtitle: l10n.addWaterDesc,
              color: AppColors.info,
              onTap: () => context.push('/add-water'),
            ),
            const SizedBox(height: AppSpacing.md),
            _LogActionCard(
              icon: Icons.fitness_center_outlined,
              title: l10n.addWorkout,
              subtitle: l10n.addWorkoutDesc,
              color: AppColors.success,
              onTap: () => context.push('/add-workout'),
            ),
            const SizedBox(height: AppSpacing.md),
            _LogActionCard(
              icon: Icons.straighten_outlined,
              title: l10n.addMeasurement,
              subtitle: l10n.addMeasurementDesc,
              color: AppColors.warning,
              onTap: () => context.push('/add-measurement'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _LogActionCard({
    required this.icon, required this.title, required this.subtitle,
    required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.caption.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                )),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: color.withValues(alpha: 0.5)),
        ],
      ),
    );
  }
}