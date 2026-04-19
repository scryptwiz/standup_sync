// Applies root app.config.yaml into iOS xcconfig files (Expo-style workflow).
// Usage: dart run tool/apply_app_config.dart

import 'dart:io';

import 'package:yaml/yaml.dart';

void main() {
  final root = Directory.current.path;
  final configPath = '$root/app.config.yaml';
  final file = File(configPath);
  if (!file.existsSync()) {
    stderr.writeln('Missing app.config.yaml at project root.');
    exit(1);
  }

  final doc = loadYaml(file.readAsStringSync());
  if (doc is! YamlMap) {
    stderr.writeln('app.config.yaml must be a YAML map.');
    exit(1);
  }

  final ios = doc['ios'];
  final buffer = StringBuffer();

  if (ios is YamlMap) {
    final infoPlist = ios['info_plist'];
    if (infoPlist is YamlMap) {
      for (final entry in infoPlist.entries) {
        final rawKey = entry.key.toString();
        final value = _stringifyPlistValue(entry.value);
        final buildKey = rawKey.startsWith('INFOPLIST_KEY_')
            ? rawKey
            : 'INFOPLIST_KEY_$rawKey';
        final escaped = value.replaceAll(r'"', r'\"');
        buffer.writeln('$buildKey="$escaped"');
      }
    }
  }

  final android = doc['android'];
  if (android is YamlMap) {
    final extras = android['extra_permissions'];
    if (extras is YamlList && extras.isNotEmpty) {
      stderr.writeln(
        'android.extra_permissions is set but automatic AndroidManifest '
        'generation is not enabled. Add those permissions in your Android '
        'build setup or extend tool/apply_app_config.dart.',
      );
    }
  }

  const debugHeader = '''
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug.xcconfig"
#include "Generated.xcconfig"

''';

  const releaseHeader = '''
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.release.xcconfig"
#include "Generated.xcconfig"

''';

  File('$root/ios/Flutter/Debug.xcconfig')
      .writeAsStringSync('$debugHeader${buffer.toString()}');
  File('$root/ios/Flutter/Release.xcconfig')
      .writeAsStringSync('$releaseHeader${buffer.toString()}');

  stdout.writeln(
    'Applied app.config.yaml → ios/Flutter/Debug.xcconfig & Release.xcconfig',
  );
}

String _stringifyPlistValue(Object? value) {
  if (value == null) return '';
  if (value is String) return value;
  return value.toString();
}
