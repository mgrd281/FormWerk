import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen({super.key});
  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  final _weightController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();
  String _note = '';

  @override
  void dispose() { _weightController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addWeight), centerTitle: true, leading: IconButton(
        icon: const Icon(Icons.close), onPressed: () => context.pop(),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.monitor_weight_outlined, size: 40, color: AppColors.primary),
            )),
            const SizedBox(height: AppSpacing.xl),
            PremiumInputField(
              label: l10n.weightKg,
              hint: '70.0',
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              prefixIcon: const Icon(Icons.scale, size: 20),
            ),
            const SizedBox(height: AppSpacing.lg),
            PremiumInputField(
              label: l10n.date,
              hint: '',
              prefixIcon: const Icon(Icons.calendar_today, size: 20),
            ),
            const SizedBox(height: AppSpacing.lg),
            PremiumInputField(
              label: l10n.note,
              hint: l10n.noteHint,
              maxLines: 2,
              onChanged: (v) => _note = v,
            ),
            const SizedBox(height: AppSpacing.xxl),
            PremiumButton(
              label: l10n.save,
              icon: Icons.check,
              onPressed: () { context.pop(); },
            ),
          ],
        ),
      ),
    );
  }
}