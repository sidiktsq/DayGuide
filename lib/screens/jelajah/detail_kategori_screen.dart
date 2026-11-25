import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_badge.dart';
import '../../core/widgets/neobrutalist_input.dart';
import '../../data/models/category_model.dart';
import '../../data/models/guide_model.dart';
import '../../providers/guide_provider.dart';
import '../../providers/bookmark_provider.dart';
import '../panduan/detail_panduan_screen.dart';

class DetailKategoriScreen extends StatefulWidget {
  final CategoryModel category;

  const DetailKategoriScreen({super.key, required this.category});

  @override
  State<DetailKategoriScreen> createState() => _DetailKategoriScreenState();
}

class _DetailKategoriScreenState extends State<DetailKategoriScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<GuideModel> _categoryGuides = [];
  bool _isLoading = true;
  String _activeFilter = 'all'; // all, popular, duration, bookmarked

  @override
  void initState() {
    super.initState();
    _loadGuides();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadGuides() async {
    final guideProvider = Provider.of<GuideProvider>(context, listen: false);
    final guides = await guideProvider.getGuidesByCategory(widget.category.id!);
    if (mounted) {
      setState(() {
        _categoryGuides = guides;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);

    // Filter by search and chips
    final query = _searchController.text.toLowerCase().trim();
    List<GuideModel> displayedGuides = _categoryGuides.where((g) {
      if (query.isNotEmpty) {
        return g.title.toLowerCase().contains(query) ||
            (g.description?.toLowerCase().contains(query) ?? false);
      }
      return true;
    }).toList();

    if (_activeFilter == 'bookmarked') {
      displayedGuides = displayedGuides.where((g) => bookmarkProvider.isBookmarked(g.id!)).toList();
    } else if (_activeFilter == 'duration') {
      displayedGuides.sort((a, b) => (a.estimatedMinutes ?? 0).compareTo(b.estimatedMinutes ?? 0));
    }

    final catColor = _parseColor(widget.category.color);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppTopBar(
        title: 'Detail Kategori',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, size: 22, color: AppColors.ink),
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
              // 1. Category Hero Banner
              NeobrutalistCard(
                backgroundColor: catColor,
                borderRadius: 18,
                borderWidth: 3.0,
                shadowOffset: 4.0,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.category, size: 14, color: AppColors.tertiary),
                              const SizedBox(width: 4),
                              Text(
                                'KATEGORI ESENSIAL',
                                style: AppTypography.labelSm(color: AppColors.ink),
                              ),
                            ],
                          ),
                        ),
                        const Text('☕ ☀️', style: TextStyle(fontSize: 22)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.category.name,
                      style: AppTypography.headlineLg(),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.category.description ??
                          'Koleksi panduan praktis untuk mempermudah rutinitas, efisiensi waktu, dan meningkatkan kualitas hidup harian Anda.',
                      style: AppTypography.bodyMd(color: AppColors.ink.withOpacity(0.9)),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.ink,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.menu_book, size: 16, color: AppColors.primaryContainer),
                          const SizedBox(width: 6),
                          Text(
                            '${_categoryGuides.length} Panduan',
                            style: AppTypography.labelSm(color: AppColors.cardWhite),
                          ),
                          const SizedBox(width: 8),
                          const Text('•', style: TextStyle(color: Colors.white54)),
                          const SizedBox(width: 8),
                          const Icon(Icons.group, size: 16, color: AppColors.mint),
                          const SizedBox(width: 6),
                          Text(
                            '12.4k Pembaca',
                            style: AppTypography.labelSm(color: AppColors.cardWhite),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 2. Search & Filter Bar
              NeobrutalistInput(
                controller: _searchController,
                hintText: 'Cari dalam kategori ini...',
                prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.ink),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.tune, size: 18, color: AppColors.onSurfaceVariant),
                  onPressed: () {},
                ),
                onChanged: (val) => setState(() {}),
              ),
              const SizedBox(height: 12),

              // Filter pills carousel
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterPill('Tingkat: Semua', 'all'),
                    const SizedBox(width: 8),
                    _buildFilterPill('Urutkan: Terpopuler 🔥', 'popular'),
                    const SizedBox(width: 8),
                    _buildFilterPill('Durasi ⏱', 'duration'),
                    const SizedBox(width: 8),
                    _buildFilterPill('Tersimpan 🔖', 'bookmarked'),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 3. List of Available Guides
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: AppColors.ink))
              else if (displayedGuides.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        const Icon(Icons.search_off, size: 48, color: AppColors.onSurfaceVariant),
                        const SizedBox(height: 12),
                        Text('Belum ada panduan yang cocok.', style: AppTypography.headlineSm()),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayedGuides.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final guide = displayedGuides[index];
                    final isSaved = bookmarkProvider.isBookmarked(guide.id!);

                    return NeobrutalistCard(
                      backgroundColor: AppColors.cardWhite,
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
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: index % 2 == 0 ? AppColors.primaryContainer : AppColors.mint,
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
                                child: Center(
                                  child: Icon(
                                    index % 2 == 0 ? Icons.timer : Icons.restaurant,
                                    size: 22,
                                    color: AppColors.ink,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    NeobrutalistBadge(
                                      text: widget.category.name,
                                      backgroundColor: AppColors.lavender,
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      shadowOffset: 0,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      guide.title,
                                      style: AppTypography.headlineSm(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => bookmarkProvider.toggleBookmark(guide.id!),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: isSaved ? AppColors.primaryContainer : AppColors.cardWhite,
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
                                  child: Icon(
                                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                                    size: 20,
                                    color: isSaved ? AppColors.primary : AppColors.ink,
                                  ),
                                ),
                              ),
                            ],
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
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainer,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: AppColors.border, width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.schedule, size: 13, color: AppColors.ink),
                                      const SizedBox(width: 3),
                                      Text('${guide.estimatedMinutes ?? 5} mnt', style: AppTypography.labelSm()),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryContainer,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: AppColors.border, width: 1),
                                  ),
                                  child: Text(
                                    guide.difficulty ?? 'Pemula',
                                    style: AppTypography.labelSm(color: AppColors.ink),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainer,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: AppColors.border, width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star, size: 13, color: AppColors.primary),
                                      const SizedBox(width: 2),
                                      Text('4.9', style: AppTypography.labelSm()),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${(index + 1) * 2.1}k baca',
                                  style: AppTypography.bodySm(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              const SizedBox(height: 20),

              // Pagination Indicator
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: AppColors.border, width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Menampilkan ${displayedGuides.length} dari ${_categoryGuides.length} panduan',
                        style: AppTypography.bodySm(),
                      ),
                    ],
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

  Widget _buildFilterPill(String label, String value) {
    final isActive = _activeFilter == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeFilter = value;
        });
      },
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

  Color _parseColor(String? colorHex) {
    if (colorHex == null) return AppColors.mint;
    try {
      final hex = colorHex.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return AppColors.mint;
    }
  }
}
