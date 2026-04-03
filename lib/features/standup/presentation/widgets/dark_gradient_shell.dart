import 'package:flutter/material.dart';

class DarkGradientShell extends StatelessWidget {
  final Widget child;
  const DarkGradientShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF04172C),
            Color(0xFF0A2540),
            Color(0xFF0D2D4A),
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: child,
    );
  }
}
