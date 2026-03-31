import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synk/core/constants/app_spacing.dart';
import 'package:synk/core/widgets/button.dart';

class AuthThirdParty extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback? onPressed;

  const AuthThirdParty({
    super.key,
    required this.text,
    required this.iconPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      text: text,
      variant: AppButtonVariant.outline,
      customIcon: SvgPicture.asset(iconPath, width: 20, height: 20),
      iconPosition: AppButtonIconPosition.leading,
      contentAlignment: MainAxisAlignment.center,
      iconSpacing: AppSpacing.sm,
      onPressed: onPressed,
    );
  }
}
