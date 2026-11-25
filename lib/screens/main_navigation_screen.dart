import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import 'beranda/beranda_screen.dart';
import 'jelajah/jelajah_screen.dart';
import 'tersimpan/tersimpan_screen.dart';
import 'profil/profil_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      BerandaScreen(onNavigateToExplore: () => switchTab(1)),
      const JelajahScreen(),
      const TersimpanScreen(),
      const ProfilScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.cardWhite,
          border: Border(
            top: BorderSide(color: AppColors.border, width: 2.5),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_outlined, Icons.home, 'Beranda'),
              _buildNavItem(1, Icons.explore_outlined, Icons.explore, 'Jelajah'),
              _buildNavItem(2, Icons.bookmark_border, Icons.bookmark, 'Tersimpan'),
              _buildNavItem(3, Icons.person_outline, Icons.person, 'Profil'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => switchTab(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppColors.border, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 22,
              color: isSelected ? AppColors.ink : AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: isSelected
                  ? AppTypography.labelSm(color: AppColors.ink)
                  : AppTypography.bodySm(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
