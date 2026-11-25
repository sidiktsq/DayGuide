import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_badge.dart';
import '../../core/widgets/neobrutalist_button.dart';
import '../../data/models/guide_model.dart';
import '../../providers/guide_provider.dart';
import '../../providers/bookmark_provider.dart';
import '../../providers/history_provider.dart';

class DetailPanduanScreen extends StatefulWidget {
  final int guideId;

  const DetailPanduanScreen({super.key, required this.guideId});

  @override
  State<DetailPanduanScreen> createState() => _DetailPanduanScreenState();
}

class _DetailPanduanScreenState extends State<DetailPanduanScreen> {
  GuideModel? _guide;
  bool _isLoading = true;
  bool _isTOCOpen = true;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _fetchDetail();
  }

  Future<void> _fetchDetail() async {
    final guideProvider = Provider.of<GuideProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);

    final guide = await guideProvider.getGuideDetail(widget.guideId);
    if (mounted) {
      setState(() {
        _guide = guide;
        _isLoading = false;
        _isCompleted = (guide?.readProgress ?? 0) >= 100;
      });

      // Record reading history progress (e.g. at least 25% on open if not read yet)
      if (guide != null && (guide.readProgress == null || guide.readProgress == 0)) {
        historyProvider.recordProgress(widget.guideId, 25);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context);

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.ink)),
      );
    }

    if (_guide == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: const AppTopBar(title: 'Detail Panduan', showBackButton: true),
        body: const Center(child: Text('Panduan tidak ditemukan.')),
      );
    }

    final isSaved = bookmarkProvider.isBookmarked(_guide!.id!);
    final steps = _guide!.steps ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppTopBar(
        title: 'Detail Panduan',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, size: 22, color: AppColors.ink),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.ink,
                  content: Text('Tautan panduan berhasil disalin!', style: AppTypography.bodyMd(color: AppColors.cardWhite)),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top reading progress indicator
            Container(
              height: 4,
              width: double.infinity,
              color: AppColors.surfaceContainerHigh,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _isCompleted ? 1.0 : 0.65,
                child: Container(color: AppColors.primaryContainer),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Hero Header & Metadata Card
                    NeobrutalistCard(
                      backgroundColor: AppColors.cardWhite,
                      borderRadius: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NeobrutalistBadge(
                                text: _guide!.categoryName ?? 'Keuangan Pribadi',
                                icon: const Text('💰', style: TextStyle(fontSize: 14)),
                                backgroundColor: AppColors.primaryContainer,
                              ),
                              GestureDetector(
                                onTap: () => bookmarkProvider.toggleBookmark(_guide!.id!),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: isSaved ? AppColors.primaryContainer : AppColors.surfaceContainerLow,
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
                          const SizedBox(height: 12),
                          Text(
                            _guide!.title,
                            style: AppTypography.headlineLg(),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.border, width: 1.5),
                                ),
                                child: Center(
                                  child: Text('DG', style: AppTypography.labelSm()),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Tim Finansial DAYGUIDE • Terverifikasi Ahli',
                                  style: AppTypography.bodySm(color: AppColors.onSurfaceVariant),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainer,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.border, width: 1),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.schedule, size: 15, color: AppColors.primary),
                                    const SizedBox(width: 4),
                                    Text('${_guide!.estimatedMinutes ?? 5} Menit Baca', style: AppTypography.bodySm()),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainer,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.border, width: 1),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.bar_chart, size: 15, color: AppColors.secondary),
                                    const SizedBox(width: 4),
                                    Text('Tingkat: ${_guide!.difficulty ?? 'Pemula'}', style: AppTypography.bodySm()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 2. Chunky Diagram Visual Card (if finance guide or general preview)
                    if (_guide!.id == 1) ...[
                      NeobrutalistCard(
                        backgroundColor: AppColors.secondaryContainer,
                        borderRadius: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'RASIO FINANSIAL IDEAL',
                                      style: AppTypography.labelSm(color: AppColors.onSecondaryContainer),
                                    ),
                                    Text(
                                      'Proporsi Alokasi Bulanan',
                                      style: AppTypography.headlineSm(color: AppColors.onSecondaryContainer),
                                    ),
                                  ],
                                ),
                                const Icon(Icons.pie_chart, size: 28, color: AppColors.onSecondaryContainer),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Visual bar
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.surface.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.border, width: 1.5),
                              ),
                              padding: const EdgeInsets.all(2),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 50,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryContainer,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Center(
                                        child: Text('50%', style: AppTypography.labelSm()),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Expanded(
                                    flex: 30,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.cardWhite,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Center(
                                        child: Text('30%', style: AppTypography.labelSm()),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Expanded(
                                    flex: 20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.tertiaryContainer,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Center(
                                        child: Text('20%', style: AppTypography.labelSm(color: AppColors.onTertiaryContainer)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            // 3 Micro Cards
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.cardWhite,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.border, width: 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('50%', style: AppTypography.labelMd()),
                                        Text('Kebutuhan Pokok', style: AppTypography.bodySm()),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.cardWhite,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.border, width: 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('30%', style: AppTypography.labelMd()),
                                        Text('Keinginan', style: AppTypography.bodySm()),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.cardWhite,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.border, width: 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('20%', style: AppTypography.labelMd(color: AppColors.tertiary)),
                                        Text('Tabungan', style: AppTypography.bodySm()),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // 3. Table of Contents (Daftar Isi)
                    NeobrutalistCard(
                      backgroundColor: AppColors.surfaceContainerLow,
                      borderRadius: 14,
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _isTOCOpen = !_isTOCOpen),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.menu_book, size: 20, color: AppColors.primary),
                                    const SizedBox(width: 8),
                                    Text('Daftar Isi Panduan', style: AppTypography.labelLg()),
                                  ],
                                ),
                                Icon(
                                  _isTOCOpen ? Icons.expand_less : Icons.expand_more,
                                  color: AppColors.ink,
                                ),
                              ],
                            ),
                          ),
                          if (_isTOCOpen) ...[
                            const SizedBox(height: 10),
                            const Divider(color: AppColors.border, thickness: 1),
                            ...steps.map((st) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryContainer,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColors.border, width: 1),
                                      ),
                                      child: Center(
                                        child: Text('${st.stepNumber}', style: AppTypography.labelSm()),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        st.title,
                                        style: AppTypography.bodySm(color: AppColors.onSurface),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 4. Step-by-Step Instructions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Langkah Penerapan', style: AppTypography.headlineSm()),
                        Text('${steps.length} Langkah Utama', style: AppTypography.bodySm()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...steps.map((step) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: NeobrutalistCard(
                          backgroundColor: AppColors.cardWhite,
                          borderRadius: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: step.stepNumber % 2 == 1
                                          ? AppColors.primaryContainer
                                          : AppColors.secondaryContainer,
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
                                      child: Text(
                                        '0${step.stepNumber}',
                                        style: AppTypography.headlineSm(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      step.title,
                                      style: AppTypography.labelLg(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                step.content,
                                style: AppTypography.bodyMd(),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.border, width: 1.5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.lightbulb, size: 18, color: AppColors.primary),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        'Tips: Konsistensi adalah kunci utama keberhasilan langkah ini.',
                                        style: AppTypography.bodySm(),
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
                    const SizedBox(height: 10),

                    // 5. Sources & Trusted References
                    NeobrutalistCard(
                      backgroundColor: AppColors.surfaceContainerLow,
                      borderRadius: 14,
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.account_balance, size: 18, color: AppColors.onSurfaceVariant),
                              const SizedBox(width: 6),
                              Text('Sumber & Referensi Tepercaya', style: AppTypography.labelMd()),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _guide!.source ?? 'Otoritas Jasa Keuangan & Tim Ahli DAYGUIDE',
                            style: AppTypography.bodySm(color: AppColors.secondary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 6. Action Button: Tandai Selesai Dibaca
                    NeobrutalistButton(
                      width: double.infinity,
                      height: 52,
                      backgroundColor: _isCompleted ? AppColors.mint : AppColors.primaryContainer,
                      onPressed: () async {
                        setState(() {
                          _isCompleted = !_isCompleted;
                        });
                        await historyProvider.recordProgress(
                          widget.guideId,
                          _isCompleted ? 100 : 50,
                        );
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.ink,
                              content: Text(
                                _isCompleted ? '✓ Panduan selesai dipelajari!' : 'Status panduan diperbarui!',
                                style: AppTypography.bodyMd(color: AppColors.cardWhite),
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isCompleted ? Icons.check_circle : Icons.task_alt,
                            size: 22,
                            color: AppColors.ink,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isCompleted ? 'Telah Selesai Dibaca ✓' : 'Tandai Selesai Dibaca ✓',
                            style: AppTypography.headlineSm(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
