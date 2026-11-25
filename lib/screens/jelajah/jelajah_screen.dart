import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_input.dart';
import '../../providers/guide_provider.dart';
import '../../data/models/category_model.dart';
import 'detail_kategori_screen.dart';

class JelajahScreen extends StatefulWidget {
  const JelajahScreen({super.key});

  @override
  State<JelajahScreen> createState() => _JelajahScreenState();
}

class _JelajahScreenState extends State<JelajahScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _activeChip = 'all'; // all, populer, baru, editor, sering

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final guideProvider = Provider.of<GuideProvider>(context);
    final allCategories = guideProvider.categories;

    // Filter categories based on search text and active chip
    final query = _searchController.text.toLowerCase().trim();
    List<CategoryModel> displayedCategories = allCategories.where((c) {
      if (query.isNotEmpty) {
        return c.name.toLowerCase().contains(query) ||
            (c.description?.toLowerCase().contains(query) ?? false);
      }
      return true;
    }).toList();

    if (_activeChip == 'populer') {
      displayedCategories = displayedCategories.take(4).toList();
    } else if (_activeChip == 'baru') {
      displayedCategories = displayedCategories.reversed.take(4).toList();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header context
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.folder_open, size: 16, color: AppColors.ink),
                    const SizedBox(width: 6),
                    Text(
                      'DIREKTORI TOPIK',
                      style: AppTypography.labelSm(color: AppColors.ink),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('Jelajah Kategori', style: AppTypography.headlineLg()),
              const SizedBox(height: 4),
              Text(
                'Temukan ratusan panduan praktis berdasarkan topik favoritmu',
                style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 16),

              // Search Input
              NeobrutalistInput(
                controller: _searchController,
                hintText: 'Cari kategori atau topik...',
                prefixIcon: const Icon(Icons.search, size: 22, color: AppColors.ink),
                onChanged: (val) => setState(() {}),
              ),
              const SizedBox(height: 14),

              // Filter Chips Carousel
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('Semua', 'all'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Populer 🔥', 'populer'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Baru ✨', 'baru'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Pilihan Editor 🎯', 'editor'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Tersering Dicari', 'sering'),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Category Grid (2 columns)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.95,
                ),
                itemCount: displayedCategories.length,
                itemBuilder: (context, index) {
                  final cat = displayedCategories[index];
                  final color = _getCategoryColor(cat.id ?? (index + 1));
                  final emoji = _getCategoryEmoji(cat.id ?? (index + 1));

                  return NeobrutalistCard(
                    backgroundColor: color,
                    padding: const EdgeInsets.all(12),
                    borderRadius: 14,
                    borderWidth: 2.5,
                    shadowOffset: 3.0,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: AppColors.cardWhite,
                                    borderRadius: BorderRadius.circular(10),
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
                                    child: Text(emoji, style: const TextStyle(fontSize: 18)),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.cardWhite.withOpacity(0.95),
                                    borderRadius: BorderRadius.circular(9999),
                                    border: Border.all(color: AppColors.border, width: 1.5),
                                  ),
                                  child: Text(
                                    '${20 + (cat.id ?? 1) * 6} Panduan',
                                    style: AppTypography.labelSm(color: AppColors.ink),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              cat.name,
                              style: AppTypography.labelLg(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cat.description ?? '',
                              style: AppTypography.bodySm(color: AppColors.ink.withOpacity(0.85)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 8),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppColors.border, width: 1.5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'EKSPLOR',
                                style: AppTypography.labelSm(color: AppColors.ink),
                              ),
                              const Icon(Icons.arrow_forward, size: 16, color: AppColors.ink),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Interactive Recommendation Quiz Hero Banner
              NeobrutalistCard(
                backgroundColor: AppColors.primaryContainer,
                borderRadius: 16,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.cardWhite,
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.quiz, size: 14, color: AppColors.tertiary),
                          const SizedBox(width: 4),
                          Text(
                            'PANDUAN CERDAS',
                            style: AppTypography.labelSm(color: AppColors.ink),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Bingung mulai dari mana?',
                      style: AppTypography.headlineMd(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ikuti kuis 30 detik untuk menemukan paket panduan harian yang dirancang khusus untuk kebutuhanmu.',
                      style: AppTypography.bodyMd(color: AppColors.ink.withOpacity(0.9)),
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.ink,
                            content: Text(
                              'Fitur kuis cerdas rekomendasi aktif!',
                              style: AppTypography.bodyMd(color: AppColors.cardWhite),
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border, width: 2.5),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.ink,
                              offset: Offset(3, 3),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Kuis Rekomendasi Panduan', style: AppTypography.labelMd()),
                            const SizedBox(width: 6),
                            const Icon(Icons.arrow_forward, size: 18, color: AppColors.ink),
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

  Widget _buildFilterChip(String label, String value) {
    final isActive = _activeChip == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _activeChip = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
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
            color: isActive ? AppColors.surface : AppColors.ink,
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(int id) {
    switch (id) {
      case 1:
        return AppColors.mint; // Kehidupan Sehari-hari
      case 2:
        return AppColors.secondaryContainer; // Teknologi
      case 3:
        return AppColors.primaryContainer; // Keuangan
      case 4:
        return AppColors.coral; // Kesehatan
      case 5:
        return AppColors.lavender; // Rumah
      case 6:
        return AppColors.paleGreen; // Lingkungan
      case 7:
        return AppColors.softYellow; // Pendidikan
      case 8:
        return AppColors.softRed; // Keselamatan
      default:
        return AppColors.mint;
    }
  }

  String _getCategoryEmoji(int id) {
    switch (id) {
      case 1:
        return '☕';
      case 2:
        return '💻';
      case 3:
        return '💰';
      case 4:
        return '🥗';
      case 5:
        return '🏡';
      case 6:
        return '🌱';
      case 7:
        return '📚';
      case 8:
        return '🦺';
      default:
        return '📖';
    }
  }
}
