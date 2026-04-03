import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class RecordingTimer extends StatelessWidget {
  final String elapsed;

  const RecordingTimer({super.key, required this.elapsed});

  @override
  Widget build(BuildContext context) {
    return Text(
      elapsed,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        letterSpacing: 4,
        shadows: [
          Shadow(
            color: AppColors.tealAccent.withValues(alpha: 0.4),
            blurRadius: 20,
          ),
        ],
      ),
    );
  }
}
