import 'dart:async';
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

/// Global error handler – prevents crashes on iOS
void _handleError(Object error, StackTrace stackTrace) {
  debugPrint('🔴 FATAL ERROR: $error');
  debugPrint('🔴 STACK: $stackTrace');
  // Never rethrow – keep the app alive
}

/// Crash-safe entry point
void main() {
  // Catch ALL unhandled async errors
  runZonedGuarded(
    () {
      // Set up Flutter error handling
      FlutterError.onError = (FlutterErrorDetails details) {
        debugPrint('⚠️ Flutter Error: ${details.exception}');
        debugPrint('⚠️ Stack: ${details.stack}');
        // Don't crash – just log
      };

      WidgetsFlutterBinding.ensureInitialized();

      // Lock orientation to portrait
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).catchError((e) {
        debugPrint('⚠️ Orientation lock failed: $e');
      });

      runApp(const CrashProofApp());
    },
    _handleError,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        // Capture all print statements
        debugPrint(line);
      },
    ),
  );
}

/// Wrapper that catches build-time errors and shows a safe fallback UI
class CrashProofApp extends StatelessWidget {
  const CrashProofApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: GewichtsKompassApp());
  }
}

class GewichtsKompassApp extends ConsumerWidget {
  const GewichtsKompassApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Wrap everything in an ErrorBoundary
    return ErrorBoundary(
      child: _buildApp(context, ref),
    );
  }

  Widget _buildApp(BuildContext context, WidgetRef ref) {
    var themeMode = AppThemeMode.system;
    var locale = const Locale('de');
    var authState = const AuthState(status: AuthStatus.unknown);

    try {
      themeMode = ref.watch(themeModeProvider);
      locale = ref.watch(localeProvider);
      authState = ref.watch(authProvider);
    } catch (e) {
      debugPrint('⚠️ Provider watch failed: $e');
    }

    // Determine initial location based on auth state
    String initialLocation = '/splash';
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

    GoRouter router;
    try {
      router = createAppRouter(initialLocation);
    } catch (e) {
      debugPrint('⚠️ Router creation failed: $e');
      // Fallback: minimal router that just shows splash
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
      debugPrint('⚠️ Theme creation failed: $e');
      lightTheme = ThemeData.light(useMaterial3: true);
      darkTheme = ThemeData.dark(useMaterial3: true);
    }

    final themeModeValue = _mapThemeMode(themeMode);

    return MaterialApp.router(
      title: 'GewichtsKompass',
      debugShowCheckedModeBanner: false,
      
      // Theme
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeModeValue,
      
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

/// Error Boundary widget – catches render errors and shows a safe fallback
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  const ErrorBoundary({super.key, required this.child});

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;

  @override
  void initState() {
    super.initState();
    // Listen to Flutter errors at the widget level
    FlutterError.onError = (FlutterErrorDetails details) {
      if (!details.silent) {
        setState(() {
          _error = details.exception;
          _stackTrace = details.stack;
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      debugPrint('🔴 ErrorBoundary caught: $_error');
      debugPrint('🔴 Stack: $_stackTrace');
      
      return MaterialApp(
        title: 'GewichtsKompass',
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.refresh, size: 48, color: Color(0xFF2D8B6E)),
                  const SizedBox(height: 16),
                  const Text(
                    'GewichtsKompass',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_error',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => setState(() {
                      _error = null;
                      _stackTrace = null;
                    }),
                    icon: const Icon(Icons.replay),
                    label: const Text('Neu laden'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D8B6E),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return widget.child;
  }
}