import 'package:flutter/material.dart';
import 'package:synk/features/standup/presentation/widgets/animated_mic_button.dart';
import 'package:synk/features/standup/presentation/widgets/dark_gradient_shell.dart';
import 'package:synk/features/standup/presentation/widgets/greeting_header.dart';
import 'package:synk/features/standup/presentation/widgets/prompt_card.dart';
import 'package:synk/features/standup/presentation/widgets/stat_pills.dart';

class PreRecordingView extends StatefulWidget {
  final Future<void> Function() onStartRecording;

  const PreRecordingView({super.key, required this.onStartRecording});

  @override
  State<PreRecordingView> createState() => _PreRecordingViewState();
}

class _PreRecordingViewState extends State<PreRecordingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  static const List<String> _prompts = [
    'What did you accomplish today?',
    'Any blockers slowing you down?',
    'What\'s your focus for tomorrow?',
    'Share a quick win with the team!',
    'How can the team help you?',
  ];

  late final String _currentPrompt;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
    _currentPrompt = _prompts[DateTime.now().minute % _prompts.length];
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return DarkGradientShell(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              GreetingHeader(greeting: _greeting()),
              const Spacer(flex: 2),
              Center(
                child: AnimatedMicButton(
                  controller: _pulseController,
                  onTap: () => widget.onStartRecording(),
                ),
              ),
              const SizedBox(height: 28),
              Center(
                child: Text(
                  'Tap to record your standup',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              const StatPills(),
              const SizedBox(height: 24),
              PromptCard(prompt: _currentPrompt),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
