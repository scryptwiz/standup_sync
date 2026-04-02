import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synk/app/theme/app_theme.dart';
import 'package:synk/features/auth/state/auth_controller.dart';
import 'package:synk/features/home/presentation/screens/home_shell_screen.dart';
import 'package:synk/features/onboarding/presentation/screens/onboarding_screen.dart';

class SynkApp extends ConsumerWidget {
  const SynkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return MaterialApp(
      title: 'Synk',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: authState.isAuthenticated
          ? const HomeShellScreen()
          : const OnboardingScreen(),
    );
  }
}
