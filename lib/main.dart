import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/theme/app_theme.dart';
import 'config/router/app_router.dart';
import 'config/localization/app_localizations.dart';
import 'core/providers/app_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: GewichtsKompassApp()));
}

class GewichtsKompassApp extends ConsumerWidget {
  const GewichtsKompassApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final authState = ref.watch(authProvider);

    // Determine initial location based on auth state
    String initialLocation;
    switch (authState.status) {
      case AuthStatus.authenticated:
        initialLocation = '/home';
        break;
      case AuthStatus.onboarding:
        initialLocation = '/onboarding';
        break;
      case AuthStatus.unauthenticated:
        initialLocation = '/login';
        break;
      case AuthStatus.unknown:
        initialLocation = '/splash';
        break;
    }

    final router = createAppRouter(initialLocation);

    return MaterialApp.router(
      title: 'GewichtsKompass',
      debugShowCheckedModeBanner: false,
      
      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _mapThemeMode(themeMode),
      
      // Localization
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Router
      routerConfig: router,
    );
  }

  ThemeMode _mapThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light: return ThemeMode.light;
      case AppThemeMode.dark: return ThemeMode.dark;
      case AppThemeMode.system: return ThemeMode.system;
    }
  }
}