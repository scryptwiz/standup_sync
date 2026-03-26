import 'package:flutter/material.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_headline.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_image.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_subtitle.dart';

class OnboardingStepTask extends StatelessWidget {
  const OnboardingStepTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnboardingHeadline(leadingText: "Master Your\nTasks."),
        OnboardingSubtitle(
          text:
              "Keep your momentum high by\nmanaging your daily objectives. Every\ntick is a step closer to your goals.",
        ),
        OnboardingImage(
          imagePath: "assets/onboarding/onboarding_2.png",
          extraSpacing: 16,
        ),
      ],
    );
  }
}
