import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_button.dart';
import '../../providers/theme_settings_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/bookmark_provider.dart';
import '../../providers/history_provider.dart';
import '../auth/sign_in_screen.dart';

class PengaturanScreen extends StatelessWidget {
  const PengaturanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<ThemeSettingsProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(title: 'Pengaturan', showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pengaturan', style: AppTypography.headlineLg()),
              Text('Sesuaikan preferensi aplikasi DAYGUIDE sesuai gayamu.', style: AppTypography.bodySm()),
              const SizedBox(height: 18),

              // SECTION 1: Tampilan & Tema
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.palette, size: 18, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text('TAMPILAN & TEMA', style: AppTypography.labelMd()),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Text('KUSTOM', style: AppTypography.labelSm()),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildThemeOption(
                      title: 'Terang',
                      emoji: '☀️',
                      isActive: settings.themeMode == 'light',
                      onTap: () => settings.setThemeMode('light'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildThemeOption(
                      title: 'Gelap',
                      emoji: '🌙',
                      isActive: settings.themeMode == 'dark',
                      isSoon: true,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildThemeOption(
                      title: 'Sistem',
                      emoji: '⚙️',
                      isActive: settings.themeMode == 'system',
                      onTap: () => settings.setThemeMode('system'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Font Size Selector
              NeobrutalistCard(
                backgroundColor: AppColors.cardWhite,
                borderRadius: 14,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.format_size, size: 20, color: AppColors.ink),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ukuran Teks', style: AppTypography.labelMd()),
                          Text('Sedang (Standar DAYGUIDE)', style: AppTypography.bodySm()),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: settings.decreaseFontSize,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border, width: 1.5),
                            ),
                            child: Text('A-', style: AppTypography.labelSm()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text('${(settings.fontScale * 100).toInt()}%', style: AppTypography.labelSm(color: AppColors.primary)),
                        ),
                        GestureDetector(
                          onTap: settings.increaseFontSize,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border, width: 1.5),
                            ),
                            child: Text('A+', style: AppTypography.labelSm()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // SECTION 2: Notifikasi & Pengingat
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.notifications_active, size: 18, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text('NOTIFIKASI & PENGINGAT', style: AppTypography.labelMd()),
                    ],
                  ),
                  Text('3 Opsi', style: AppTypography.bodySm()),
                ],
              ),
              const SizedBox(height: 10),
              _buildToggleItem(
                icon: Icons.wb_sunny,
                iconBg: AppColors.primaryFixed,
                title: 'Tips Harian Setiap Pagi',
                subtitle: '07:00 WIB (Sarapan ilmu praktis)',
                isActive: settings.dailyMorningTips,
                onToggle: settings.toggleDailyMorningTips,
              ),
              const SizedBox(height: 8),
              _buildToggleItem(
                icon: Icons.auto_awesome,
                iconBg: AppColors.secondaryContainer,
                title: 'Rekomendasi Panduan Baru',
                subtitle: 'Kompilasi praktis setiap Senin',
                isActive: settings.weeklyRecommendations,
                onToggle: settings.toggleWeeklyRecommendations,
              ),
              const SizedBox(height: 8),
              _buildToggleItem(
                icon: Icons.bookmark_add,
                iconBg: AppColors.surfaceContainerHigh,
                title: 'Pengingat Lanjut Membaca',
                subtitle: 'Sentil jika ada panduan tertunda',
                isActive: settings.readingReminders,
                onToggle: settings.toggleReadingReminders,
              ),
              const SizedBox(height: 20),

              // SECTION 3: Unduhan & Offline
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.cloud_sync, size: 18, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text('UNDUHAN & PENYIMPANAN', style: AppTypography.labelMd()),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Text('OFFLINE SIAP', style: AppTypography.labelSm()),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildToggleItem(
                icon: Icons.downloading,
                iconBg: AppColors.secondaryFixed,
                title: 'Simpan Panduan Otomatis',
                subtitle: 'Bisa dibuka saat kuota sekarat',
                isActive: settings.autoOfflineSave,
                onToggle: settings.toggleAutoOfflineSave,
              ),
              const SizedBox(height: 8),
              NeobrutalistCard(
                backgroundColor: AppColors.cardWhite,
                borderRadius: 14,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.cleaning_services, size: 20, color: AppColors.tertiary),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hapus Cache Penyimpanan', style: AppTypography.labelMd()),
                          Text('12.5 MB • File sementara & gambar', style: AppTypography.bodySm()),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.ink,
                            content: Text('Cache berhasil dibersihkan!', style: AppTypography.bodyMd(color: AppColors.cardWhite)),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.tertiaryContainer,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border, width: 1.5),
                        ),
                        child: Text('Bersihkan', style: AppTypography.labelSm(color: AppColors.onTertiaryContainer)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // SECTION 4: Akun & Sesi
              Text('AKUN & SESI PENGGUNA', style: AppTypography.labelMd()),
              const SizedBox(height: 10),
              Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  return NeobrutalistCard(
                    backgroundColor: AppColors.cardWhite,
                    borderRadius: 14,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.border, width: 1.5),
                              ),
                              child: const Center(
                                child: Icon(Icons.account_circle, size: 22, color: AppColors.ink),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(auth.userName, style: AppTypography.labelMd()),
                                  Text(
                                    auth.userEmail.isNotEmpty ? auth.userEmail : 'Level ${auth.userLevel} • ${auth.userRank}',
                                    style: AppTypography.bodySm(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: AppColors.border, thickness: 1),
                        const SizedBox(height: 8),
                        NeobrutalistButton(
                          width: double.infinity,
                          height: 44,
                          backgroundColor: AppColors.softRed,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: AppColors.background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: const BorderSide(color: AppColors.border, width: 2.5),
                                ),
                                title: Text('Keluar dari Akun', style: AppTypography.headlineSm()),
                                content: Text(
                                  'Apakah Anda yakin ingin keluar? Anda harus masuk kembali untuk mengakses panduan.',
                                  style: AppTypography.bodyMd(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text('Batal'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.softRed,
                                      foregroundColor: AppColors.ink,
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(ctx);
                                      final bookmarks = Provider.of<BookmarkProvider>(context, listen: false);
                                      final history = Provider.of<HistoryProvider>(context, listen: false);
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
                                    child: const Text('Ya, Keluar'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.logout, size: 18, color: AppColors.ink),
                              const SizedBox(width: 6),
                              Text('Keluar Akun', style: AppTypography.labelMd()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // SECTION 5: Informasi & Legal
              Text('INFORMASI & LEGAL', style: AppTypography.labelMd()),
              const SizedBox(height: 10),
              NeobrutalistCard(
                backgroundColor: AppColors.cardWhite,
                borderRadius: 14,
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _buildLegalRow('Kebijakan Privasi', 'Data Anda aman dan tidak dijual ke pihak ketiga'),
                    const Divider(color: AppColors.border, thickness: 1),
                    _buildLegalRow('Syarat & Ketentuan Penggunaan', 'Ketentuan lisensi konten edukasi'),
                    const Divider(color: AppColors.border, thickness: 1),
                    _buildLegalRow('Tentang DAYGUIDE (Versi 1.0.0)', 'Aplikasi panduan sehari-hari Neobrutalisme'),
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

  Widget _buildThemeOption({
    required String title,
    required String emoji,
    required bool isActive,
    bool isSoon = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isSoon ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryContainer : AppColors.cardWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink,
              offset: Offset(isActive ? 1.5 : 2.5, isActive ? 1.5 : 2.5),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            Text(title, style: AppTypography.labelSm()),
            if (isActive)
              Text('(Aktif)', style: AppTypography.labelSm(color: AppColors.primary))
            else if (isSoon)
              Text('Segera', style: AppTypography.labelSm(color: AppColors.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required bool isActive,
    required VoidCallback onToggle,
  }) {
    return NeobrutalistCard(
      backgroundColor: AppColors.cardWhite,
      borderRadius: 14,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            child: Center(
              child: Icon(icon, size: 20, color: AppColors.ink),
            ),
          ),
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
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 44,
              height: 24,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryContainer : AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: AppColors.border, width: 2),
              ),
              child: Align(
                alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: AppColors.ink,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalRow(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelMd()),
                Text(subtitle, style: AppTypography.bodySm()),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.ink),
        ],
      ),
    );
  }
}
