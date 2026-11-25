import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class NeobrutalistButton extends StatefulWidget {
  final Widget? child;
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderWidth;
  final double borderRadius;
  final double shadowOffset;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const NeobrutalistButton({
    super.key,
    this.child,
    this.text,
    this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryContainer,
    this.textColor = AppColors.ink,
    this.borderWidth = 2.5,
    this.borderRadius = 14,
    this.shadowOffset = 3.0,
    this.padding,
    this.width,
    this.height = 48,
  });

  @override
  State<NeobrutalistButton> createState() => _NeobrutalistButtonState();
}

class _NeobrutalistButtonState extends State<NeobrutalistButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double offset = _isPressed ? 1.0 : widget.shadowOffset;
    final double translate = _isPressed ? (widget.shadowOffset - 1.0) : 0.0;

    return GestureDetector(
      onTapDown: widget.onPressed != null ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.onPressed != null ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: Transform.translate(
        offset: Offset(translate, translate),
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.onPressed == null ? AppColors.surfaceContainer : widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: AppColors.border,
              width: widget.borderWidth,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.ink,
                offset: Offset(offset, offset),
                blurRadius: 0,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: widget.child ??
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: 20, color: widget.textColor),
                      const SizedBox(width: 8),
                    ],
                    if (widget.text != null)
                      Text(
                        widget.text!,
                        style: AppTypography.labelMd(color: widget.textColor),
                      ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
