import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );
    _scaleIn = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack)),
    );
    _controller.forward();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    // Add delay for splash animation
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    
    try {
      // Check if user has completed onboarding
      final isOnboarded = await _checkOnboardingStatus();
      
      if (isOnboarded) {
        // User has completed onboarding, go to home
        context.go('/home');
      } else {
        // User needs to complete onboarding
        context.go('/onboarding');
      }
    } catch (e) {
      // Fallback to onboarding if there's an error
      debugPrint('Error checking onboarding status: $e');
      context.go('/onboarding');
    }
  }

  Future<bool> _checkOnboardingStatus() async {
    try {
      // Initialize LocalStorage if needed
      // Note: In a real app, LocalStorage.init() should be called in main()
      // For now, we'll check the Hive box directly
      final appDir = await getApplicationDocumentsDirectory();
      final hivePath = appDir.path;
      
      // Check if Hive is initialized
      if (!Hive.isBoxOpen('user_profile')) {
        Hive.init(hivePath);
        await Hive.openBox('user_profile');
        await Hive.openBox('app_settings');
      }
      
      final userBox = Hive.box('user_profile');
      final settingsBox = Hive.box('app_settings');
      
      // Check both boxes for onboarding status
      final isOnboarded = userBox.get('is_onboarded', defaultValue: false) ||
                         settingsBox.get('is_onboarded', defaultValue: false);
      
      debugPrint('Onboarding status check: $isOnboarded');
      return isOnboarded;
    } catch (e) {
      debugPrint('Error in _checkOnboardingStatus: $e');
      return false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeIn.value,
              child: Transform.scale(
                scale: _scaleIn.value,
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  size: 44,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'GewichtsKompass',
                style: AppTypography.headlineMedium.copyWith(
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Dein Weg zu einem gesunden Gewicht',
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}