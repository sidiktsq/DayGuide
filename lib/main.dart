import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'data/database/app_database.dart';
import 'providers/auth_provider.dart';
import 'providers/guide_provider.dart';
import 'providers/bookmark_provider.dart';
import 'providers/history_provider.dart';
import 'providers/theme_settings_provider.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SQLite database (runs SQLite on mobile/desktop, or fallback on web)
  try {
    await AppDatabase.instance.database;
  } catch (e) {
    debugPrint('Database startup notice: $e');
  }

  runApp(const DayGuideApp());
}

class DayGuideApp extends StatelessWidget {
  const DayGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GuideProvider()..loadInitialData(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookmarkProvider()..loadBookmarks(),
        ),
        ChangeNotifierProvider(
          create: (_) => HistoryProvider()..loadHistory(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeSettingsProvider(),
        ),
      ],
      child: Consumer<ThemeSettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'DAYGUIDE',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: Consumer<AuthProvider>(
              builder: (context, auth, _) {
                // Alur aplikasi: Jika belum login, WAJIB ke halaman Login / Sign In
                if (!auth.isLoggedIn) {
                  return const SignInScreen();
                }
                return const MainNavigationScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
