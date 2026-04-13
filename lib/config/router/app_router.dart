import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/progress/progress_screen.dart';
import '../../features/log/log_screen.dart';
import '../../features/habits/habits_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/weight/add_weight_screen.dart';
import '../../features/measurements/add_measurement_screen.dart';
import '../../features/meals/add_meal_screen.dart';
import '../../features/water/add_water_screen.dart';
import '../../features/workout/add_workout_screen.dart';
import '../../features/analytics/analytics_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/static/static_pages.dart';
import '../theme/app_colors.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter(String initialLocation) {
  return GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: initialLocation,
  debugLogDiagnostics: true,
  routes: [
    // Splash
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    // Onboarding
    GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
    // Auth
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    // Main shell with bottom nav
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        final String location = state.uri.path;
        int currentIndex = 0;
        if (location.startsWith('/progress')) currentIndex = 1;
        else if (location.startsWith('/log')) currentIndex = 2;
        else if (location.startsWith('/habits')) currentIndex = 3;
        else if (location.startsWith('/profile')) currentIndex = 4;

        return Scaffold(
          body: child,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                final paths = ['/home', '/progress', '/log', '/habits', '/profile'];
                context.go(paths[index]);
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              indicatorColor: AppColors.primary.withValues(alpha: 0.1),
              height: 64,
              destinations: [
                NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: const Icon(Icons.trending_up_outlined), selectedIcon: const Icon(Icons.trending_up), label: 'Fortschritt'),
                NavigationDestination(icon: const Icon(Icons.add_circle_outline), selectedIcon: const Icon(Icons.add_circle), label: 'Erfassen'),
                NavigationDestination(icon: const Icon(Icons.check_circle_outline), selectedIcon: const Icon(Icons.check_circle), label: 'Gewohnheiten'),
                NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: 'Profil'),
              ],
            ),
          ),
        );
      },
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/progress', builder: (context, state) => const ProgressScreen()),
        GoRoute(path: '/log', builder: (context, state) => const LogScreen()),
        GoRoute(path: '/habits', builder: (context, state) => const HabitsScreen()),
        GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
      ],
    ),
    // Add-entry screens (outside shell)
    GoRoute(path: '/add-weight', builder: (context, state) => const AddWeightScreen()),
    GoRoute(path: '/add-meal', builder: (context, state) => const AddMealScreen()),
    GoRoute(path: '/add-water', builder: (context, state) => const AddWaterScreen()),
    GoRoute(path: '/add-workout', builder: (context, state) => const AddWorkoutScreen()),
    GoRoute(path: '/add-measurement', builder: (context, state) => const AddMeasurementScreen()),
    // Analytics
    GoRoute(path: '/analytics', builder: (context, state) => const AnalyticsScreen()),
    // Settings
    GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    GoRoute(path: '/settings/language', builder: (context, state) => const LanguageSettingsScreen()),
    GoRoute(path: '/settings/theme', builder: (context, state) => const ThemeSettingsScreen()),
    GoRoute(path: '/settings/notifications', builder: (context, state) => const NotificationSettingsScreen()),
    // Static pages
    GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
    GoRoute(path: '/privacy', builder: (context, state) => const PrivacyPolicyScreen()),
    GoRoute(path: '/terms', builder: (context, state) => const TermsScreen()),
  ],
);
}
