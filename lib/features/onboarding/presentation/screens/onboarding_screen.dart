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
        return const OnboardingStepVoice();
      case 1:
        return const OnboardingStepTask();
      default:
        return const OnboardingStepRank();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(0.06, 0),
                      end: Offset.zero,
                    ).animate(animation);

                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey(currentStep),
                    child: getCurrentStepWidget(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OnboardingButton(
                text: currentStep < lastStep ? "Next" : "Get Started",
                leadingIcon: Icons.arrow_forward_ios,
                onPressed: nextStep,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
