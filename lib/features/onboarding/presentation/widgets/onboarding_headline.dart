import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synk/core/app_colors.dart';

class OnboardingHeadline extends StatelessWidget {
  final String leadingText;
  final String? trailingText;
  final bool isCentered;

  const OnboardingHeadline({
    super.key,
    required this.leadingText,
    this.trailingText,
    this.isCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCentered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          leadingText,
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 48,
            color: AppColors.textPrimary,
          ),
        ),
        if (trailingText != null)
          Text(
            trailingText!,
            textAlign: isCentered ? TextAlign.center : TextAlign.start,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 48,
              color: AppColors.textSecondary,
              fontFamily: GoogleFonts.manrope().fontFamily,
            ),
          ),
      ],
    );
  }
}
