import 'package:flutter/material.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_headline.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_image.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_subtitle.dart';

class OnboardingStepVoice extends StatelessWidget {
  const OnboardingStepVoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnboardingHeadline(leadingText: "Voice to", trailingText: "Standups."),
        OnboardingSubtitle(
          text:
              "Simply speak your progress.\nWe'll turn your words into\norganized notes.",
        ),
        OnboardingImage(imagePath: "assets/onboarding/onboarding_1.png"),
      ],
    );
  }
}
