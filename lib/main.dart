import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/smooth_scroll_behavior.dart';
import 'data/database/app_database.dart';
import 'providers/auth_provider.dart';
import 'providers/guide_provider.dart';
import 'providers/bookmark_provider.dart';
import 'providers/history_provider.dart';
import 'providers/theme_settings_provider.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi database SQLite (atau memory fallback di web)
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
            // 1. Scroll sangat halus di semua perangkat (touch, mouse, trackpad)
            scrollBehavior: const SmoothScrollBehavior(),
            themeMode: settings.flutterThemeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            builder: (context, child) {
              // 2. Skala ukuran font dinamis di seluruh aplikasi
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(settings.fontScale),
                ),
                child: child!,
              );
            },
            // 3. Splash Screen Neobrutalisme sebagai titik masuk pertama
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
