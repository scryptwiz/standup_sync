import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class OnboardingButton extends StatelessWidget {
  final String text;
  final IconData? leadingIcon;
  final VoidCallback? onPressed;

  const OnboardingButton({
    super.key,
    required this.text,
    this.leadingIcon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: const TextStyle(fontSize: 18)),
              if (leadingIcon != null) ...[
                const SizedBox(width: 8),
                Icon(leadingIcon, size: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
