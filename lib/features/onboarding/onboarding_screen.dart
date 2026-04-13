import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/providers/app_providers.dart';
import '../../core/widgets/app_widgets.dart';
import '../../domain/entities/user_profile.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: List.generate(5, (i) => Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: i <= state.step
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )),
              ),
            ),
            // Step content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildStep(context, ref, state, l10n),
              ),
            ),
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  if (state.step > 0)
                    Expanded(
                      child: PremiumButton(
                        label: l10n.back,
                        isOutlined: true,
                        onPressed: () => ref.read(onboardingProvider.notifier).previousStep(),
                      ),
                    ),
                  if (state.step > 0) const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: PremiumButton(
                      label: state.step < 4 ? l10n.next : l10n.getStarted,
                      onPressed: () {
                        if (state.step < 4) {
                          ref.read(onboardingProvider.notifier).nextStep();
                        } else {
                          // Complete onboarding
                          context.go('/home');
                        }
                      },
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

  Widget _buildStep(BuildContext context, WidgetRef ref, OnboardingState state, AppLocalizations l10n) {
    switch (state.step) {
      case 0: return _WelcomeStep(l10n: l10n);
      case 1: return _GoalStep(ref: ref, state: state, l10n: l10n);
      case 2: return _PersonalStep(ref: ref, state: state, l10n: l10n);
      case 3: return _ActivityStep(ref: ref, state: state, l10n: l10n);
      case 4: return _PreferencesStep(ref: ref, state: state, l10n: l10n);
      default: return _WelcomeStep(l10n: l10n);
    }
  }
}

class _WelcomeStep extends StatelessWidget {
  final AppLocalizations l10n;
  const _WelcomeStep({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120, height: 120,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(Icons.explore_rounded, size: 60, color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.onboardingWelcome, style: AppTypography.headlineMedium, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.onboardingWelcomeDesc, style: AppTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _GoalStep extends StatelessWidget {
  final WidgetRef ref;
  final OnboardingState state;
  final AppLocalizations l10n;
  const _GoalStep({required this.ref, required this.state, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingGoal, style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.onboardingGoalDesc, style: AppTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          )),
          const SizedBox(height: AppSpacing.xl),
          ...WeightGoal.values.map((goal) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _GoalOption(
              icon: goal == WeightGoal.lose ? Icons.trending_down
                  : goal == WeightGoal.maintain ? Icons.trending_flat
                  : Icons.trending_up,
              title: goal == WeightGoal.lose ? l10n.goalLose
                  : goal == WeightGoal.maintain ? l10n.goalMaintain
                  : l10n.goalGain,
              isSelected: state.goal == goal,
              onTap: () => ref.read(onboardingProvider.notifier).setGoal(goal),
            ),
          )),
        ],
      ),
    );
  }
}

class _GoalOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _GoalOption({required this.icon, required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
            const SizedBox(width: AppSpacing.md),
            Text(title, style: AppTypography.bodyLarge.copyWith(
              color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            )),
          ],
        ),
      ),
    );
  }
}

class _PersonalStep extends StatelessWidget {
  final WidgetRef ref;
  final OnboardingState state;
  final AppLocalizations l10n;
  const _PersonalStep({required this.ref, required this.state, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingPersonal, style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.xl),
          // Gender selection
          Text(l10n.gender, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: Gender.values.map((g) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(g == Gender.male ? l10n.male : g == Gender.female ? l10n.female : l10n.other),
                  selected: state.gender == g,
                  onSelected: (_) => ref.read(onboardingProvider.notifier).setGender(g),
                ),
              ),
            )).toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          PremiumInputField(
            label: l10n.age,
            hint: '25',
            keyboardType: TextInputType.number,
            onChanged: (v) => ref.read(onboardingProvider.notifier).setAge(int.tryParse(v) ?? 25),
          ),
          const SizedBox(height: AppSpacing.lg),
          PremiumInputField(
            label: '${l10n.height} (cm)',
            hint: '170',
            keyboardType: TextInputType.number,
            onChanged: (v) => ref.read(onboardingProvider.notifier).setHeight(double.tryParse(v) ?? 170),
          ),
          const SizedBox(height: AppSpacing.lg),
          PremiumInputField(
            label: '${l10n.currentWeight} (kg)',
            hint: '70',
            keyboardType: TextInputType.number,
            onChanged: (v) => ref.read(onboardingProvider.notifier).setCurrentWeight(double.tryParse(v) ?? 70),
          ),
          const SizedBox(height: AppSpacing.lg),
          PremiumInputField(
            label: '${l10n.targetWeight} (kg)',
            hint: '65',
            keyboardType: TextInputType.number,
            onChanged: (v) => ref.read(onboardingProvider.notifier).setTargetWeight(double.tryParse(v) ?? 65),
          ),
        ],
      ),
    );
  }
}

class _ActivityStep extends StatelessWidget {
  final WidgetRef ref;
  final OnboardingState state;
  final AppLocalizations l10n;
  const _ActivityStep({required this.ref, required this.state, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingActivity, style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.onboardingActivityDesc, style: AppTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          )),
          const SizedBox(height: AppSpacing.xl),
          ...ActivityLevel.values.map((level) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _GoalOption(
              icon: level == ActivityLevel.sedentary ? Icons.chair
                  : level == ActivityLevel.light ? Icons.directions_walk
                  : level == ActivityLevel.moderate ? Icons.fitness_center
                  : level == ActivityLevel.active ? Icons.directions_run
                  : Icons.sports_martial_arts,
              title: level == ActivityLevel.sedentary ? l10n.activitySedentary
                  : level == ActivityLevel.light ? l10n.activityLight
                  : level == ActivityLevel.moderate ? l10n.activityModerate
                  : level == ActivityLevel.active ? l10n.activityActive
                  : l10n.activityVeryActive,
              isSelected: state.activityLevel == level,
              onTap: () => ref.read(onboardingProvider.notifier).setActivityLevel(level),
            ),
          )),
        ],
      ),
    );
  }
}

class _PreferencesStep extends StatelessWidget {
  final WidgetRef ref;
  final OnboardingState state;
  final AppLocalizations l10n;
  const _PreferencesStep({required this.ref, required this.state, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingPreferences, style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.unitSystem, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: UnitSystem.values.map((u) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(u == UnitSystem.metric ? l10n.metric : l10n.imperial),
                  selected: state.unitSystem == u,
                  onSelected: (_) => ref.read(onboardingProvider.notifier).setUnitSystem(u),
                ),
              ),
            )).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.dietaryPreference, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: DietaryPreference.values.map((d) => ChoiceChip(
              label: Text(d == DietaryPreference.none ? l10n.none
                  : d == DietaryPreference.vegetarian ? l10n.vegetarian
                  : d == DietaryPreference.vegan ? l10n.vegan
                  : d == DietaryPreference.keto ? 'Keto'
                  : d == DietaryPreference.paleo ? 'Paleo'
                  : l10n.mediterranean),
              selected: state.dietaryPreference == d,
              onSelected: (_) => ref.read(onboardingProvider.notifier).setDietaryPreference(d),
            )).toList(),
          ),
        ],
      ),
    );
  }
}