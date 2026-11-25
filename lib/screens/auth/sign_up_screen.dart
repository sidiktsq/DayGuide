import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_input.dart';
import '../../core/widgets/neobrutalist_button.dart';
import '../../core/widgets/neobrutalist_badge.dart';
import '../../providers/auth_provider.dart';
import '../../providers/bookmark_provider.dart';
import '../../providers/history_provider.dart';
import '../main_navigation_screen.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _termsAccepted = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty) {
      _showErrorSnackBar('Harap masukkan nama lengkap Anda.');
      return;
    }

    if (email.isEmpty || !email.contains('@')) {
      _showErrorSnackBar('Harap masukkan alamat email yang valid.');
      return;
    }

    if (password.length < 6) {
      _showErrorSnackBar('Kata sandi minimal 6 karakter.');
      return;
    }

    if (password != confirmPassword) {
      _showErrorSnackBar('Konfirmasi kata sandi tidak cocok.');
      return;
    }

    if (!_termsAccepted) {
      _showErrorSnackBar('Harap setujui Syarat & Ketentuan serta Kebijakan Privasi.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: false);
      final historyProvider = Provider.of<HistoryProvider>(context, listen: false);

      // Register new user (Level 1, Streak 0)
      authProvider.register(
        name: name,
        email: email,
        password: password,
      );

      // Pastikan akun baru benar-benar KOSONG (0 tersimpan, 0 riwayat terbaca)
      await bookmarkProvider.clearAll();
      await historyProvider.clearAll();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.ink,
          content: Text('Akun berhasil dibuat! Selamat datang di DAYGUIDE, $name!', style: AppTypography.bodyMd(color: AppColors.cardWhite)),
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
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.tertiary,
        content: Text(message, style: AppTypography.bodyMd(color: AppColors.cardWhite)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SignInScreen()),
                        );
                      }
                    },
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
                          Text('Kembali ke Masuk', style: AppTypography.labelSm()),
                        ],
                      ),
                    ),
                  ),
                  NeobrutalistBadge(
                    text: 'Gratis & Mudah',
                    icon: const Text('🚀', style: TextStyle(fontSize: 12)),
                    backgroundColor: AppColors.primaryFixed,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text('Daftar Akun Baru 🚀', style: AppTypography.headlineLg()),
              const SizedBox(height: 4),
              Text(
                'Buat akun barumu untuk memulai progres belajar dari Level 1 dan jelajahi ratusan panduan praktis.',
                style: AppTypography.bodyMd(),
              ),
              const SizedBox(height: 14),

              // Benefit Highlight Card
              NeobrutalistCard(
                backgroundColor: AppColors.secondaryFixed,
                borderRadius: 14,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.stars, size: 18, color: AppColors.secondary),
                        const SizedBox(width: 6),
                        Text('KEUNTUNGAN AKUN BARU', style: AppTypography.labelSm(color: AppColors.onSecondaryFixed)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildBenefitRow('Akses penuh ke seluruh kategori panduan'),
                    _buildBenefitRow('Simpan panduan favorit untuk akses offline'),
                    _buildBenefitRow('Catat riwayat dan checklist langkah belajar'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Form Pendaftaran Card
              NeobrutalistCard(
                backgroundColor: AppColors.cardWhite,
                borderRadius: 16,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nama Lengkap *', style: AppTypography.labelMd()),
                    const SizedBox(height: 6),
                    NeobrutalistInput(
                      controller: _nameController,
                      hintText: 'Contoh: Ahmad Rizki',
                      prefixIcon: const Icon(Icons.person, size: 20, color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 12),
                    Text('Alamat Email *', style: AppTypography.labelMd()),
                    const SizedBox(height: 6),
                    NeobrutalistInput(
                      controller: _emailController,
                      hintText: 'nama@email.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email, size: 20, color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 12),
                    Text('Kata Sandi *', style: AppTypography.labelMd()),
                    const SizedBox(height: 6),
                    NeobrutalistInput(
                      controller: _passwordController,
                      hintText: 'Minimal 6 karakter unik',
                      obscureText: _obscurePassword,
                      prefixIcon: const Icon(Icons.lock, size: 20, color: AppColors.onSurfaceVariant),
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
                    Text('Ulangi Kata Sandi *', style: AppTypography.labelMd()),
                    const SizedBox(height: 6),
                    NeobrutalistInput(
                      controller: _confirmPasswordController,
                      hintText: 'Ketik ulang kata sandi',
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_reset, size: 20, color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Checkbox(
                          value: _termsAccepted,
                          onChanged: (v) => setState(() => _termsAccepted = v ?? false),
                          activeColor: AppColors.primaryContainer,
                          checkColor: AppColors.ink,
                        ),
                        Expanded(
                          child: Text(
                            'Saya menyetujui Syarat & Ketentuan serta Kebijakan Privasi DAYGUIDE.',
                            style: AppTypography.bodySm(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    NeobrutalistButton(
                      width: double.infinity,
                      height: 50,
                      text: _isLoading ? 'Membuat Akun...' : 'Daftar Sekarang',
                      icon: Icons.how_to_reg,
                      onPressed: _isLoading ? () {} : _handleSignUp,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Switch to Sign In
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignInScreen()),
                      );
                    }
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Sudah memiliki akun? ',
                      style: AppTypography.bodyMd(),
                      children: [
                        TextSpan(
                          text: 'Masuk di sini',
                          style: AppTypography.labelMd(color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.cardWhite,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: const Center(
              child: Text('✓', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondary)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: AppTypography.bodySm())),
        ],
      ),
    );
  }
}
