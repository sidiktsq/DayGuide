import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_badge.dart';
import '../../providers/bookmark_provider.dart';
import '../panduan/detail_panduan_screen.dart';

class TersimpanScreen extends StatefulWidget {
  const TersimpanScreen({super.key});

  @override
  State<TersimpanScreen> createState() => _TersimpanScreenState();
}

class _TersimpanScreenState extends State<TersimpanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookmarkProvider>(context, listen: false).loadBookmarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final bookmarkedGuides = bookmarkProvider.filteredGuides;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppTopBar(
        title: 'Tersimpan',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, size: 22, color: AppColors.ink),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen Header & Statistics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.ink,
                              offset: Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.bookmark, size: 18, color: AppColors.ink),
                      ),
                      const SizedBox(width: 8),
                      Text('Panduan Tersimpan', style: AppTypography.headlineLg()),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: AppColors.border, width: 2),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.tune, size: 14, color: AppColors.ink),
                        const SizedBox(width: 4),
                        Text('Kelola', style: AppTypography.labelSm()),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '${bookmarkProvider.bookmarkedGuides.length} panduan tersimpan untuk dibaca nanti',
                    style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('Tersedia offline', style: AppTypography.labelSm()),
                ],
              ),
              const SizedBox(height: 16),

              // Filter Pills Bar
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterPill('Semua (${bookmarkProvider.bookmarkedGuides.length})', 'all', bookmarkProvider),
                    const SizedBox(width: 8),
                    _buildFilterPill('Belum Selesai', 'unread', bookmarkProvider),
                    const SizedBox(width: 8),
                    _buildFilterPill('Selesai Dibaca', 'completed', bookmarkProvider),
                    const SizedBox(width: 8),
                    _buildFilterPill('Favorit ⭐', 'favorite', bookmarkProvider),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Collection Folders Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.folder_special, size: 18, color: AppColors.ink),
                      const SizedBox(width: 6),
                      Text('FOLDER KATEGORI', style: AppTypography.labelMd()),
                    ],
                  ),
                  Text('3 Folder Aktif', style: AppTypography.bodySm()),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFolderCard('📂', 'Belajar Mandiri', 'Skill & Habit', '6', AppColors.primaryContainer),
                    const SizedBox(width: 10),
                    _buildFolderCard('📂', 'Finansial 2025', 'Tabungan & Budget', '5', AppColors.secondaryContainer),
                    const SizedBox(width: 10),
                    _buildFolderCard('📂', 'Perawatan Rumah', 'DIY & Servis', '3', AppColors.tertiaryContainer),
                    const SizedBox(width: 10),
                    Container(
                      width: 130,
                      height: 90,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 2, style: BorderStyle.solid),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.create_new_folder, size: 24, color: AppColors.ink),
                          const SizedBox(height: 4),
                          Text('+ Folder Baru', style: AppTypography.labelSm()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Bookmarks Stream Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.view_agenda, size: 18, color: AppColors.ink),
                      const SizedBox(width: 6),
                      Text('DAFTAR PANDUAN', style: AppTypography.labelMd()),
                    ],
                  ),
                  Text('Terakhir Ditambahkan', style: AppTypography.bodySm()),
                ],
              ),
              const SizedBox(height: 12),

              if (bookmarkProvider.isLoading)
                const Center(child: CircularProgressIndicator(color: AppColors.ink))
              else if (bookmarkedGuides.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        const Icon(Icons.bookmark_border, size: 48, color: AppColors.onSurfaceVariant),
                        const SizedBox(height: 8),
                        Text('Belum ada panduan tersimpan.', style: AppTypography.headlineSm()),
                        const SizedBox(height: 4),
                        Text('Simpan panduan favoritmu agar mudah dibaca kapan saja offline.', style: AppTypography.bodySm(), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bookmarkedGuides.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final guide = bookmarkedGuides[index];
                    final progress = guide.readProgress ?? 0;

                    return NeobrutalistCard(
                      backgroundColor: progress >= 100 ? const Color(0xFFF7FEE7) : AppColors.cardWhite,
                      padding: const EdgeInsets.all(14),
                      borderRadius: 16,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border, width: 2),
                                ),
                                child: Center(
                                  child: Icon(
                                    guide.categoryId == 3 ? Icons.savings : Icons.devices,
                                    size: 26,
                                    color: AppColors.ink,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        NeobrutalistBadge(
                                          text: '${guide.categoryName ?? 'Kategori'} • ${guide.estimatedMinutes ?? 5} Mnt',
                                          backgroundColor: AppColors.lavender,
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          shadowOffset: 0,
                                        ),
                                        GestureDetector(
                                          onTap: () => bookmarkProvider.toggleBookmark(guide.id!),
                                          child: Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryContainer,
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
                                            child: const Icon(Icons.bookmark, size: 18, color: AppColors.primary),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      guide.title,
                                      style: AppTypography.headlineSm(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Progress Bar & Action Row
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: AppColors.border, width: 1.5, style: BorderStyle.solid),
                              ),
                            ),
                            child: progress >= 100
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.mint,
                                          borderRadius: BorderRadius.circular(9999),
                                          border: Border.all(color: AppColors.border, width: 1.5),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.check_circle, size: 14, color: AppColors.ink),
                                            const SizedBox(width: 4),
                                            Text('Selesai dibaca ✓', style: AppTypography.labelSm()),
                                          ],
                                        ),
                                      ),
                                      Text('Baca Ulang ↺', style: AppTypography.labelMd()),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.auto_stories, size: 14, color: AppColors.ink),
                                              const SizedBox(width: 4),
                                              Text('Progress Baca', style: AppTypography.labelSm()),
                                            ],
                                          ),
                                          Text('$progress% Selesai', style: AppTypography.labelSm(color: AppColors.primary)),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: AppColors.surfaceContainer,
                                          borderRadius: BorderRadius.circular(9999),
                                          border: Border.all(color: AppColors.border, width: 1.5),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: progress / 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryContainer,
                                              borderRadius: BorderRadius.circular(9999),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Tersisa beberapa langkah', style: AppTypography.bodySm()),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryContainer,
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
                                            child: Text('Lanjutkan →', style: AppTypography.labelSm()),
                                          ),
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
              const SizedBox(height: 18),

              // Offline Knowledge Tip Banner
              NeobrutalistCard(
                backgroundColor: AppColors.primaryContainer,
                borderRadius: 16,
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
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
                      child: const Center(
                        child: Icon(Icons.offline_pin, size: 24, color: AppColors.ink),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mode Offline Siap Sedia', style: AppTypography.labelMd()),
                          Text('Semua panduan di atas tersimpan lokal di SQLite dan bisa diakses tanpa internet.', style: AppTypography.bodySm()),
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
    );
  }

  Widget _buildFilterPill(String label, String value, BookmarkProvider provider) {
    final isActive = provider.currentFilter == value;

    return GestureDetector(
      onTap: () => provider.setFilter(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.ink : AppColors.cardWhite,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: AppColors.border, width: 2),
          boxShadow: [
            BoxShadow(
              color: isActive ? AppColors.primaryContainer : AppColors.ink,
              offset: const Offset(2, 2),
              blurRadius: 0,
            ),
          ],
        ),
        child: Text(
          label,
          style: AppTypography.labelSm(
            color: isActive ? AppColors.cardWhite : AppColors.ink,
          ),
        ),
      ),
    );
  }

  Widget _buildFolderCard(String emoji, String title, String subtitle, String count, Color countBg) {
    return Container(
      width: 130,
      height: 90,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 2.5),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 18)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: countBg,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                child: Text(count, style: AppTypography.labelSm()),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.labelSm(), maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(subtitle, style: AppTypography.bodySm(color: AppColors.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }
}
