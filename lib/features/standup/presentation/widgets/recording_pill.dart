import 'package:flutter/material.dart';

class RecordingPill extends StatefulWidget {
  const RecordingPill({super.key});

  @override
  State<RecordingPill> createState() => _RecordingPillState();
}

class _RecordingPillState extends State<RecordingPill>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _opacityAnim = Tween<double>(begin: 1.0, end: 0.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4444).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: const Color(0xFFFF4444).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _opacityAnim,
            builder: (context, child) {
              return Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 68, 68, _opacityAnim.value),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFFFF4444,
                      ).withValues(alpha: _opacityAnim.value * 0.5),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          Text(
            'RECORDING',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: const Color(0xFFFF6B6B),
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
