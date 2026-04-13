import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: Implement actual auth
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xl),
                // Logo
                Center(
                  child: Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.explore_rounded, size: 36, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Center(
                  child: Text(l10n.welcomeBack, style: AppTypography.headlineMedium),
                ),
                const SizedBox(height: AppSpacing.xs),
                Center(
                  child: Text(l10n.welcomeBackDesc, style: AppTypography.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  )),
                ),
                const SizedBox(height: AppSpacing.xxl),
                PremiumInputField(
                  label: l10n.email,
                  hint: l10n.emailHint,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined, size: 20),
                  validator: (v) => v == null || !v.contains('@') ? l10n.invalidEmail : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                PremiumInputField(
                  label: l10n.password,
                  hint: l10n.passwordHint,
                  controller: _passwordController,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  validator: (v) => v == null || v.length < 6 ? l10n.invalidPassword : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {/* TODO: forgot password */},
                    child: Text(l10n.forgotPassword, style: AppTypography.bodySmall.copyWith(color: AppColors.primary)),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                PremiumButton(
                  label: l10n.signIn,
                  onPressed: _signIn,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: AppSpacing.lg),
                // Social sign in
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Text(l10n.or, style: AppTypography.bodySmall.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                      )),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                PremiumButton(
                  label: l10n.signInWithGoogle,
                  isOutlined: true,
                  icon: Icons.g_mobiledata,
                  onPressed: () {/* TODO: Google sign in */},
                ),
                const SizedBox(height: AppSpacing.md),
                PremiumButton(
                  label: l10n.continueAsGuest,
                  isOutlined: true,
                  icon: Icons.person_outline,
                  onPressed: () => context.go('/home'),
                ),
                const SizedBox(height: AppSpacing.xl),
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/signup'),
                    child: RichText(
                      text: TextSpan(
                        text: '${l10n.noAccount} ',
                        style: AppTypography.bodyMedium.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                        children: [
                          TextSpan(
                            text: l10n.signUp,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}