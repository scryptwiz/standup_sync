import 'package:flutter/material.dart';
import 'package:synk/features/standup/presentation/widgets/animated_waveform.dart';
import 'package:synk/features/standup/presentation/widgets/dark_gradient_shell.dart';
import 'package:synk/features/standup/presentation/widgets/live_draft_card.dart';
import 'package:synk/features/standup/presentation/widgets/recording_pill.dart';
import 'package:synk/features/standup/presentation/widgets/recording_timer.dart';
import 'package:synk/features/standup/presentation/widgets/stop_button.dart';

class RecordingView extends StatefulWidget {
  final String elapsedFormatted;
  final VoidCallback onStopRecording;

  const RecordingView({
    super.key,
    required this.elapsedFormatted,
    required this.onStopRecording,
  });

  @override
  State<RecordingView> createState() => _RecordingViewState();
}

class _RecordingViewState extends State<RecordingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DarkGradientShell(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            // Recording pill
            const Center(child: RecordingPill()),
            const SizedBox(height: 20),
            // Timer
            Center(child: RecordingTimer(elapsed: widget.elapsedFormatted)),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Listening…',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const Spacer(flex: 2),
            // Animated waveform
            AnimatedWaveform(controller: _waveController),
            const Spacer(flex: 2),
            // Stop button
            Center(
              child: StopButton(onTap: widget.onStopRecording),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Tap to stop',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(flex: 1),
            // Live draft card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LiveDraftCard(
                transcript:
                    '"Just finished the architecture review for the '
                    'Synk dashboard. We\'re moving away from traditional '
                    'grid systems to more kinetic layouts…"',
                aiStatus:
                    'Analysing updates regarding team velocity…',
                progress: 0.64,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
