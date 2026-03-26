import 'package:flutter/material.dart';
import 'package:synk/core/constants/app_copy.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Feedback Rewriter',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              AppCopy.feedbackHeadline,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'Casual Input: "Hey, can we tighten the deadlines and make communication faster?"',
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'Professional Rewrite: "Could we align on tighter delivery timelines and establish a faster communication loop for better execution?"',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
