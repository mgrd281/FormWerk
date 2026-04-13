import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class AddWaterScreen extends StatefulWidget {
  const AddWaterScreen({super.key});
  @override
  State<AddWaterScreen> createState() => _AddWaterScreenState();
}

class _AddWaterScreenState extends State<AddWaterScreen> {
  double _amount = 250;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addWater), centerTitle: true, leading: IconButton(
        icon: const Icon(Icons.close), onPressed: () => context.pop(),
      )),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(children: [
          Center(child: Container(width: 80, height: 80, decoration: BoxDecoration(
            color: AppColors.info.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(24),
          ), child: const Icon(Icons.water_drop_outlined, size: 40, color: AppColors.info))),
          const SizedBox(height: AppSpacing.xxl),
          Text('${_amount.toInt()} ml', style: AppTypography.headline2.copyWith(color: AppColors.info)),
          const SizedBox(height: AppSpacing.xl),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.info,
              inactiveTrackColor: AppColors.info.withValues(alpha: 0.2),
              thumbColor: AppColors.info,
              overlayColor: AppColors.info.withValues(alpha: 0.1),
            ),
            child: Slider(
              value: _amount,
              min: 50, max: 1000,
              divisions: 19,
              onChanged: (v) => setState(() => _amount = v),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm, children: [
            _QuickAmount('100 ml', 100), _QuickAmount('250 ml', 250),
            _QuickAmount('500 ml', 500), _QuickAmount('750 ml', 750),
          ]),
          const Spacer(),
          PremiumButton(label: l10n.save, icon: Icons.check, onPressed: () => context.pop()),
        ]),
      ),
    );
  }

  Widget _QuickAmount(String label, double value) {
    final selected = _amount == value;
    return GestureDetector(
      onTap: () => setState(() => _amount = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: selected ? AppColors.info.withValues(alpha: 0.1) : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: selected ? AppColors.info : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
        ),
        child: Text(label, style: AppTypography.bodySmall.copyWith(
          color: selected ? AppColors.info : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        )),
      ),
    );
  }
}