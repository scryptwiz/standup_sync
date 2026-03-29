import 'package:flutter/material.dart';
import 'package:synk/core/constants/app_assets.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_headline.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_image.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_subtitle.dart';

class OnboardingStepVoice extends StatelessWidget {
  const OnboardingStepVoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnboardingHeadline(
              leadingText: "Voice to",
              trailingText: "Standups.",
            ),
            const SizedBox(height: 12),
            OnboardingSubtitle(
              text:
                  "Simply speak your progress.\nWe'll turn your words into\norganized notes.",
            ),
            OnboardingImage(
              imagePath: AppAssets.folder("onboarding", "onboarding_1.svg"),
              isSvg: true,
            ),
          ],
        ),
      ),
    );
  }
}
