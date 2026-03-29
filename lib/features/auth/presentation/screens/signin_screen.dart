import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synk/core/app_colors.dart';
import 'package:synk/core/widgets/button.dart';
import 'package:synk/features/auth/presentation/screens/signup_screen.dart';
import 'package:synk/features/auth/presentation/widgets/auth_gradient_header.dart';
import 'package:synk/features/auth/presentation/widgets/auth_input.dart';
import 'package:synk/features/auth/presentation/widgets/auth_section_divider.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF7F8FA),
      child: Column(
        children: [
          const AuthTopGradientHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.textPrimary,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Sign in to continue.",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textTertiary,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const AuthInput(
                        placeholder: 'Email',
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 12),
                      const AuthInput(
                        placeholder: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      const SizedBox(height: 24),
                      const Button(text: "Sign In"),
                      const SizedBox(height: 24),
                      const AuthSectionDivider(),
                      const SizedBox(height: 24),
                      Button(
                        text: 'Continue with Google',
                        variant: AppButtonVariant.outline,
                        customIcon: const FaIcon(
                          FontAwesomeIcons.google,
                          size: 20,
                        ),
                        iconPosition: AppButtonIconPosition.leading,
                        contentAlignment: MainAxisAlignment.center,
                        iconSpacing: 12,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 12),
                      Button(
                        text: 'Continue with Apple',
                        variant: AppButtonVariant.outline,
                        customIcon: const FaIcon(
                          FontAwesomeIcons.apple,
                          size: 20,
                        ),
                        iconPosition: AppButtonIconPosition.leading,
                        contentAlignment: MainAxisAlignment.center,
                        iconSpacing: 12,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textTertiary,
                              fontFamily: GoogleFonts.inter().fontFamily,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
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
                              "Sign Up",
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
