import 'package:flutter/material.dart';

class GreetingHeader extends StatelessWidget {
  final String greeting;
  const GreetingHeader({super.key, required this.greeting});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Ready to sync up?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
