import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Requests microphone access for standup recording. Returns true if granted.
Future<bool> ensureMicrophonePermission(BuildContext context) async {
  if (kIsWeb) {
    return true;
  }

  var status = await Permission.microphone.status;
  if (status.isGranted) return true;

  status = await Permission.microphone.request();
  if (status.isGranted) return true;

  if (!context.mounted) return false;

  if (status.isPermanentlyDenied) {
    final openSettings = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Microphone access'),
        content: const Text(
          'Synk needs the microphone to record your standup. '
          'You can turn it on in Settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Not now'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
    if (openSettings == true) {
      await openAppSettings();
    }
    return false;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Microphone permission is required to record.'),
    ),
  );
  return false;
}
