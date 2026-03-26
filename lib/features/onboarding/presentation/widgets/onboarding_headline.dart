import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class OnboardingHeadline extends StatelessWidget {
  final String leadingText;
  final String? trailingText;

  const OnboardingHeadline({
    super.key,
    required this.leadingText,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          leadingText,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 42,
            color: AppColors.textPrimary,
          ),
        ),
        if (trailingText != null)
          Text(
            trailingText!,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 42,
              color: AppColors.textSecondary,
            ),
          ),
      ],
    );
  }
}
