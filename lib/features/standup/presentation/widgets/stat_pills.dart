import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class StatPills extends StatelessWidget {
  const StatPills({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _pill(context, Icons.timer_outlined, '~2 min'),
        const SizedBox(width: 10),
        _pill(context, Icons.auto_awesome_rounded, '85% AI'),
        const SizedBox(width: 10),
        _pill(context, Icons.bar_chart_rounded, '12 standups'),
      ],
    );
  }

  Widget _pill(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.glassWhite08,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: AppColors.glassWhite12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.tealAccent),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
