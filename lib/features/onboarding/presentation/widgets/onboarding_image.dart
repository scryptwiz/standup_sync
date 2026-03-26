import 'package:flutter/material.dart';

class OnboardingImage extends StatelessWidget {
  final String imagePath;
  final double extraSpacing;

  const OnboardingImage({
    super.key,
    required this.imagePath,
    this.extraSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 32, bottom: 16 + extraSpacing),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
