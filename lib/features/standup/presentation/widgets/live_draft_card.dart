import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class LiveDraftCard extends StatelessWidget {
  final String transcript;
  final String aiStatus;
  final double progress;

  const LiveDraftCard({
    super.key,
    required this.transcript,
    required this.aiStatus,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.glassWhite08,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassWhite12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.tealAccent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 14,
                      color: AppColors.tealAccent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Live Draft',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.tealAccent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.glassWhite08,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.glassWhite12),
                ),
                child: Text(
                  'AI Optimized',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Transcript text
          Text(
            transcript,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          // AI processing status
          Text(
            aiStatus,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.tealAccent.withValues(alpha: 0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 14),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: AppColors.glassWhite12,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.tealAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
