import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class AnimatedWaveform extends StatelessWidget {
  final AnimationController controller;

  const AnimatedWaveform({super.key, required this.controller});

  static const List<double> _baseHeights = <double>[
    18,
    30,
    22,
    52,
    72,
    90,
    110,
    90,
    72,
    52,
    22,
    30,
    18,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < _baseHeights.length; i++)
                _WaveBar(
                  index: i,
                  baseHeight: _baseHeights[i],
                  progress: controller.value,
                  total: _baseHeights.length,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _WaveBar extends StatelessWidget {
  final int index;
  final double baseHeight;
  final double progress;
  final int total;

  const _WaveBar({
    required this.index,
    required this.baseHeight,
    required this.progress,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    // Each bar oscillates with a phase offset so they wave in sequence.
    final double phase = (progress * 2 * 3.14159) + (index * 0.55);
    final double sinValue = _sin(phase);
    // Height swings ±35% of base
    final double height = baseHeight + (baseHeight * 0.35 * sinValue);

    // The centre bars glow brighter teal, outer bars are dimmer.
    final double distFromCentre = ((index - total / 2).abs() / (total / 2))
        .clamp(0.0, 1.0);
    final Color barColor = Color.lerp(
      AppColors.tealAccent,
      AppColors.tealAccent.withValues(alpha: 0.25),
      distFromCentre,
    )!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.5),
      child: Container(
        width: 5,
        height: height.clamp(8.0, 160.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          color: barColor,
          boxShadow: distFromCentre < 0.4
              ? [
                  BoxShadow(
                    color: AppColors.tealAccent.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  /// Simple sine approximation to avoid importing dart:math in the widget.
  static double _sin(double x) {
    // Normalize to [-π, π]
    x = x % (2 * 3.14159);
    if (x > 3.14159) x -= 2 * 3.14159;
    // Bhaskara approximation
    final double abs = x < 0 ? -x : x;
    final double result =
        (16 * abs * (3.14159 - abs)) / (49.348 - 4 * abs * (3.14159 - abs));
    return x < 0 ? -result : result;
  }
}
