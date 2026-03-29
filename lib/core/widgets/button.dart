import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synk/core/app_colors.dart';

enum AppButtonVariant { filled, outline }

enum AppButtonIconPosition { leading, trailing }

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  // New props
  final AppButtonVariant variant;
  final IconData? icon;
  final Widget? customIcon;
  final AppButtonIconPosition iconPosition;
  final MainAxisAlignment contentAlignment;
  final double iconSpacing;

  // Optional style overrides
  final Color? outlineColor;
  final Color? outlineBackgroundColor;
  final Color? foregroundColor;

  const Button({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.icon,
    this.customIcon,
    this.iconPosition = AppButtonIconPosition.leading,
    this.contentAlignment = MainAxisAlignment.center,
    this.iconSpacing = 10,
    this.outlineColor,
    this.outlineBackgroundColor,
    this.foregroundColor,
  }) : assert(
         icon == null || customIcon == null,
         'Use either icon or customIcon, not both.',
       );

  @override
  Widget build(BuildContext context) {
    final bool isOutline = variant == AppButtonVariant.outline;

    final Color effectiveForeground =
        foregroundColor ?? (isOutline ? AppColors.textPrimary : Colors.white);

    final Widget textWidget = Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontFamily: GoogleFonts.inter().fontFamily,
        fontWeight: FontWeight.w600,
      ),
    );

    final Widget? iconWidget =
        customIcon ?? (icon != null ? Icon(icon, size: 20) : null);

    final List<Widget> rowChildren = [
      if (iconWidget != null && iconPosition == AppButtonIconPosition.leading)
        iconWidget,
      if (iconWidget != null && iconPosition == AppButtonIconPosition.leading)
        SizedBox(width: iconSpacing),
      textWidget,
      if (iconWidget != null && iconPosition == AppButtonIconPosition.trailing)
        SizedBox(width: iconSpacing),
      if (iconWidget != null && iconPosition == AppButtonIconPosition.trailing)
        iconWidget,
    ];

    final Widget content = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: contentAlignment,
      children: rowChildren,
    );

    if (isOutline) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onPressed ?? () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: effectiveForeground,
            backgroundColor: outlineBackgroundColor ?? const Color(0xFFF5F5F5),
            minimumSize: const Size(double.infinity, 56),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            side: BorderSide(
              color: outlineColor ?? const Color(0xFFD1D5DB),
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: content,
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
            transform: GradientRotation(0.7853981634),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: onPressed ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: effectiveForeground,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          child: content,
        ),
      ),
    );
  }
}
