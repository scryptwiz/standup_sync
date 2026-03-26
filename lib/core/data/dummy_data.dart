import 'package:synk/core/models/standup_entry.dart';
import 'package:synk/core/models/task_item.dart';

class DummyData {
  static const List<StandupEntry> standups = <StandupEntry>[
    StandupEntry(
      person: 'Kelvin',
      rawVoiceText:
          'Fixed login thing, tested with Sarah, still one edge case on iOS.',
      polishedNote:
          'Completed authentication bug fixes and validated behavior with QA. One iOS edge case remains and is scheduled for resolution today.',
      timeLabel: '08:42 AM',
    ),
    StandupEntry(
      person: 'Amina',
      rawVoiceText:
          'Started docs for API and blockers are mostly around missing examples.',
      polishedNote:
          'Started API documentation and identified blockers related to missing request/response examples. Preparing draft examples for team review.',
      timeLabel: '09:15 AM',
    ),
  ];

  static const List<TaskItem> tasks = <TaskItem>[
    TaskItem(
      title: 'Record daily standup voice note',
      points: 10,
      isDone: true,
      dueLabel: 'Today',
    ),
    TaskItem(
      title: 'Rewrite client feedback with AI',
      points: 20,
      isDone: false,
      dueLabel: 'Today',
    ),
    TaskItem(
      title: 'Plan tomorrow priorities',
      points: 15,
      isDone: false,
      dueLabel: 'Tomorrow',
    ),
  ];
}
