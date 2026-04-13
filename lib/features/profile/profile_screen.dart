import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProfile), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Profile header
          PremiumCard(
            child: Row(
              children: [
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.person, size: 32, color: AppColors.primary),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Benutzer', style: AppTypography.titleLarge),
                    const SizedBox(height: 2),
                    Text('benutzer@email.de', style: AppTypography.bodySmall.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    )),
                  ],
                )),
                IconButton(onPressed: () {/* TODO: edit profile */}, icon: const Icon(Icons.edit_outlined)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Settings sections
          _SettingsSection(title: l10n.appSettings, items: [
            _SettingsItem(Icons.settings_outlined, l10n.settings, () => context.push('/settings')),
            _SettingsItem(Icons.language, l10n.language, () => context.push('/settings/language')),
            _SettingsItem(Icons.palette_outlined, l10n.theme, () => context.push('/settings/theme')),
            _SettingsItem(Icons.notifications_outlined, l10n.notifications, () => context.push('/settings/notifications')),
          ]),
          const SizedBox(height: AppSpacing.lg),
          _SettingsSection(title: l10n.about, items: [
            _SettingsItem(Icons.info_outline, l10n.about, () => context.push('/about')),
            _SettingsItem(Icons.privacy_tip_outlined, l10n.privacyPolicy, () => context.push('/privacy')),
            _SettingsItem(Icons.description_outlined, l10n.terms, () => context.push('/terms')),
          ]),
          const SizedBox(height: AppSpacing.lg),
          PremiumButton(
            label: l10n.signOut,
            isOutlined: true,
            color: AppColors.error,
            icon: Icons.logout,
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<_SettingsItem> items;
  const _SettingsSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: Text(title, style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          )),
        ),
        PremiumCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: items.map((item) => ListTile(
              leading: Icon(item.icon, color: AppColors.primary),
              title: Text(item.title, style: AppTypography.bodyMedium),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: item.onTap,
            )).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  _SettingsItem(this.icon, this.title, this.onTap);
}