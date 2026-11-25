import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class NeobrutalistBadge extends StatelessWidget {
  final String text;
  final Widget? icon;
  final Color backgroundColor;
  final Color textColor;
  final double borderWidth;
  final double shadowOffset;
  final Color shadowColor;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const NeobrutalistBadge({
    super.key,
    required this.text,
    this.icon,
    this.backgroundColor = AppColors.primaryContainer,
    this.textColor = AppColors.ink,
    this.borderWidth = 1.5,
    this.shadowOffset = 1.5,
    this.shadowColor = AppColors.ink,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(
          color: AppColors.border,
          width: borderWidth,
        ),
        boxShadow: shadowOffset > 0
            ? [
                BoxShadow(
                  color: shadowColor,
                  offset: Offset(shadowOffset, shadowOffset),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: AppTypography.labelSm(color: textColor),
          ),
        ],
      ),
    );

    if (onTap != null) {
      content = GestureDetector(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}
