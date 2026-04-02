import 'package:flutter/material.dart';
import 'package:synk/core/constants/app_copy.dart';
import 'package:synk/core/data/dummy_data.dart';

class TaskTrackerScreen extends StatelessWidget {
  const TaskTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = DummyData.tasks;
    final int totalPoints = tasks
        .where((task) => task.isDone)
        .fold(0, (sum, task) => sum + task.points);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Task Streak',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              AppCopy.tasksHeadline,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Today\'s XP'),
                    Text(
                      '$totalPoints pts',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: tasks.length,
                separatorBuilder: (_, index) => const SizedBox(height: 10),
                itemBuilder: (BuildContext context, int index) {
                  final task = tasks[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        task.isDone
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: task.isDone ? Colors.green : null,
                      ),
                      title: Text(task.title),
                      subtitle: Text('${task.dueLabel} • ${task.points} pts'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
