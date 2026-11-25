import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const AppTopBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBack,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.95),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 2),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              if (showBackButton)
                GestureDetector(
                  onTap: onBack ?? () => Navigator.of(context).maybePop(),
                  child: Container(
                    width: 38,
                    height: 38,
                    margin: const EdgeInsets.only(right: 12),
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
                    child: const Icon(Icons.arrow_back, size: 20, color: AppColors.ink),
                  ),
                )
              else
                Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(right: 10),
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
                  child: const Center(
                    child: Icon(Icons.menu_book, size: 20, color: AppColors.ink),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DAYGUIDE',
                      style: AppTypography.labelSm(color: AppColors.primary),
                    ),
                    Text(
                      title,
                      style: AppTypography.headlineSm(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (actions != null) ...actions!,
            ],
          ),
        ),
      ),
    );
  }
}
