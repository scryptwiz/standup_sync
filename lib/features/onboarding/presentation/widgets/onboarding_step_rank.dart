import 'package:flutter/material.dart';
import 'package:synk/core/constants/app_assets.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_headline.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_image.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_subtitle.dart';

class OnboardingStepRank extends StatelessWidget {
  const OnboardingStepRank({super.key});

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
            OnboardingImage(
              imagePath: AppAssets.folder("onboarding", "onboarding_3.svg"),
              isSvg: true,
            ),
            OnboardingHeadline(
              leadingText: "Claim Your",
              trailingText: "Glory",
            ),
            const SizedBox(height: 12),
            OnboardingSubtitle(
              text:
                  "Turn your consistency into tangible\nrewards. Unlock exclusive badges\nand milestones as you grow.",
            ),
          ],
        ),
      ),
    );
  }
}
