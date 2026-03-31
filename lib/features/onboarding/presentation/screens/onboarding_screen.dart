import 'package:flutter/material.dart';
import 'package:synk/core/constants/app_spacing.dart';
import 'package:synk/core/widgets/button.dart';
import 'package:synk/features/auth/presentation/screens/signin_screen.dart';
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
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextStep() {
    if (currentStep < lastStep) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SigninScreen()),
      );
    }
  }

  List<Widget> get _steps => const [
    OnboardingStepVoice(),
    OnboardingStepTask(),
    OnboardingStepRank(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.onboardingScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _steps.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentStep = index;
                    });
                  },
                  itemBuilder: (_, index) => _steps[index],
                ),
              ),
              AppSpacing.h12,
              Button(
                text: currentStep < lastStep ? "Next" : "Get Started",
                icon: Icons.arrow_forward_ios,
                iconPosition: AppButtonIconPosition.trailing,
                onPressed: nextStep,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
