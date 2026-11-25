import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/neobrutalist_badge.dart';
import '../../providers/auth_provider.dart';
import '../auth/sign_in_screen.dart';
import '../main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  double _loadProgress = 0.0;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _animController.forward();

    // Progress bar animation
    _progressTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!mounted) return;
      setState(() {
        _loadProgress += 0.025;
        if (_loadProgress >= 1.0) {
          _loadProgress = 1.0;
          timer.cancel();
          _checkSessionAndNavigate();
        }
      });
    });
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void _checkSessionAndNavigate() {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    // Navigasi dengan transisi fade halus
    final Widget destination =
        auth.isLoggedIn ? const MainNavigationScreen() : const SignInScreen();

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // Animated App Icon Box with Neobrutalism drop shadow
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border, width: 3),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.ink,
                            offset: Offset(4.5, 4.5),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/app_logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.explore, size: 56, color: AppColors.ink),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // App Brand Name & Subtitle
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        'DAYGUIDE',
                        style: AppTypography.headlineXl().copyWith(
                          letterSpacing: -1,
                          fontSize: 34,
                        ),
                      ),
                      const SizedBox(height: 6),
                      NeobrutalistBadge(
                        text: 'PANDUAN PRAKTIS HARIAN',
                        backgroundColor: AppColors.secondaryFixed,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Ratusan tutorial hidup, tips hemat, & skill harian dalam genggaman.',
                        style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 2),

                // Neobrutalist Loading Progress Bar
                Container(
                  width: 220,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: AppColors.border, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.ink,
                        offset: Offset(2, 2),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 220 * _loadProgress,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Menyiapkan panduan hidupmu...',
                  style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
                ),

                const Spacer(),

                // Version & Offline Badge Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.bolt, size: 14, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      'DAYGUIDE v1.0.0 • Modern Neobrutalism',
                      style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
