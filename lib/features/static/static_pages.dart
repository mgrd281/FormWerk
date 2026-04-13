import 'package:flutter/material.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.about), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Center(child: Column(children: [
            Container(width: 80, height: 80, decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
            ), child: const Icon(Icons.explore, size: 40, color: Theme.of(context).primaryColor)),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.appName, style: AppTypography.headline4),
            const SizedBox(height: AppSpacing.xs),
            Text('Version 1.0.0', style: AppTypography.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            )),
          ])),
          const SizedBox(height: AppSpacing.xxl),
          Text(l10n.aboutDescription, style: AppTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ), textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.xl),
          _InfoRow(Icons.email_outlined, 'support@gewichtskompass.de'),
          _InfoRow(Icons.language, 'www.gewichtskompass.de'),
          _InfoRow(Icons.copyright, '© 2026 GewichtsKompass'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow(this.icon, this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)),
        const SizedBox(width: AppSpacing.md),
        Text(text, style: AppTypography.bodyMedium),
      ]),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.privacyPolicy), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.privacyTitle, style: AppTypography.headline5),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.privacyContent, style: AppTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          )),
        ],
      ),
    );
  }
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.terms), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.termsTitle, style: AppTypography.headline5),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.termsContent, style: AppTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          )),
        ],
      ),
    );
  }
}