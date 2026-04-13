import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class AddMeasurementScreen extends StatefulWidget {
  const AddMeasurementScreen({super.key});
  @override
  State<AddMeasurementScreen> createState() => _AddMeasurementScreenState();
}

class _AddMeasurementScreenState extends State<AddMeasurementScreen> {
  final _waist = TextEditingController();
  final _chest = TextEditingController();
  final _hips = TextEditingController();
  final _arms = TextEditingController();
  final _thighs = TextEditingController();
  final _neck = TextEditingController();
  final _bodyFat = TextEditingController();

  @override
  void dispose() { _waist.dispose(); _chest.dispose(); _hips.dispose(); _arms.dispose(); _thighs.dispose(); _neck.dispose(); _bodyFat.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addMeasurement), centerTitle: true, leading: IconButton(
        icon: const Icon(Icons.close), onPressed: () => context.pop(),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(children: [
          Center(child: Container(width: 80, height: 80, decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(24),
          ), child: const Icon(Icons.straighten_outlined, size: 40, color: AppColors.warning))),
          const SizedBox(height: AppSpacing.xl),
          PremiumInputField(label: l10n.waist, hint: '82', controller: _waist, keyboardType: TextInputType.number, prefixIcon: const Icon(Icons.straighten, size: 20)),
          const SizedBox(height: AppSpacing.lg),
          PremiumInputField(label: l10n.chest, hint: '96', controller: _chest, keyboardType: TextInputType.number, prefixIcon: const Icon(Icons.straighten, size: 20)),
          const SizedBox(height: AppSpacing.lg),
          PremiumInputField(label: l10n.hips, hint: '95', controller: _hips, keyboardType: TextInputType.number, prefixIcon: const Icon(Icons.straighten, size: 20)),
          const SizedBox(height: AppSpacing.lg),
          Row(children: [
            Expanded(child: PremiumInputField(label: l10n.arms, hint: '32', controller: _arms, keyboardType: TextInputType.number)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: PremiumInputField(label: l10n.thighs, hint: '55', controller: _thighs, keyboardType: TextInputType.number)),
          ]),
          const SizedBox(height: AppSpacing.lg),
          Row(children: [
            Expanded(child: PremiumInputField(label: l10n.neck, hint: '38', controller: _neck, keyboardType: TextInputType.number)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: PremiumInputField(label: l10n.bodyFat, hint: '22', controller: _bodyFat, keyboardType: TextInputType.number)),
          ]),
          const SizedBox(height: AppSpacing.xxl),
          PremiumButton(label: l10n.save, icon: Icons.check, onPressed: () => context.pop()),
        ]),
      ),
    );
  }
}