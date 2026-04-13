import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          PremiumCard(padding: EdgeInsets.zero, child: Column(children: [
            ListTile(
              leading: const Icon(Icons.language, color: AppColors.primary),
              title: Text(l10n.language, style: AppTypography.bodyMedium),
              subtitle: Text('Deutsch', style: AppTypography.caption),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () => context.push('/settings/language'),
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: const Icon(Icons.palette_outlined, color: AppColors.primary),
              title: Text(l10n.theme, style: AppTypography.bodyMedium),
              subtitle: Text(l10n.systemDefault, style: AppTypography.caption),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () => context.push('/settings/theme'),
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: const Icon(Icons.notifications_outlined, color: AppColors.primary),
              title: Text(l10n.notifications, style: AppTypography.bodyMedium),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () => context.push('/settings/notifications'),
            ),
          ])),
          const SizedBox(height: AppSpacing.lg),
          PremiumCard(padding: EdgeInsets.zero, child: Column(children: [
            ListTile(
              leading: const Icon(Icons.track_changes, color: AppColors.primary),
              title: Text(l10n.goalSettings, style: AppTypography.bodyMedium),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () {/* TODO */},
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: const Icon(Icons.straighten, color: AppColors.primary),
              title: Text(l10n.unitSettings, style: AppTypography.bodyMedium),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () {/* TODO */},
            ),
          ])),
          const SizedBox(height: AppSpacing.lg),
          PremiumCard(padding: EdgeInsets.zero, child: Column(children: [
            ListTile(
              leading: const Icon(Icons.info_outline, color: AppColors.primary),
              title: Text(l10n.about, style: AppTypography.bodyMedium),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () => context.push('/about'),
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.primary),
              title: Text(l10n.privacyPolicy, style: AppTypography.bodyMedium),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () => context.push('/privacy'),
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: const Icon(Icons.description_outlined, color: AppColors.primary),
              title: Text(l10n.terms, style: AppTypography.bodyMedium),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () => context.push('/terms'),
            ),
          ])),
        ],
      ),
    );
  }
}

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.language), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          PremiumCard(padding: EdgeInsets.zero, child: Column(children: [
            ListTile(
              leading: Text('🇩🇪', style: const TextStyle(fontSize: 24)),
              title: Text('Deutsch', style: AppTypography.bodyMedium),
              trailing: const Icon(Icons.check, color: AppColors.primary),
              onTap: () {/* TODO: switch to German */},
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: Text('🇸🇦', style: const TextStyle(fontSize: 24)),
              title: Text('العربية', style: AppTypography.bodyMedium),
              trailing: const SizedBox.shrink(),
              onTap: () {/* TODO: switch to Arabic */},
            ),
          ])),
        ],
      ),
    );
  }
}

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.theme), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          PremiumCard(padding: EdgeInsets.zero, child: Column(children: [
            ListTile(
              leading: const Icon(Icons.light_mode, color: AppColors.warning),
              title: Text(l10n.lightTheme, style: AppTypography.bodyMedium),
              trailing: const SizedBox.shrink(),
              onTap: () {/* TODO */},
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: const Icon(Icons.dark_mode, color: AppColors.primary),
              title: Text(l10n.darkTheme, style: AppTypography.bodyMedium),
              trailing: const SizedBox.shrink(),
              onTap: () {/* TODO */},
            ),
            const Divider(height: 1, indent: 56),
            ListTile(
              leading: const Icon(Icons.brightness_auto, color: AppColors.primary),
              title: Text(l10n.systemDefault, style: AppTypography.bodyMedium),
              trailing: const Icon(Icons.check, color: AppColors.primary),
              onTap: () {/* TODO */},
            ),
          ])),
        ],
      ),
    );
  }
}

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.notifications), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          PremiumCard(padding: EdgeInsets.zero, child: Column(children: [
            SwitchListTile(
              secondary: const Icon(Icons.monitor_weight_outlined, color: AppColors.primary),
              title: Text(l10n.weightReminder, style: AppTypography.bodyMedium),
              value: true, onChanged: (v) {},
            ),
            SwitchListTile(
              secondary: const Icon(Icons.water_drop, color: AppColors.info),
              title: Text(l10n.waterReminder, style: AppTypography.bodyMedium),
              value: true, onChanged: (v) {},
            ),
            SwitchListTile(
              secondary: const Icon(Icons.restaurant, color: AppColors.accent),
              title: Text(l10n.mealReminder, style: AppTypography.bodyMedium),
              value: false, onChanged: (v) {},
            ),
            SwitchListTile(
              secondary: const Icon(Icons.fitness_center, color: AppColors.success),
              title: Text(l10n.workoutReminder, style: AppTypography.bodyMedium),
              value: true, onChanged: (v) {},
            ),
            SwitchListTile(
              secondary: const Icon(Icons.favorite, color: AppColors.error),
              title: Text(l10n.motivationReminder, style: AppTypography.bodyMedium),
              value: true, onChanged: (v) {},
            ),
            SwitchListTile(
              secondary: const Icon(Icons.local_fire_department, color: AppColors.warning),
              title: Text(l10n.streakReminder, style: AppTypography.bodyMedium),
              value: true, onChanged: (v) {},
            ),
          ])),
        ],
      ),
    );
  }
}