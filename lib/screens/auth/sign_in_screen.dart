import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_input.dart';
import '../../core/widgets/neobrutalist_button.dart';
import '../../core/widgets/neobrutalist_badge.dart';
import '../../providers/auth_provider.dart';
import '../main_navigation_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    final email = _usernameController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.ink,
          content: Text('Harap masukkan email atau username Anda.', style: AppTypography.bodyMd(color: AppColors.cardWhite)),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.ink,
          content: Text('Harap masukkan kata sandi Anda.', style: AppTypography.bodyMd(color: AppColors.cardWhite)),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Login via AuthProvider
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.login(email: email);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.ink,
        content: Text('Selamat datang kembali, ${authProvider.userName}!', style: AppTypography.bodyMd(color: AppColors.cardWhite)),
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    }
  }

  void _handleSocialLogin(String providerName, String email, String name) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.login(email: email, name: name);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.ink,
        content: Text('Berhasil masuk dengan $providerName!', style: AppTypography.bodyMd(color: AppColors.cardWhite)),
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final canGoBack = Navigator.canPop(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Nav Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (canGoBack)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.ink,
                              offset: Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back, size: 16, color: AppColors.ink),
                            const SizedBox(width: 4),
                            Text('Kembali', style: AppTypography.labelSm()),
                          ],
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.ink,
                            offset: Offset(2, 2),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.menu_book, size: 16, color: AppColors.ink),
                          const SizedBox(width: 6),
                          Text('DAYGUIDE APP', style: AppTypography.labelSm()),
                        ],
                      ),
                    ),
                  NeobrutalistBadge(
                    text: 'Wajib Masuk Akun',
                    icon: const Icon(Icons.lock, size: 14, color: AppColors.ink),
                    backgroundColor: AppColors.secondaryFixed,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Brand Header Card
              NeobrutalistCard(
                backgroundColor: AppColors.cardWhite,
                borderRadius: 16,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border, width: 2),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.ink,
                                offset: Offset(2.5, 2.5),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/app_logo.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(Icons.explore, size: 24, color: AppColors.ink),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('DAYGUIDE', style: AppTypography.headlineSm()),
                            Text('PANDUAN PRAKTIS HARIAN', style: AppTypography.labelSm(color: AppColors.onSurfaceVariant)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('Masuk ke Akunmu 👋', style: AppTypography.headlineLg()),
                    const SizedBox(height: 6),
                    Text(
                      'Silakan masuk akun untuk membuka katalog panduan, menyimpan tutorial, dan mencatat progres harianmu.',
                      style: AppTypography.bodyMd(),
                    ),
                    const SizedBox(height: 10),
                    NeobrutalistBadge(
                      text: 'Keamanan Data Terenkripsi',
                      icon: const Icon(Icons.verified_user, size: 14, color: AppColors.ink),
                      backgroundColor: AppColors.mint,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Form Masuk Card
              NeobrutalistCard(
                backgroundColor: AppColors.cardWhite,
                borderRadius: 16,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email atau Username', style: AppTypography.labelMd()),
                    const SizedBox(height: 6),
                    NeobrutalistInput(
                      controller: _usernameController,
                      hintText: 'contoh@email.com atau username',
                      prefixIcon: const Icon(Icons.mail, size: 20, color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 14),
                    Text('Kata Sandi', style: AppTypography.labelMd()),
                    const SizedBox(height: 6),
                    NeobrutalistInput(
                      controller: _passwordController,
                      hintText: 'Masukkan kata sandi',
                      obscureText: _obscurePassword,
                      prefixIcon: const Icon(Icons.key, size: 20, color: AppColors.onSurfaceVariant),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          size: 20,
                          color: AppColors.ink,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (v) => setState(() => _rememberMe = v ?? true),
                              activeColor: AppColors.primaryContainer,
                              checkColor: AppColors.ink,
                            ),
                            Text('Ingat Saya', style: AppTypography.labelSm()),
                          ],
                        ),
                        Text(
                          'Lupa Kata Sandi?',
                          style: AppTypography.labelSm(color: AppColors.secondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    NeobrutalistButton(
                      width: double.infinity,
                      height: 50,
                      text: 'Masuk Sekarang',
                      icon: Icons.arrow_forward,
                      onPressed: _handleSignIn,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.border, thickness: 1.5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('ATAU MASUK LEWAT', style: AppTypography.labelSm()),
                  ),
                  const Expanded(child: Divider(color: AppColors.border, thickness: 1.5)),
                ],
              ),
              const SizedBox(height: 14),

              // Social Logins
              NeobrutalistButton(
                width: double.infinity,
                height: 48,
                backgroundColor: AppColors.cardWhite,
                onPressed: () => _handleSocialLogin('Google', 'user@gmail.com', 'Pengguna Google'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.g_mobiledata, size: 28, color: Colors.blue),
                    const SizedBox(width: 6),
                    Text('Lanjutkan dengan Google', style: AppTypography.labelMd()),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              NeobrutalistButton(
                width: double.infinity,
                height: 48,
                backgroundColor: AppColors.secondaryFixed,
                onPressed: () => _handleSocialLogin('Belajar.id', 'siswa@belajar.id', 'Siswa Belajar.id'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.school, size: 20, color: AppColors.secondary),
                    const SizedBox(width: 8),
                    Text('Lanjutkan dengan Akun Belajar.id', style: AppTypography.labelMd(color: AppColors.onSecondaryFixed)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Belum Punya Akun Card
              NeobrutalistCard(
                backgroundColor: AppColors.surfaceContainerLow,
                borderRadius: 14,
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Belum punya akun?', style: AppTypography.labelMd()),
                          Text('Wajib daftar akun baru terlebih dahulu.', style: AppTypography.bodySm()),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignUpScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.ink,
                              offset: Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text('Daftar', style: AppTypography.labelSm(color: AppColors.ink)),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_outward, size: 14, color: AppColors.ink),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
