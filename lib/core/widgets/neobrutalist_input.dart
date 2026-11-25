import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class NeobrutalistInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final double borderRadius;
  final Color backgroundColor;

  const NeobrutalistInput({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.borderRadius = 14,
    this.backgroundColor = AppColors.cardWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.border, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: AppColors.ink,
            offset: Offset(3, 3),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Row(
        children: [
          if (prefixIcon != null) ...[
            prefixIcon!,
            const SizedBox(width: 8),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: AppTypography.bodyMd(),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTypography.bodyMd(color: AppColors.onSurfaceVariant.withOpacity(0.6)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}
