import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});
  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  String _mealType = 'breakfast';
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();

  @override
  void dispose() { _nameController.dispose(); _caloriesController.dispose(); _proteinController.dispose(); _carbsController.dispose(); _fatController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addMeal), centerTitle: true, leading: IconButton(
        icon: const Icon(Icons.close), onPressed: () => context.pop(),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(children: [
          Center(child: Container(width: 80, height: 80, decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(24),
          ), child: const Icon(Icons.restaurant_outlined, size: 40, color: AppColors.accent))),
          const SizedBox(height: AppSpacing.xl),
          // Meal type selector
          SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
            _MealTypeChip(l10n.breakfast, Icons.free_breakfast, _mealType == 'breakfast', () => setState(() => _mealType = 'breakfast')),
            const SizedBox(width: AppSpacing.sm),
            _MealTypeChip(l10n.lunch, Icons.lunch_dining, _mealType == 'lunch', () => setState(() => _mealType = 'lunch')),
            const SizedBox(width: AppSpacing.sm),
            _MealTypeChip(l10n.dinner, Icons.dinner_dining, _mealType == 'dinner', () => setState(() => _mealType = 'dinner')),
            const SizedBox(width: AppSpacing.sm),
            _MealTypeChip(l10n.snacks, Icons.cookie, _mealType == 'snacks', () => setState(() => _mealType = 'snacks')),
          ])),
          const SizedBox(height: AppSpacing.xl),
          PremiumInputField(label: l10n.mealName, hint: l10n.mealNameHint, controller: _nameController, prefixIcon: const Icon(Icons.restaurant, size: 20)),
          const SizedBox(height: AppSpacing.lg),
          PremiumInputField(label: l10n.caloriesKcal, hint: '450', controller: _caloriesController, keyboardType: TextInputType.number, prefixIcon: const Icon(Icons.local_fire_department, size: 20)),
          const SizedBox(height: AppSpacing.lg),
          Row(children: [
            Expanded(child: PremiumInputField(label: l10n.proteinG, hint: '30', controller: _proteinController, keyboardType: TextInputType.number)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: PremiumInputField(label: l10n.carbsG, hint: '45', controller: _carbsController, keyboardType: TextInputType.number)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: PremiumInputField(label: l10n.fatG, hint: '15', controller: _fatController, keyboardType: TextInputType.number)),
          ]),
          const SizedBox(height: AppSpacing.xxl),
          PremiumButton(label: l10n.save, icon: Icons.check, onPressed: () => context.pop()),
        ]),
      ),
    );
  }
}

class _MealTypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _MealTypeChip(this.label, this.icon, this.selected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent.withValues(alpha: 0.1) : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: selected ? AppColors.accent : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
        ),
        child: Row(children: [
          Icon(icon, size: 16, color: selected ? AppColors.accent : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
          const SizedBox(width: 6),
          Text(label, style: AppTypography.bodySmall.copyWith(
            color: selected ? AppColors.accent : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          )),
        ]),
      ),
    );
  }
}