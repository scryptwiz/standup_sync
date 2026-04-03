import 'package:flutter/material.dart';

class StopButton extends StatelessWidget {
  final VoidCallback onTap;

  const StopButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 108,
        height: 108,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFFF4444).withValues(alpha: 0.3),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF4444).withValues(alpha: 0.15),
              blurRadius: 24,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [Color(0xFFFF5555), Color(0xFFCC3333)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF4444).withValues(alpha: 0.35),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.stop_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
      ),
    );
  }
}
