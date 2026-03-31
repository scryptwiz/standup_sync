import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synk/core/app_colors.dart';
import 'package:synk/core/constants/app_assets.dart';
import 'package:synk/core/constants/app_spacing.dart';
import 'package:synk/core/widgets/button.dart';
import 'package:synk/features/auth/presentation/screens/signup_screen.dart';
import 'package:synk/features/auth/presentation/widgets/auth_gradient_header.dart';
import 'package:synk/features/auth/presentation/widgets/auth_input.dart';
import 'package:synk/features/auth/presentation/widgets/auth_section_divider.dart';
import 'package:synk/features/auth/presentation/widgets/auth_third_party.dart';
import 'package:synk/core/utils/validators.dart';
import 'package:synk/utils/app_logger.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    setState(() {
      _emailError = Validators.email(_emailController.text);
      _passwordError = Validators.password(_passwordController.text);
    });
    return _emailError == null && _passwordError == null;
  }

  void signInWithEmail() async {
    if (!_validateInputs()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final res = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (res.user != null && mounted) {
        Console.log('User signed in: ${res.user}');
      }
    } on AuthException catch (e) {
      setState(() => _errorMessage = e.message);
    } catch (e) {
      setState(() => _errorMessage = 'Sign in failed: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.textPrimary,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacing.h4,
                      Text(
                        "Sign in to continue.",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textTertiary,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                      if (_errorMessage != null) ...[AppSpacing.h12],
                      if (_errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: Colors.red.shade800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      if (_errorMessage == null) ...[
                        AppSpacing.h24,
                      ] else ...[
                        AppSpacing.h12,
                      ],
                      AuthInput(
                        controller: _emailController,
                        placeholder: 'Email',
                        icon: Icons.email_outlined,
                        errorText: _emailError,
                        onChanged: (_) {
                          if (_emailError != null) {
                            setState(() => _emailError = null);
                          }
                        },
                      ),
                      AppSpacing.h12,
                      AuthInput(
                        controller: _passwordController,
                        placeholder: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                        errorText: _passwordError,
                        onChanged: (_) {
                          if (_passwordError != null) {
                            setState(() => _passwordError = null);
                          }
                        },
                      ),
                      AppSpacing.h24,
                      Button(
                        text: "Sign In",
                        isLoading: _isLoading,
                        loadingText: "Signing in...",
                        onPressed: signInWithEmail,
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
