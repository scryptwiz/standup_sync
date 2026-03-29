import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingImage extends StatelessWidget {
  final String imagePath;
  final double extraSpacing;
  final bool isSvg;

  const OnboardingImage({
    super.key,
    required this.imagePath,
    this.extraSpacing = 0,
    this.isSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 32, bottom: 16 + extraSpacing),
        child: isSvg
            ? SvgPicture.asset(imagePath, fit: BoxFit.contain)
            : Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
