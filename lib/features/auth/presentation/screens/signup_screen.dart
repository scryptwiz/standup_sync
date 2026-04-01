import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synk/core/app_colors.dart';
import 'package:synk/core/constants/app_assets.dart';
import 'package:synk/core/constants/app_spacing.dart';
import 'package:synk/core/utils/validators.dart';
import 'package:synk/core/widgets/button.dart';
import 'package:synk/core/widgets/form_error_banner.dart';
import 'package:synk/features/auth/presentation/screens/signin_screen.dart';
import 'package:synk/features/auth/presentation/widgets/auth_gradient_header.dart';
import 'package:synk/features/auth/presentation/widgets/auth_input.dart';
import 'package:synk/features/auth/presentation/widgets/auth_section_divider.dart';
import 'package:synk/features/auth/presentation/widgets/auth_third_party.dart';
import 'package:synk/utils/app_logger.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;
  String? usernameError;
  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool validateInputs() {
    setState(() {
      usernameError = Validators.username(_usernameController.text);
      emailError = Validators.email(_emailController.text);
      passwordError = Validators.fullPassword(_passwordController.text);
    });
    return usernameError == null && emailError == null && passwordError == null;
  }

  void signupWithEmail() async {
    if (!validateInputs()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final res = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        data: {'display_name': _usernameController.text.trim()},
      );

      if (res.user != null && mounted) {
        Console.log(res.user);
      }
    } on AuthException catch (e) {
      setState(() => errorMessage = e.message);
    } catch (e) {
      Console.error('Sign up failed: ${e.toString()}');
      setState(() => errorMessage = 'Sign up failed. ${e.toString()}');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

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
                      if (errorMessage != null) ...[AppSpacing.h12],
                      if (errorMessage != null)
                        FormErrorBanner(message: errorMessage!),
                      if (errorMessage == null) ...[
                        AppSpacing.h24,
                      ] else ...[
                        AppSpacing.h12,
                      ],
                      AuthInput(
                        controller: _usernameController,
                        placeholder: 'Username',
                        icon: Icons.person_outline,
                        errorText: usernameError,
                        onChanged: (_) {
                          if (usernameError != null) {
                            setState(() => usernameError = null);
                          }
                        },
                      ),
                      AppSpacing.h12,
                      AuthInput(
                        controller: _emailController,
                        placeholder: 'Email',
                        icon: Icons.email_outlined,
                        errorText: emailError,
                        onChanged: (_) {
                          if (emailError != null) {
                            setState(() => emailError = null);
                          }
                        },
                      ),
                      AppSpacing.h12,
                      AuthInput(
                        controller: _passwordController,
                        placeholder: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                        errorText: passwordError,
                        onChanged: (_) {
                          if (passwordError != null) {
                            setState(() => passwordError = null);
                          }
                        },
                      ),
                      AppSpacing.h24,
                      Button(
                        text: "Sign Up",
                        isLoading: isLoading,
                        onPressed: signupWithEmail,
                      ),
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
