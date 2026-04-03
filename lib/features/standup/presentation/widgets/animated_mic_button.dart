import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class AnimatedMicButton extends StatelessWidget {
  final AnimationController controller;
  final VoidCallback onTap;

  const AnimatedMicButton({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _SonarRingsPainter(
              progress: controller.value,
              ringColor: AppColors.tealAccent,
            ),
            child: child,
          );
        },
        child: Center(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [
                    Color(0xFF18E8DA),
                    Color(0xFF0F8B96),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.tealAccent.withValues(alpha: 0.35),
                    blurRadius: 32,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.mic_rounded,
                color: Colors.white,
                size: 44,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SonarRingsPainter extends CustomPainter {
  final double progress;
  final Color ringColor;

  _SonarRingsPainter({required this.progress, required this.ringColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const int ringCount = 3;
    final double maxRadius = size.width / 2;
    final double minRadius = 58.0;

    for (int i = 0; i < ringCount; i++) {
      final double phase = (progress + i / ringCount) % 1.0;
      final double radius = minRadius + (maxRadius - minRadius) * phase;
      final double opacity = (1.0 - phase).clamp(0.0, 0.45);

      final paint = Paint()
        ..color = ringColor.withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(_SonarRingsPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
