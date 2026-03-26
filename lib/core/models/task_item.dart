class TaskItem {
  const TaskItem({
    required this.title,
    required this.points,
    required this.isDone,
    required this.dueLabel,
  });

  final String title;
  final int points;
  final bool isDone;
  final String dueLabel;
}
