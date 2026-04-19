import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:synk/core/utils/microphone_permission.dart';
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
  /// Created only when the user starts recording so the native plugin is not
  /// invoked on the Record tab’s first frame (avoids startup crashes / missing
  /// plugin async errors before a full rebuild).
  AudioRecorder? _recorder;
  Timer? _elapsedTimer;
  Duration _elapsed = Duration.zero;
  bool _isStarting = false;

  String get _elapsedFormatted {
    final totalSeconds = _elapsed.inSeconds;
    final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _elapsedTimer?.cancel();
    unawaited(_tearDownRecorder());
    super.dispose();
  }

  Future<void> _tearDownRecorder() async {
    final recorder = _recorder;
    if (recorder == null) return;
    try {
      if (await recorder.isRecording()) {
        await recorder.stop();
      }
    } catch (_) {}
    await recorder.dispose();
    _recorder = null;
  }

  Future<void> _handleStartRecording() async {
    if (_isStarting) return;
    _isStarting = true;
    try {
      final permitted = await ensureMicrophonePermission(context);
      if (!permitted || !mounted) return;

      _recorder ??= AudioRecorder();
      // Waits on the plugin’s internal lock until native `create` finishes; surfaces
      // MissingPluginException here so it is caught below instead of as an unhandled async error.
      await _recorder!.hasPermission(request: false);

      late final String outputPath;
      if (kIsWeb) {
        outputPath = '';
      } else {
        final dir = await getTemporaryDirectory();
        outputPath =
            '${dir.path}/standup_${DateTime.now().millisecondsSinceEpoch}.m4a';
      }

      await _recorder!.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: outputPath,
      );

      if (!mounted) return;

      setState(() {
        _state = VoiceCaptureState.recording;
        _elapsed = Duration.zero;
      });

      _elapsedTimer?.cancel();
      _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {
          _elapsed += const Duration(seconds: 1);
        });
      });
    } on MissingPluginException catch (_) {
      _recorder = null;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Recording needs a full native rebuild: stop the app, run '
              'flutter clean && flutter run (not hot reload). iOS: cd ios && pod install.',
            ),
            duration: Duration(seconds: 8),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not start recording. Please try again.'),
          ),
        );
      }
    } finally {
      _isStarting = false;
    }
  }

  Future<void> _handleStopRecording() async {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
    final recorder = _recorder;
    if (recorder == null) return;
    try {
      await recorder.stop();
    } catch (_) {}
    if (!mounted) return;
    setState(() {
      _state = VoiceCaptureState.preRecording;
      _elapsed = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      VoiceCaptureState.preRecording => PreRecordingView(
          onStartRecording: _handleStartRecording,
        ),
      VoiceCaptureState.recording => RecordingView(
          elapsedFormatted: _elapsedFormatted,
          onStopRecording: _handleStopRecording,
        ),
    };
  }
}
