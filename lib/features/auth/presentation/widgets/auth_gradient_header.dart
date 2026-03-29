import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class AuthTopGradientHeader extends StatelessWidget {
  const AuthTopGradientHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double statusBarTop = MediaQuery.paddingOf(context).top;
    const double headerBodyHeight = 140;

    return ClipPath(
      clipper: const _HeaderCurveClipper(),
      child: SizedBox(
        height: statusBarTop + headerBodyHeight,
        width: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
              transform: GradientRotation(0.7853981634),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: statusBarTop - 12,
                left: -28,
                child: Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 28,
                top: statusBarTop + 6,
                child: Container(
                  width: 66,
                  height: 66,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: -12,
                child: Container(
                  width: 154,
                  height: 154,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCurveClipper extends CustomClipper<Path> {
  const _HeaderCurveClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path()
      ..lineTo(0, size.height - 70)
      ..cubicTo(
        size.width * 0.24,
        size.height - 46,
        size.width * 0.76,
        size.height - 46,
        size.width,
        size.height - 70,
      )
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant _HeaderCurveClipper oldClipper) {
    return false;
  }
}
