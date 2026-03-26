import 'package:flutter/material.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_button.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_step_rank.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_step_task.dart';
import 'package:synk/features/onboarding/presentation/widgets/onboarding_step_voice.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentStep = 0;
  static const int lastStep = 2;

  void nextStep() {
    if (currentStep < lastStep) {
      setState(() {
        currentStep++;
      });
    } else {
      // finish onboarding
    }
  }

  Widget getCurrentStepWidget() {
    switch (currentStep) {
      case 0:
        return OnboardingStepVoice();
      case 1:
        return OnboardingStepTask();
      default:
        return OnboardingStepRank();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: getCurrentStepWidget(),
            ),
            OnboardingButton(
              text: "Next",
              leadingIcon: Icons.arrow_forward_ios,
              onPressed: nextStep,
            ),
          ],
        ),
      ),
    );
  }
}
