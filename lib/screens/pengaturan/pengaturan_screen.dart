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

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 2.5),
        ),
        title: Text(title, style: AppTypography.headlineSm()),
        content: SingleChildScrollView(
          child: Text(content, style: AppTypography.bodyMd()),
        ),
        actions: [
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
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context, ThemeSettingsProvider settings) {
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
            const Icon(Icons.cleaning_services, color: AppColors.tertiary, size: 24),
            const SizedBox(width: 8),
            Text('Hapus Cache', style: AppTypography.headlineSm()),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus data sementara dan cache gambar (${settings.cacheSize})? Panduan tersimpan Anda tidak akan terhapus.',
          style: AppTypography.bodyMd(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: AppTypography.labelMd()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.tertiaryContainer,
              foregroundColor: AppColors.ink,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppColors.border, width: 1.5),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              settings.clearCache();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.ink,
                  content: Text('Cache berhasil dibersihkan (0.0 MB)!', style: AppTypography.bodyMd(color: AppColors.cardWhite)),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Bersihkan'),
          ),
        ],
      ),
    );
  }

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
          'Apakah Anda yakin ingin keluar dari akun? Setelah keluar, Anda wajib login kembali saat membuka aplikasi.',
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
              await auth.logout();
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
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<ThemeSettingsProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final bookmarks = Provider.of<BookmarkProvider>(context);
    final history = Provider.of<HistoryProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      onTap: () => settings.setThemeMode('dark'),
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
                          Text('Skala: ${(settings.fontScale * 100).toInt()}% • Real-time', style: AppTypography.bodySm()),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: settings.decreaseFontSize,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                children: [
                  const Icon(Icons.notifications_active, size: 18, color: AppColors.secondary),
                  const SizedBox(width: 6),
                  Text('NOTIFIKASI & PENGINGAT', style: AppTypography.labelMd()),
                ],
              ),
              const SizedBox(height: 10),
              _buildToggleItem(
                icon: Icons.lightbulb,
                iconBg: AppColors.primaryContainer,
                title: 'Tips Pagi Harian',
                subtitle: 'Ringkasan panduan praktis setiap jam 07.00 pagi',
                isActive: settings.dailyMorningTips,
                onToggle: settings.toggleDailyMorningTips,
              ),
              const SizedBox(height: 8),
              _buildToggleItem(
                icon: Icons.auto_awesome,
                iconBg: AppColors.mint,
                title: 'Rekomendasi Mingguan',
                subtitle: 'Kurasi topik pilihan editor setiap hari Senin',
                isActive: settings.weeklyRecommendations,
                onToggle: settings.toggleWeeklyRecommendations,
              ),
              const SizedBox(height: 8),
              _buildToggleItem(
                icon: Icons.alarm,
                iconBg: AppColors.lavender,
                title: 'Pengingat Membaca',
                subtitle: 'Alarm untuk melanjutkan panduan yang belum selesai',
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
                          Text('${settings.cacheSize} • File sementara & gambar', style: AppTypography.bodySm()),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showClearCacheDialog(context, settings),
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

              // SECTION 4: Akun & Sesi Pengguna
              Text('AKUN & SESI PENGGUNA', style: AppTypography.labelMd()),
              const SizedBox(height: 10),
              NeobrutalistCard(
                backgroundColor: AppColors.cardWhite,
                borderRadius: 14,
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.border, width: 2),
                          ),
                          child: const Center(
                            child: Icon(Icons.person, size: 26, color: AppColors.ink),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(auth.userName, style: AppTypography.headlineSm()),
                              Text(
                                auth.userEmail.isNotEmpty ? auth.userEmail : 'Akun Aktif • Level ${auth.userLevel}',
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
                      height: 46,
                      backgroundColor: AppColors.softRed,
                      onPressed: () => _showLogoutDialog(context, auth, bookmarks, history),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout, size: 18, color: AppColors.ink),
                          const SizedBox(width: 6),
                          Text('Keluar dari Akun (Logout)', style: AppTypography.labelMd(color: AppColors.ink)),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    _buildLegalRow(
                      'Kebijakan Privasi',
                      'Data Anda aman dan tidak dijual ke pihak ketiga',
                      onTap: () {
                        _showInfoDialog(
                          context,
                          'Kebijakan Privasi DAYGUIDE',
                          'DAYGUIDE berkomitmen melindungi privasi data setiap pengguna. Seluruh progres baca, panduan tersimpan, dan akun Anda disimpan secara aman di perangkat lokal dan cloud terenkripsi. Kami tidak membagikan atau menjual data pribadi kepada pihak ketiga mana pun.',
                        );
                      },
                    ),
                    const Divider(color: AppColors.border, thickness: 1),
                    _buildLegalRow(
                      'Syarat & Ketentuan Penggunaan',
                      'Ketentuan lisensi konten edukasi harian',
                      onTap: () {
                        _showInfoDialog(
                          context,
                          'Syarat & Ketentuan',
                          'Seluruh konten panduan, kurasi langkah, dan tips harian di DAYGUIDE disajikan untuk tujuan edukasi dan peningkatan produktivitas hidup sehari-hari. Pengguna bebas memanfaatkan materi panduan untuk keperluan personal non-komersial.',
                        );
                      },
                    ),
                    const Divider(color: AppColors.border, thickness: 1),
                    _buildLegalRow(
                      'Tentang DAYGUIDE (Versi 1.0.0)',
                      'Aplikasi panduan sehari-hari bergaya Modern Neobrutalisme',
                      onTap: () {
                        _showInfoDialog(
                          context,
                          'Tentang DAYGUIDE v1.0.0',
                          'DAYGUIDE adalah aplikasi panduan hidup sehari-hari yang dirancang dengan sistem desain Modern Neobrutalisme. Menyajikan tutorial finansial, teknologi, rumah tangga, kesehatan, dan kebiasaan produktif harian dalam langkah-langkah praktis dan terstruktur.',
                        );
                      },
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

  Widget _buildThemeOption({
    required String title,
    required String emoji,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
            else
              const SizedBox(height: 14),
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

  Widget _buildLegalRow(String title, String subtitle, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
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
      ),
    );
  }
}
