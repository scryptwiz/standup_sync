class StandupEntry {
  const StandupEntry({
    required this.person,
    required this.rawVoiceText,
    required this.polishedNote,
    required this.timeLabel,
  });

  final String person;
  final String rawVoiceText;
  final String polishedNote;
  final String timeLabel;
}
