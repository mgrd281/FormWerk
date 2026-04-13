import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'config/theme/app_theme.dart';
import 'config/router/app_router.dart';
import 'config/localization/app_localizations.dart';
import 'core/providers/app_providers.dart';
import 'features/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const ProviderScope(child: GewichtsKompassApp()));
}

class GewichtsKompassApp extends ConsumerWidget {
  const GewichtsKompassApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeMode = AppThemeMode.system;
    var locale = const Locale('de');
    var authState = const AuthState(status: AuthStatus.unknown);

    try {
      themeMode = ref.watch(themeModeProvider);
      locale = ref.watch(localeProvider);
      authState = ref.watch(authProvider);
    } catch (e) {
      debugPrint('Provider watch failed: $e');
    }

    // Determine initial location based on auth state
    String initialLocation = '/splash';
    switch (authState.status) {
      case AuthStatus.authenticated:
        initialLocation = '/home';
      case AuthStatus.onboarding:
        initialLocation = '/onboarding';
      case AuthStatus.unauthenticated:
        initialLocation = '/login';
      case AuthStatus.unknown:
        initialLocation = '/splash';
    }

    GoRouter router;
    try {
      router = createAppRouter(initialLocation);
    } catch (e) {
      debugPrint('Router creation failed: $e');
      router = GoRouter(
        initialLocation: '/splash',
        routes: [
          GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        ],
      );
    }

    ThemeData lightTheme;
    ThemeData darkTheme;
    try {
      lightTheme = AppTheme.lightTheme;
      darkTheme = AppTheme.darkTheme;
    } catch (e) {
      debugPrint('Theme creation failed: $e');
      lightTheme = ThemeData.light(useMaterial3: true);
      darkTheme = ThemeData.dark(useMaterial3: true);
    }

    final themeModeValue = _mapThemeMode(themeMode);

    return MaterialApp.router(
      title: 'GewichtsKompass',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeModeValue,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }

  ThemeMode _mapThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}