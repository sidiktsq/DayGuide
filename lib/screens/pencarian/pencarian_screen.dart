import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_badge.dart';
import '../../data/models/guide_model.dart';
import '../../providers/guide_provider.dart';
import '../panduan/detail_panduan_screen.dart';

class PencarianScreen extends StatefulWidget {
  const PencarianScreen({super.key});

  @override
  State<PencarianScreen> createState() => _PencarianScreenState();
}

class _PencarianScreenState extends State<PencarianScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? _selectedCategoryFilter;
  final List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _executeSearch('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _executeSearch(String query) {
    final guideProvider = Provider.of<GuideProvider>(context, listen: false);
    guideProvider.searchGuides(query, categoryId: _selectedCategoryFilter);
  }

  @override
  Widget build(BuildContext context) {
    final guideProvider = Provider.of<GuideProvider>(context);
    final results = guideProvider.searchResults;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(title: 'Pencarian', showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Search Header Input
              Container(
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 22, color: AppColors.ink),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: (val) {
                          if (val.trim().isNotEmpty && !_recentSearches.contains(val.trim())) {
                            setState(() => _recentSearches.insert(0, val.trim()));
                          }
                          _executeSearch(val);
                        },
                        style: AppTypography.bodyMd(),
                        decoration: InputDecoration(
                          hintText: 'Cari tips masak, gadget, uang...',
                          hintStyle: AppTypography.bodyMd(color: AppColors.onSurfaceVariant.withOpacity(0.6)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _executeSearch('');
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.close, size: 18, color: AppColors.ink),
                        ),
                      ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        final val = _searchController.text.trim();
                        if (val.isNotEmpty && !_recentSearches.contains(val)) {
                          setState(() => _recentSearches.insert(0, val));
                        }
                        _executeSearch(val);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                        child: Row(
                          children: [
                            Text('Cari', style: AppTypography.labelMd()),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_forward, size: 14, color: AppColors.ink),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // 2. Category Filter Chips (Horizontal Scroll)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryFilterChip(null, 'Semua Kategori'),
                    const SizedBox(width: 8),
                    _buildCategoryFilterChip(3, 'Keuangan'),
                    const SizedBox(width: 8),
                    _buildCategoryFilterChip(2, 'Teknologi'),
                    const SizedBox(width: 8),
                    _buildCategoryFilterChip(4, 'Kesehatan'),
                    const SizedBox(width: 8),
                    _buildCategoryFilterChip(1, 'Kehidupan Sehari-hari'),
                    const SizedBox(width: 8),
                    _buildCategoryFilterChip(7, 'Pendidikan'),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 3. Pencarian Populer (Trending Tags)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department, size: 20, color: AppColors.coral),
                      const SizedBox(width: 4),
                      Text('Pencarian Populer', style: AppTypography.headlineSm()),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('TREN HARI INI', style: AppTypography.labelSm(color: AppColors.onSurfaceVariant)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTrendingTag('🔥 Budgeting 50/30/20', 'Cara Mengatur Keuangan Bulanan'),
                  _buildTrendingTag('💻 Pasang SSD Laptop', 'laptop'),
                  _buildTrendingTag('📄 Bikin NPWP Online', 'KTP'),
                  _buildTrendingTag('🌱 Kompos Sampah Organik', 'sampah'),
                  _buildTrendingTag('😴 Tidur Nyenyak 8 Jam', 'bangun pagi'),
                ],
              ),
              const SizedBox(height: 20),

              // 4. Riwayat Pencarian Terakhir
              if (_recentSearches.isNotEmpty) ...[
                NeobrutalistCard(
                  backgroundColor: AppColors.surfaceContainerLow,
                  borderRadius: 14,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.history, size: 18, color: AppColors.ink),
                              const SizedBox(width: 6),
                              Text('Riwayat Terakhir', style: AppTypography.labelMd()),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _recentSearches.clear()),
                            child: Text(
                              'Hapus Semua Riwayat',
                              style: AppTypography.labelSm(color: AppColors.tertiary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ..._recentSearches.map((term) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.cardWhite,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.border, width: 1.5),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.schedule, size: 16, color: AppColors.onSurfaceVariant),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _searchController.text = term;
                                      _executeSearch(term);
                                    },
                                    child: Text(term, style: AppTypography.bodySm()),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() => _recentSearches.remove(term)),
                                  child: const Icon(Icons.close, size: 16, color: AppColors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // 5. Hasil Pencarian Terkait
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Hasil Pencarian', style: AppTypography.headlineSm()),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryContainer,
                          borderRadius: BorderRadius.circular(9999),
                          border: Border.all(color: AppColors.border, width: 1.5),
                        ),
                        child: Text('${results.length} Panduan', style: AppTypography.labelSm()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.tune, size: 16, color: AppColors.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text('Relevansi', style: AppTypography.labelSm(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              if (guideProvider.isLoading)
                const Center(child: CircularProgressIndicator(color: AppColors.ink))
              else if (results.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text('Tidak ada panduan yang sesuai kata kunci.', style: AppTypography.bodyMd()),
                  ),
                )
              else
                ...results.map((guide) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: NeobrutalistCard(
                      backgroundColor: AppColors.cardWhite,
                      padding: const EdgeInsets.all(12),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.border, width: 2),
                                ),
                                child: Center(
                                  child: Icon(
                                    guide.categoryId == 3
                                        ? Icons.account_balance_wallet
                                        : guide.categoryId == 2
                                            ? Icons.computer
                                            : Icons.article,
                                    size: 28,
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
                                          text: guide.categoryName ?? 'Kategori',
                                          backgroundColor: AppColors.primaryContainer,
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          shadowOffset: 0,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.verified, size: 14, color: AppColors.secondary),
                                            const SizedBox(width: 3),
                                            Text('Cocok', style: AppTypography.labelSm(color: AppColors.secondary)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      guide.title,
                                      style: AppTypography.labelLg(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.schedule, size: 14, color: AppColors.onSurfaceVariant),
                                        const SizedBox(width: 4),
                                        Text('${guide.estimatedMinutes ?? 5} mnt', style: AppTypography.bodySm()),
                                        const SizedBox(width: 10),
                                        Text('• ${guide.difficulty ?? 'Pemula'}', style: AppTypography.bodySm()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(top: 8),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: AppColors.border, width: 1.5, style: BorderStyle.solid),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Langkah terstruktur & praktis', style: AppTypography.bodySm()),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.border, width: 1.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Baca', style: AppTypography.labelSm(color: AppColors.cardWhite)),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.chevron_right, size: 14, color: AppColors.cardWhite),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              const SizedBox(height: 16),

              // 6. Request Guide Callout Card
              NeobrutalistCard(
                backgroundColor: AppColors.tertiaryContainer,
                borderRadius: 14,
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.cardWhite,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border, width: 2),
                      ),
                      child: const Center(
                        child: Icon(Icons.lightbulb, size: 22, color: AppColors.tertiary),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Belum nemu tips yang pas?', style: AppTypography.labelMd(color: AppColors.onTertiaryContainer)),
                          Text('Ajukan topik panduan yang kamu butuhkan!', style: AppTypography.bodySm(color: AppColors.onTertiaryContainer)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.tertiary,
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
                          Text('Ajukan', style: AppTypography.labelSm(color: AppColors.cardWhite)),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward, size: 14, color: AppColors.cardWhite),
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

  Widget _buildCategoryFilterChip(int? catId, String label) {
    final isSelected = _selectedCategoryFilter == catId;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryFilter = catId;
        });
        _executeSearch(_searchController.text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : AppColors.cardWhite,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: AppColors.border, width: 2),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: AppColors.ink,
                    offset: Offset(2, 2),
                    blurRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            if (isSelected) ...[
              const Icon(Icons.check, size: 14, color: AppColors.ink),
              const SizedBox(width: 4),
            ],
            Text(label, style: AppTypography.labelSm()),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingTag(String label, String searchQuery) {
    return GestureDetector(
      onTap: () {
        _searchController.text = searchQuery;
        if (!_recentSearches.contains(searchQuery)) {
          setState(() {
            _recentSearches.insert(0, searchQuery);
          });
        }
        _executeSearch(searchQuery);
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
        child: Text(label, style: AppTypography.bodySm()),
      ),
    );
  }
}
