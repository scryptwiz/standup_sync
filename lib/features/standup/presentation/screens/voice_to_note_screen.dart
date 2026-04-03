import 'package:flutter/material.dart';
import 'package:synk/features/standup/presentation/widgets/pre_recording_view.dart';
import 'package:synk/features/standup/presentation/widgets/recording_view.dart';

enum VoiceCaptureState { preRecording, recording }

class VoiceToNoteScreen extends StatefulWidget {
  const VoiceToNoteScreen({super.key});

  @override
  State<VoiceToNoteScreen> createState() => _VoiceToNoteScreenState();
}

class _VoiceToNoteScreenState extends State<VoiceToNoteScreen> {
  VoiceCaptureState _state = VoiceCaptureState.preRecording;

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      VoiceCaptureState.preRecording => PreRecordingView(
          onStartRecording: () =>
              setState(() => _state = VoiceCaptureState.recording),
        ),
      VoiceCaptureState.recording => RecordingView(
          onStopRecording: () =>
              setState(() => _state = VoiceCaptureState.preRecording),
        ),
    };
  }
}
