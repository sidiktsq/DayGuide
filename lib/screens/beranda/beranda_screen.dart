import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_badge.dart';
import '../../providers/auth_provider.dart';
import '../../providers/guide_provider.dart';
import '../../providers/bookmark_provider.dart';
import '../../providers/theme_settings_provider.dart';
import '../panduan/detail_panduan_screen.dart';
import '../pencarian/pencarian_screen.dart';
import '../jelajah/detail_kategori_screen.dart';

class BerandaScreen extends StatelessWidget {
  final VoidCallback onNavigateToExplore;

  const BerandaScreen({super.key, required this.onNavigateToExplore});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final guideProvider = Provider.of<GuideProvider>(context);
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final settingsProvider = Provider.of<ThemeSettingsProvider>(context);

    final featured = guideProvider.featuredGuide;
    final popularList = guideProvider.popularGuides;
    final recentList = guideProvider.recentGuides;
    final categories = guideProvider.categories.take(4).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => guideProvider.refresh(),
          color: AppColors.ink,
          backgroundColor: AppColors.primaryContainer,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Header & Greeting
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Halo, ${authProvider.userName.isNotEmpty ? authProvider.userName.split(' ').first : 'Sobat'}!',
                              style: AppTypography.headlineLg(),
                            ),
                            const SizedBox(width: 6),
                            const Text('👋', style: TextStyle(fontSize: 22)),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Mau belajar apa hari ini?',
                          style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    // Avatar with badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border, width: 2.5),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.ink,
                                offset: Offset(2.5, 2.5),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(Icons.person, size: 28, color: AppColors.ink),
                          ),
                        ),
                        Positioned(
                          top: -3,
                          right: -3,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: AppColors.coral,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border, width: 1.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // 2. Search Bar Shortcut
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PencarianScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardWhite,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border, width: 2.5),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.ink,
                          offset: Offset(3, 3),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 22, color: AppColors.ink),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Cari panduan, tips, tutorial...',
                            style: AppTypography.bodyMd(
                              color: AppColors.onSurfaceVariant.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border, width: 1.5),
                          ),
                          child: const Icon(Icons.tune, size: 16, color: AppColors.ink),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 3. Featured Guide Card (Panduan Utama Pilihan)
                if (featured != null) ...[
                  NeobrutalistCard(
                    backgroundColor: AppColors.primaryContainer,
                    borderRadius: 18,
                    borderWidth: 3.0,
                    shadowOffset: 4.0,
                    padding: const EdgeInsets.all(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPanduanScreen(guideId: featured.id!),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.coral,
                                borderRadius: BorderRadius.circular(9999),
                                border: Border.all(color: AppColors.border, width: 1.5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.ink,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Text('🔥 ', style: TextStyle(fontSize: 12)),
                                  Text(
                                    'Paling Banyak Dibaca',
                                    style: AppTypography.labelSm(color: AppColors.ink),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.cardWhite,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.border, width: 1.5),
                              ),
                              child: Text(
                                'PILIHAN HARI INI',
                                style: AppTypography.labelSm(color: AppColors.ink),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          featured.title,
                          style: AppTypography.headlineMd(),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.cardWhite.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.border, width: 1.5),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.schedule, size: 14, color: AppColors.ink),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${featured.estimatedMinutes ?? 5} menit baca',
                                    style: AppTypography.labelSm(color: AppColors.ink),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.cardWhite.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.border, width: 1.5),
                              ),
                              child: Text(
                                featured.difficulty ?? 'Pemula',
                                style: AppTypography.labelSm(color: AppColors.ink),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.cardWhite.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.border, width: 1.5),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, size: 14, color: AppColors.coral),
                                  const SizedBox(width: 3),
                                  Text(
                                    '4.9',
                                    style: AppTypography.labelSm(color: AppColors.ink),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.only(top: 12),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: AppColors.border,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bebas utang, tabungan rapi.',
                                style: AppTypography.bodySm(color: AppColors.ink),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.cardWhite,
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
                                child: Row(
                                  children: [
                                    Text('Baca Sekarang', style: AppTypography.labelMd()),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.arrow_forward, size: 16, color: AppColors.ink),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                ],

                // 4. Kategori Populer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.border, width: 1.5),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Kategori Populer', style: AppTypography.headlineSm()),
                      ],
                    ),
                    GestureDetector(
                      onTap: onNavigateToExplore,
                      child: Row(
                        children: [
                          Text(
                            'Lihat Semua',
                            style: AppTypography.labelSm(color: AppColors.secondary),
                          ),
                          const Icon(Icons.chevron_right, size: 16, color: AppColors.secondary),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.45,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    Color cardColor = AppColors.mint;
                    if (index == 1) cardColor = AppColors.secondaryContainer;
                    if (index == 2) cardColor = AppColors.primaryContainer;
                    if (index == 3) cardColor = AppColors.coral;

                    return NeobrutalistCard(
                      backgroundColor: cardColor,
                      padding: const EdgeInsets.all(12),
                      borderRadius: 14,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailKategoriScreen(category: cat),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: AppColors.cardWhite,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.border, width: 2),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.ink,
                                      offset: Offset(1.5, 1.5),
                                      blurRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    _getCategoryIcon(cat.icon),
                                    size: 18,
                                    color: AppColors.ink,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.cardWhite.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(9999),
                                  border: Border.all(color: AppColors.border, width: 1.5),
                                ),
                                child: Text(
                                  '${30 + index * 6} Tips',
                                  style: AppTypography.labelSm(color: AppColors.ink),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cat.name,
                                style: AppTypography.labelMd(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                cat.description ?? '',
                                style: AppTypography.bodySm(color: AppColors.ink.withOpacity(0.8)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 22),

                // 5. Panduan Populer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.tertiary,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.border, width: 1.5),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Panduan Populer', style: AppTypography.headlineSm()),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: AppColors.border, width: 1.5),
                      ),
                      child: Text('Minggu Ini', style: AppTypography.labelSm()),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: popularList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final guide = popularList[index];
                    final isSaved = bookmarkProvider.isBookmarked(guide.id!);

                    return NeobrutalistCard(
                      backgroundColor: AppColors.cardWhite,
                      padding: const EdgeInsets.all(14),
                      borderRadius: 14,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPanduanScreen(guideId: guide.id!),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  NeobrutalistBadge(
                                    text: guide.categoryName ?? 'Panduan',
                                    backgroundColor: index % 2 == 0 ? AppColors.secondaryContainer : AppColors.lavender,
                                  ),
                                  const SizedBox(width: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.schedule, size: 14, color: AppColors.onSurfaceVariant),
                                      const SizedBox(width: 3),
                                      Text(
                                        '${guide.estimatedMinutes ?? 5} mnt',
                                        style: AppTypography.bodySm(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '• ${guide.difficulty ?? 'Pemula'}',
                                    style: AppTypography.bodySm(),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => bookmarkProvider.toggleBookmark(guide.id!),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: isSaved ? AppColors.primaryContainer : AppColors.surfaceContainer,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.border, width: 1.5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.ink,
                                        offset: Offset(1.5, 1.5),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                                    size: 18,
                                    color: isSaved ? AppColors.primary : AppColors.ink,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            guide.title,
                            style: AppTypography.headlineSm(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            guide.description ?? '',
                            style: AppTypography.bodySm(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(top: 8),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.surfaceContainerHigh,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: AppColors.mint,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColors.border, width: 1),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${(index + 1) * 1.5}k dibaca',
                                      style: AppTypography.labelSm(color: AppColors.ink),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Buka Panduan',
                                      style: AppTypography.labelMd(color: AppColors.secondary),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.arrow_forward, size: 16, color: AppColors.secondary),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 22),

                // 6. Baru Ditambahkan
                if (recentList.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border, width: 1.5),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('Baru Ditambahkan', style: AppTypography.headlineSm()),
                        ],
                      ),
                      Text('Update baru', style: AppTypography.bodySm()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  NeobrutalistCard(
                    backgroundColor: AppColors.cardWhite,
                    padding: const EdgeInsets.all(12),
                    borderRadius: 14,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPanduanScreen(guideId: recentList.first.id!),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.mint,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border, width: 2),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.ink,
                                offset: Offset(2, 2),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(Icons.recycling, size: 24, color: AppColors.ink),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  NeobrutalistBadge(
                                    text: '🌱 Lingkungan',
                                    backgroundColor: AppColors.surfaceContainer,
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    shadowOffset: 0,
                                  ),
                                  const SizedBox(width: 6),
                                  Text('⏱ 4 mnt', style: AppTypography.bodySm()),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                recentList.first.title,
                                style: AppTypography.labelMd(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                recentList.first.description ?? '',
                                style: AppTypography.bodySm(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 36,
                          height: 36,
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
                          child: const Icon(Icons.chevron_right, size: 20, color: AppColors.ink),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                ],

                // 7. Interactive Daily Tip Banner
                NeobrutalistCard(
                  backgroundColor: AppColors.secondaryFixed,
                  borderRadius: 14,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border, width: 1.5),
                        ),
                        child: const Center(
                          child: Text('💡', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tips Cepat Hari Ini',
                              style: AppTypography.labelSm(color: AppColors.onSecondaryContainer),
                            ),
                            Text(
                              'Tekan Win + V di keyboard untuk membuka riwayat Clipboard di laptopmu!',
                              style: AppTypography.bodySm(color: AppColors.onSecondaryContainer),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
      ),
    );
  }

  IconData _getCategoryIcon(String? icon) {
    switch (icon) {
      case 'cottage':
        return Icons.cottage;
      case 'devices':
        return Icons.devices;
      case 'payments':
        return Icons.payments;
      case 'health_and_safety':
        return Icons.health_and_safety;
      case 'home':
        return Icons.home;
      case 'recycling':
        return Icons.recycling;
      case 'school':
        return Icons.school;
      case 'security':
        return Icons.security;
      default:
        return Icons.category;
    }
  }
}
