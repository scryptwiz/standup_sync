import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class AuthSectionDivider extends StatelessWidget {
  final String text;

  const AuthSectionDivider({super.key, this.text = 'OR CONTINUE WITH'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.lightGray, thickness: 1.2)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: AppColors.textTertiary,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.lightGray, thickness: 1.2)),
      ],
    );
  }
}
