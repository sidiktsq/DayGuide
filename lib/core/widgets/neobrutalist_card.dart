import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeobrutalistCard extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double shadowOffset;
  final Color shadowColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const NeobrutalistCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.cardWhite,
    this.borderColor = AppColors.border,
    this.borderWidth = 2.5,
    this.borderRadius = 16,
    this.shadowOffset = 3.5,
    this.shadowColor = AppColors.ink,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  State<NeobrutalistCard> createState() => _NeobrutalistCardState();
}

class _NeobrutalistCardState extends State<NeobrutalistCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double offset = _isPressed ? 1.0 : widget.shadowOffset;
    final double translate = _isPressed ? (widget.shadowOffset - 1.0) : 0.0;

    Widget content = Transform.translate(
      offset: Offset(translate, translate),
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor,
              offset: Offset(offset, offset),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: widget.padding ?? const EdgeInsets.all(16),
        child: widget.child,
      ),
    );

    if (widget.onTap != null) {
      content = GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }

    if (widget.margin != null) {
      content = Padding(padding: widget.margin!, child: content);
    }

    return content;
  }
}
