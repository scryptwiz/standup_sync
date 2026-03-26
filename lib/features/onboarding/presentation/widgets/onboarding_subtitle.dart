import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class OnboardingSubtitle extends StatelessWidget {
  final String text;
  final double extraSpacing;

  const OnboardingSubtitle({
    super.key,
    required this.text,
    this.extraSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: extraSpacing),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textSubheadline,
          fontSize: 16,
        ),
      ),
    );
  }
}
