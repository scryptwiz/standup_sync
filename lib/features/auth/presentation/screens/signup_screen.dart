import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synk/core/app_colors.dart';
import 'package:synk/core/constants/app_assets.dart';
import 'package:synk/core/constants/app_spacing.dart';
import 'package:synk/core/widgets/button.dart';
import 'package:synk/features/auth/presentation/screens/signin_screen.dart';
import 'package:synk/features/auth/presentation/widgets/auth_gradient_header.dart';
import 'package:synk/features/auth/presentation/widgets/auth_input.dart';
import 'package:synk/features/auth/presentation/widgets/auth_section_divider.dart';
import 'package:synk/features/auth/presentation/widgets/auth_third_party.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF7F8FA),
      child: Column(
        children: [
          const AuthTopGradientHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.authScreenPadding,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Let's Get Started",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.textPrimary,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacing.h4,
                      Text(
                        "Create an account to continue.",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textTertiary,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                      AppSpacing.h24,
                      const AuthInput(
                        placeholder: 'Username',
                        icon: Icons.person_outline,
                      ),
                      AppSpacing.h12,
                      const AuthInput(
                        placeholder: 'Email',
                        icon: Icons.email_outlined,
                      ),
                      AppSpacing.h12,
                      const AuthInput(
                        placeholder: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      AppSpacing.h24,
                      const Button(text: "Sign Up"),
                      AppSpacing.h24,
                      const AuthSectionDivider(),
                      AppSpacing.h24,
                      AuthThirdParty(
                        text: 'Continue with Google',
                        iconPath: AppAssets.logo('google.svg'),
                        onPressed: () {},
                      ),
                      AppSpacing.h12,
                      AuthThirdParty(
                        text: 'Continue with Apple',
                        iconPath: AppAssets.logo('apple.svg'),
                        onPressed: () {},
                      ),
                      AppSpacing.h12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textTertiary,
                              fontFamily: GoogleFonts.inter().fontFamily,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SigninScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(color: AppColors.navyMid),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
