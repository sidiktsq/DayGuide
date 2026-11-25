import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_badge.dart';
import '../../core/widgets/neobrutalist_button.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_settings_provider.dart';
import '../../providers/bookmark_provider.dart';
import '../../providers/history_provider.dart';
import '../tersimpan/tersimpan_screen.dart';
import '../riwayat/riwayat_membaca_screen.dart';
import '../pengaturan/pengaturan_screen.dart';
import '../auth/sign_in_screen.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  void _showLogoutDialog(BuildContext context, AuthProvider auth, BookmarkProvider bookmarks, HistoryProvider history) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 2.5),
        ),
        title: Row(
          children: [
            const Icon(Icons.logout, color: AppColors.tertiary, size: 24),
            const SizedBox(width: 8),
            Text('Keluar Akun', style: AppTypography.headlineSm()),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari akun DAYGUIDE? Anda wajib masuk akun kembali untuk melanjutkan.',
          style: AppTypography.bodyMd(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: AppTypography.labelMd()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.softRed,
              foregroundColor: AppColors.ink,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppColors.border, width: 1.5),
              ),
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              auth.logout();
              await bookmarks.clearAll();
              await history.clearAll();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SignInScreen()),
                (route) => false,
              );
            },
            child: Text('Ya, Keluar', style: AppTypography.labelMd(color: AppColors.ink)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppTopBar(
        title: 'Profil',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 22, color: AppColors.ink),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PengaturanScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. User Profile Header Card
              NeobrutalistCard(
                backgroundColor: AppColors.cardWhite,
                borderRadius: 18,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.border, width: 2.5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.ink,
                                    offset: Offset(3, 3),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(Icons.person, size: 40, color: AppColors.ink),
                              ),
                            ),
                            Positioned(
                              bottom: -4,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.cardWhite,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.border, width: 1.5),
                                ),
                                child: const Icon(Icons.bolt, size: 14, color: AppColors.coral),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authProvider.userName,
                                style: AppTypography.headlineSm(),
                              ),
                              const SizedBox(height: 4),
                              NeobrutalistBadge(
                                text: '${authProvider.userRank} • Level ${authProvider.userLevel}',
                                icon: const Icon(Icons.stars, size: 13, color: AppColors.primary),
                                backgroundColor: authProvider.userLevel == 1 ? AppColors.secondaryFixed : AppColors.mint,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                shadowOffset: 0,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                authProvider.userEmail.isNotEmpty
                                    ? '${authProvider.userHandle} • ${authProvider.userEmail}'
                                    : '${authProvider.userHandle} • Baru Bergabung',
                                style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Action: Ubah Profil
                    GestureDetector(
                      onTap: () => _showEditProfileDialog(context, authProvider),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.edit, size: 16, color: AppColors.ink),
                            const SizedBox(width: 6),
                            Text('Ubah Profil Saya', style: AppTypography.labelSm()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 2. Learning Statistics Cards (Real-time dynamic from Providers)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.insights, size: 18, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text('STATISTIK BELAJAR', style: AppTypography.labelMd()),
                    ],
                  ),
                  Text('Akun Aktif', style: AppTypography.bodySm()),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.ink,
                            offset: Offset(2.5, 2.5),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.task_alt, size: 20, color: AppColors.primary),
                          const SizedBox(height: 8),
                          Text('${historyProvider.completedCount}', style: AppTypography.headlineLg()),
                          Text('Panduan Selesai', style: AppTypography.labelSm()),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.ink,
                            offset: Offset(2.5, 2.5),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.bookmark, size: 20, color: AppColors.secondary),
                          const SizedBox(height: 8),
                          Text('${bookmarkProvider.bookmarkedGuides.length}', style: AppTypography.headlineLg()),
                          Text('Tersimpan', style: AppTypography.labelSm()),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.coral,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.ink,
                            offset: Offset(2.5, 2.5),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.local_fire_department, size: 20, color: AppColors.cardWhite),
                          const SizedBox(height: 8),
                          Text('${authProvider.streakDays} Hari', style: AppTypography.headlineLg(color: AppColors.ink)),
                          Text('Streak Belajar', style: AppTypography.labelSm()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // 3. Quick Menu Shortcuts
              Text('MENU UTAMA', style: AppTypography.labelMd()),
              const SizedBox(height: 10),
              _buildMenuRow(
                icon: Icons.bookmark,
                iconBg: AppColors.secondaryFixed,
                iconColor: AppColors.secondary,
                title: 'Panduan Tersimpan',
                subtitle: '${bookmarkProvider.bookmarkedGuides.length} panduan siap dipraktikkan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TersimpanScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildMenuRow(
                icon: Icons.history,
                iconBg: AppColors.primaryFixed,
                iconColor: AppColors.primary,
                title: 'Riwayat Membaca',
                subtitle: '${historyProvider.totalGuidesRead} panduan telah dibuka',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RiwayatMembacaScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildMenuRow(
                icon: Icons.settings,
                iconBg: AppColors.surfaceContainerHigh,
                iconColor: AppColors.onSurfaceVariant,
                title: 'Pengaturan Aplikasi',
                subtitle: 'Tema, font, notifikasi, dan akun',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PengaturanScreen()),
                  );
                },
              ),
              const SizedBox(height: 22),

              // 4. Support & Community
              Text('DUKUNGAN & KOMUNITAS', style: AppTypography.labelMd()),
              const SizedBox(height: 10),
              NeobrutalistCard(
                backgroundColor: AppColors.cardWhite,
                borderRadius: 16,
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _buildSupportItem(Icons.tips_and_updates, 'Usul Panduan Baru', 'Ajukan tutorial yang ingin kamu pelajari'),
                    const Divider(color: AppColors.border, thickness: 1),
                    _buildSupportItem(Icons.star, 'Nilai Aplikasi DAYGUIDE', 'Bantu kami berkembang lebih baik'),
                    const Divider(color: AppColors.border, thickness: 1),
                    _buildSupportItem(Icons.chat_bubble_outline, 'Hubungi Tim Pengembang', 'Bantuan dan pertanyaan via email/chat'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 5. Logout Button
              NeobrutalistButton(
                width: double.infinity,
                height: 50,
                backgroundColor: AppColors.softRed,
                onPressed: () => _showLogoutDialog(context, authProvider, bookmarkProvider, historyProvider),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout, size: 20, color: AppColors.ink),
                    const SizedBox(width: 8),
                    Text('Keluar dari Akun', style: AppTypography.labelMd(color: AppColors.ink)),
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

  Widget _buildMenuRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? badgeText,
    required VoidCallback onTap,
  }) {
    return NeobrutalistCard(
      backgroundColor: AppColors.cardWhite,
      borderRadius: 14,
      padding: const EdgeInsets.all(12),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border, width: 2),
            ),
            child: Center(
              child: Icon(icon, size: 22, color: iconColor),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: AppTypography.headlineSm()),
                    if (badgeText != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.ink,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badgeText,
                          style: AppTypography.labelSm(color: AppColors.mint),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(subtitle, style: AppTypography.bodySm()),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward, size: 18, color: AppColors.ink),
        ],
      ),
    );
  }

  Widget _buildSupportItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.ink),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelMd()),
                Text(subtitle, style: AppTypography.bodySm()),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 18, color: AppColors.ink),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, AuthProvider auth) {
    final nameController = TextEditingController(text: auth.userName);
    final emailController = TextEditingController(text: auth.userEmail);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 2.5),
        ),
        title: Text('Ubah Profil', style: AppTypography.headlineSm()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Alamat Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: AppColors.ink,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppColors.border, width: 1.5),
              ),
            ),
            onPressed: () {
              auth.updateProfile(
                name: nameController.text.trim(),
                email: emailController.text.trim(),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
