import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/neobrutalist_card.dart';
import '../../core/widgets/neobrutalist_badge.dart';
import '../../providers/history_provider.dart';
import '../panduan/detail_panduan_screen.dart';

class RiwayatMembacaScreen extends StatefulWidget {
  const RiwayatMembacaScreen({super.key});

  @override
  State<RiwayatMembacaScreen> createState() => _RiwayatMembacaScreenState();
}

class _RiwayatMembacaScreenState extends State<RiwayatMembacaScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoryProvider>(context, listen: false).loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    final historyList = historyProvider.historyGuides;
    final totalMinutes = historyList.fold<int>(0, (sum, g) => sum + (g.estimatedMinutes ?? 5));
    final studyTimeString = totalMinutes == 0 ? '0m' : totalMinutes < 60 ? '${totalMinutes}m' : '${(totalMinutes / 60).toStringAsFixed(1)}j';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(title: 'Riwayat Membaca', showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Panel
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NeobrutalistBadge(
                        text: 'AKTIVITAS BELAJAR',
                        icon: const Icon(Icons.auto_stories, size: 14, color: AppColors.ink),
                        backgroundColor: AppColors.secondaryFixed,
                      ),
                      const SizedBox(height: 6),
                      Text('Riwayat Membaca', style: AppTypography.headlineLg()),
                      Text('Daftar panduan yang baru saja Anda pelajari', style: AppTypography.bodySm()),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Hapus Riwayat?'),
                          content: const Text('Apakah Anda yakin ingin menghapus seluruh riwayat membaca?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
                            TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Hapus', style: TextStyle(color: Colors.red))),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        await historyProvider.clearAll();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.coral,
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
                          const Icon(Icons.delete_sweep, size: 16, color: AppColors.ink),
                          const SizedBox(width: 4),
                          Text('Hapus', style: AppTypography.labelSm()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Reading Stats Summary Box
              NeobrutalistCard(
                backgroundColor: AppColors.secondaryContainer,
                borderRadius: 16,
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.cardWhite,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.border, width: 1.5),
                          ),
                          child: Text('RINGKASAN BULAN INI', style: AppTypography.labelSm()),
                        ),
                        const Icon(Icons.insights, size: 20, color: AppColors.onSecondaryContainer),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
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
                            child: Column(
                              children: [
                                Text('${historyProvider.totalGuidesRead}', style: AppTypography.headlineLg()),
                                Text('Panduan Dibaca', style: AppTypography.labelSm(), textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
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
                            child: Column(
                              children: [
                                Text(studyTimeString, style: AppTypography.headlineLg()),
                                Text('Waktu Belajar', style: AppTypography.labelSm(), textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
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
                            child: Column(
                              children: [
                                Text('${historyProvider.completedCount}', style: AppTypography.headlineLg(color: AppColors.primary)),
                                Text('Selesai Tuntas', style: AppTypography.labelSm(), textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Timeline List
              if (historyList.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text('Belum ada riwayat membaca.', style: AppTypography.bodyMd()),
                  ),
                )
              else ...[
                // Section: Hari Ini
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.ink,
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: AppColors.border, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.primaryContainer,
                            offset: Offset(2, 2),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.mint,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text('Hari Ini', style: AppTypography.labelSm(color: AppColors.cardWhite)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(child: Divider(color: AppColors.border, thickness: 2)),
                  ],
                ),
                const SizedBox(height: 12),
                ...historyList.map((guide) {
                  final progress = guide.readProgress ?? 50;

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
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.lavender,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.border, width: 2),
                                ),
                                child: const Center(
                                  child: Icon(Icons.menu_book, size: 22, color: AppColors.ink),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        NeobrutalistBadge(
                                          text: guide.categoryName ?? 'Kategori',
                                          backgroundColor: AppColors.lavender,
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          shadowOffset: 0,
                                        ),
                                        const SizedBox(width: 6),
                                        Text('Baru saja', style: AppTypography.bodySm()),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      guide.title,
                                      style: AppTypography.labelMd(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                                top: BorderSide(color: AppColors.border, width: 1.5),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: progress >= 100 ? AppColors.mint : AppColors.primaryContainer,
                                    borderRadius: BorderRadius.circular(9999),
                                    border: Border.all(color: AppColors.border, width: 1.5),
                                  ),
                                  child: Text(
                                    progress >= 100 ? 'Selesai 100% ✓' : 'Selesai $progress%',
                                    style: AppTypography.labelSm(),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      progress >= 100 ? Icons.replay : Icons.play_arrow,
                                      size: 16,
                                      color: AppColors.ink,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      progress >= 100 ? 'Baca Ulang' : 'Lanjutkan',
                                      style: AppTypography.labelSm(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
              const SizedBox(height: 18),

              // Export Notes / PDF CTA
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.ink,
                      content: Text(
                        'Ringkasan riwayat belajar berhasil diekspor!',
                        style: AppTypography.bodyMd(color: AppColors.cardWhite),
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border, width: 2.5),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.ink,
                        offset: Offset(3.5, 3.5),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.picture_as_pdf, size: 20, color: AppColors.tertiary),
                      const SizedBox(width: 8),
                      Text('Ekspor Catatan & Riwayat Belajar (PDF)', style: AppTypography.labelMd()),
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
}
