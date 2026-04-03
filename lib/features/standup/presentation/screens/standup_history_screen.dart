import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';
import 'package:synk/core/data/dummy_data.dart';

class StandupHistoryScreen extends StatelessWidget {
  const StandupHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = DummyData.standups.reversed.toList(growable: false);

    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFFF5F7FB)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recording History',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Your casual standups, polished by AI and ready to ship.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textTertiary),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.separated(
                  itemCount: entries.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (BuildContext context, int index) {
                    final entry = entries[index];
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFDCE1E8)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x11000000),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                entry.person,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              Text(
                                entry.timeLabel,
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(color: AppColors.textTertiary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _HistoryBlock(
                            title: 'Raw Standup',
                            text: entry.rawVoiceText,
                            bg: const Color(0xFFF5F7FB),
                          ),
                          const SizedBox(height: 10),
                          _HistoryBlock(
                            title: 'AI Polished',
                            text: entry.polishedNote,
                            bg: const Color(0xFFE9F9FC),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryBlock extends StatelessWidget {
  final String title;
  final String text;
  final Color bg;

  const _HistoryBlock({
    required this.title,
    required this.text,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.darkGray,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
