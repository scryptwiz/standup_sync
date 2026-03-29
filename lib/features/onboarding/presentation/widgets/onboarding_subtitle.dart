import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synk/core/app_colors.dart';

class OnboardingSubtitle extends StatelessWidget {
  final String text;
  final double extraSpacing;
  final bool isCentered;

  const OnboardingSubtitle({
    super.key,
    required this.text,
    this.extraSpacing = 0,
    this.isCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: extraSpacing),
      child: Text(
        text,
        textAlign: isCentered ? TextAlign.center : TextAlign.start,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textSubheadline,
          fontSize: 18,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      ),
    );
  }
}
