import 'package:flutter/material.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_headline.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_image.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_subtitle.dart';

class OnboardingStepRank extends StatelessWidget {
  const OnboardingStepRank({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnboardingImage(imagePath: "assets/onboarding/onboarding_3.png"),
        OnboardingHeadline(leadingText: "Claim Your", trailingText: "Glory"),
        OnboardingSubtitle(
          text:
              "Turn your consistency into tangible\nrewards. Unlock exclusive badges\nand milestones as you grow.",
          extraSpacing: 32,
        ),
      ],
    );
  }
}
