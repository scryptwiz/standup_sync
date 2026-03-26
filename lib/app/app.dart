import 'package:flutter/material.dart';
import 'package:synk/app/theme/app_theme.dart';
import 'package:synk/features/onboarding/presentation/screens/onboarding_screen.dart';

class SynkApp extends StatelessWidget {
  const SynkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Synk',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const OnboardingScreen(),
    );
  }
}
